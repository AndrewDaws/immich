import AsyncLock from 'async-lock';
import { instanceToPlain, plainToInstance } from 'class-transformer';
import { validate } from 'class-validator';
import { load as loadYaml } from 'js-yaml';
import * as _ from 'lodash';
import { SystemConfig, defaults } from 'src/config';
import { SystemConfigDto } from 'src/dtos/system-config.dto';
import { DatabaseLock, SystemMetadataKey } from 'src/enum';
import { ConfigRepository } from 'src/repositories/config.repository';
import { LoggingRepository } from 'src/repositories/logging.repository';
import { SystemMetadataRepository } from 'src/repositories/system-metadata.repository';
import { DeepPartial } from 'src/types';
import { getKeysDeep, unsetDeep } from 'src/utils/misc';

export type SystemConfigValidator = (config: SystemConfig, newConfig: SystemConfig) => void | Promise<void>;

type RepoDeps = {
  configRepo: ConfigRepository;
  metadataRepo: SystemMetadataRepository;
  logger: LoggingRepository;
};

const asyncLock = new AsyncLock();
let config: SystemConfig | null = null;
let lastUpdated: number | null = null;

export const clearConfigCache = () => {
  config = null;
  lastUpdated = null;
};

export const getConfig = async (repos: RepoDeps, { withCache }: { withCache: boolean }): Promise<SystemConfig> => {
  if (!withCache || !config) {
    const timestamp = lastUpdated;
    await asyncLock.acquire(DatabaseLock[DatabaseLock.GetSystemConfig], async () => {
      if (timestamp === lastUpdated) {
        config = await buildConfig(repos);
        lastUpdated = Date.now();
      }
    });
  }

  return config!;
};

export const updateConfig = async (repos: RepoDeps, newConfig: SystemConfig): Promise<SystemConfig> => {
  const { metadataRepo } = repos;
  // get the difference between the new config and the default config
  const partialConfig: DeepPartial<SystemConfig> = {};
  for (const property of getKeysDeep(defaults)) {
    const newValue = _.get(newConfig, property);
    const isEmpty = newValue === undefined || newValue === null || newValue === '';
    const defaultValue = _.get(defaults, property);
    const isEqual = newValue === defaultValue || _.isEqual(newValue, defaultValue);

    if (isEmpty || isEqual) {
      continue;
    }

    _.set(partialConfig, property, newValue);
  }

  await metadataRepo.set(SystemMetadataKey.SystemConfig, partialConfig);

  return getConfig(repos, { withCache: false });
};

const loadFromFile = async ({ metadataRepo, logger }: RepoDeps, filepath: string) => {
  try {
    const file = await metadataRepo.readFile(filepath);
    return loadYaml(file.toString()) as unknown;
  } catch (error: Error | any) {
    logger.error(`Unable to load configuration file: ${filepath}`);
    logger.error(error);
    throw error;
  }
};

const buildConfig = async (repos: RepoDeps) => {
  const { configRepo, metadataRepo, logger } = repos;
  const { configFile } = configRepo.getEnv();

  // load partial
  const partial = configFile
    ? await loadFromFile(repos, configFile)
    : await metadataRepo.get(SystemMetadataKey.SystemConfig);

  // merge with defaults
  const rawConfig = _.cloneDeep(defaults);
  for (const property of getKeysDeep(partial)) {
    _.set(rawConfig, property, _.get(partial, property));
  }

  // check for extra properties
  const unknownKeys = _.cloneDeep(rawConfig);
  for (const property of getKeysDeep(defaults)) {
    unsetDeep(unknownKeys, property);
  }

  if (!_.isEmpty(unknownKeys)) {
    logger.warn(`Unknown keys found: ${JSON.stringify(unknownKeys, null, 2)}`);
  }

  // validate full config
  const instance = plainToInstance(SystemConfigDto, rawConfig);
  const errors = await validate(instance);
  if (errors.length > 0) {
    if (configFile) {
      throw new Error(`Invalid value(s) in file: ${errors}`);
    } else {
      logger.error('Validation error', errors);
    }
  }

  // return config with class-transform changes
  const config = instanceToPlain(instance) as SystemConfig;

  if (config.server.externalDomain.length > 0) {
    const domain = new URL(config.server.externalDomain);

    let externalDomain = domain.origin;
    if (domain.password && domain.username) {
      externalDomain = `${domain.protocol}//${domain.username}:${domain.password}@${domain.host}`;
    }

    config.server.externalDomain = externalDomain;
  }

  if (!config.ffmpeg.acceptedVideoCodecs.includes(config.ffmpeg.targetVideoCodec)) {
    config.ffmpeg.acceptedVideoCodecs.push(config.ffmpeg.targetVideoCodec);
  }

  if (!config.ffmpeg.acceptedAudioCodecs.includes(config.ffmpeg.targetAudioCodec)) {
    config.ffmpeg.acceptedAudioCodecs.push(config.ffmpeg.targetAudioCodec);
  }

  return config;
};
