import 'package:aewallet/infrastructure/datasources/appdb.hive.dart';
import 'package:aewallet/model/airdrop.dart';
import 'package:hive/hive.dart';

part 'airdrop_dto.hive.g.dart';

@HiveType(typeId: HiveTypeIds.airdrop)
class AirdropHiveDto extends HiveObject {
  AirdropHiveDto({
    required this.personalLPAmount,
    required this.personalLPFlexibleAmount,
    required this.isMailConfirmed,
    this.email,
    this.referralCode,
  });

  factory AirdropHiveDto.fromModel(Airdrop airdrop) {
    return AirdropHiveDto(
      personalLPAmount: airdrop.personalLPAmount,
      personalLPFlexibleAmount: airdrop.personalLPFlexibleAmount,
      isMailConfirmed: airdrop.isMailConfirmed,
      email: airdrop.email,
      referralCode: airdrop.referralCode,
    );
  }

  @HiveField(0)
  double? personalLPAmount;

  @HiveField(2)
  bool? isMailConfirmed;

  @HiveField(3)
  double? personalLPFlexibleAmount;

  @HiveField(4)
  String? email;

  @HiveField(5)
  String? referralCode;

  Airdrop toModel() {
    return Airdrop(
      personalLPAmount: personalLPAmount,
      personalLPFlexibleAmount: personalLPFlexibleAmount,
      isMailConfirmed: isMailConfirmed,
      email: email,
      referralCode: referralCode,
    );
  }
}

extension AirdropHiveConversionExt on Airdrop {
  AirdropHiveDto toHive() => AirdropHiveDto(
        personalLPAmount: personalLPAmount,
        personalLPFlexibleAmount: personalLPFlexibleAmount,
        isMailConfirmed: isMailConfirmed,
      );
}
