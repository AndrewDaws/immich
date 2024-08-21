import { QueryParameter } from '$lib/constants';
import { authenticate } from '$lib/utils/auth';
import { getFormatter } from '$lib/utils/i18n';
import { getAssetInfoFromParam } from '$lib/utils/navigation';
import { buildTree, normalizeTreePath } from '$lib/utils/tree-utils';
import { getAllTags, type AssetResponseDto } from '@immich/sdk';
import type { PageLoad } from './$types';

export const load = (async ({ params, url }) => {
  await authenticate();
  const asset = await getAssetInfoFromParam(params);
  const $t = await getFormatter();

  let pathAssets: AssetResponseDto[] = [];
  const path = url.searchParams.get(QueryParameter.PATH);
  if (path) {
    pathAssets = [];
  }

  const tags = await getAllTags();
  const tree = buildTree(tags.map((tag) => tag.value));
  let currentTree = tree;
  const parts = normalizeTreePath(path || '').split('/');
  for (const part of parts) {
    currentTree = currentTree?.[part];
  }

  return {
    tags,
    asset,
    path,
    children: Object.keys(currentTree || {}),
    pathAssets,
    meta: {
      title: $t('tags'),
    },
  };
}) satisfies PageLoad;