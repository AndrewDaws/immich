import { BadRequestException, Injectable } from '@nestjs/common';
import { Partner } from 'src/database';
import { AuthDto } from 'src/dtos/auth.dto';
import { PartnerResponseDto, PartnerSearchDto, UpdatePartnerDto } from 'src/dtos/partner.dto';
import { mapUser } from 'src/dtos/user.dto';
import { Permission } from 'src/enum';
import { PartnerDirection, PartnerIds } from 'src/repositories/partner.repository';
import { BaseService } from 'src/services/base.service';

@Injectable()
export class PartnerService extends BaseService {
  async create(auth: AuthDto, sharedWithId: string): Promise<PartnerResponseDto> {
    const partnerId: PartnerIds = { sharedById: auth.user.id, sharedWithId };
    const exists = await this.partnerRepository.get(partnerId);
    if (exists) {
      throw new BadRequestException(`Partner already exists`);
    }

    const partner = await this.partnerRepository.create(partnerId);
    return this.mapPartner(partner, PartnerDirection.SharedBy);
  }

  async remove(auth: AuthDto, sharedWithId: string): Promise<void> {
    const partnerId: PartnerIds = { sharedById: auth.user.id, sharedWithId };
    const partner = await this.partnerRepository.get(partnerId);
    if (!partner) {
      throw new BadRequestException('Partner not found');
    }

    await this.partnerRepository.remove(partnerId);
  }

  async search(auth: AuthDto, { direction }: PartnerSearchDto): Promise<PartnerResponseDto[]> {
    const partners = await this.partnerRepository.getAll(auth.user.id);
    const key = direction === PartnerDirection.SharedBy ? 'sharedById' : 'sharedWithId';
    return partners
      .filter((partner): partner is Partner => !!(partner.sharedBy && partner.sharedWith)) // Filter out soft deleted users
      .filter((partner) => partner[key] === auth.user.id)
      .map((partner) => this.mapPartner(partner, direction));
  }

  async update(auth: AuthDto, sharedById: string, dto: UpdatePartnerDto): Promise<PartnerResponseDto> {
    await this.requireAccess({ auth, permission: Permission.PartnerUpdate, ids: [sharedById] });
    const partnerId: PartnerIds = { sharedById, sharedWithId: auth.user.id };

    const entity = await this.partnerRepository.update(partnerId, { inTimeline: dto.inTimeline });
    return this.mapPartner(entity, PartnerDirection.SharedWith);
  }

  private mapPartner(partner: Partner, direction: PartnerDirection): PartnerResponseDto {
    // this is opposite to return the non-me user of the "partner"
    const user = mapUser(
      direction === PartnerDirection.SharedBy ? partner.sharedWith : partner.sharedBy,
    ) as PartnerResponseDto;

    return { ...user, inTimeline: partner.inTimeline };
  }
}
