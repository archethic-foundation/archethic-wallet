import 'package:aewallet/ui/views/airdrop/layouts/components/airdrop_banner.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'airdrop_banner_status.freezed.dart';

@freezed
class AirdropBannerStatus with _$AirdropBannerStatus {
  const factory AirdropBannerStatus({
    required AirdropState airdropState,
    String? email,
  }) = _AirdropBannerStatus;

  factory AirdropBannerStatus.initial() => const AirdropBannerStatus(
        airdropState: AirdropState.newParticipation,
      );
}
