import 'package:aewallet/infrastructure/datasources/appdb.hive.dart';
import 'package:aewallet/model/airdrop.dart';
import 'package:hive/hive.dart';

part 'airdrop_dto.hive.g.dart';

@HiveType(typeId: HiveTypeIds.airdrop)
class AirdropHiveDto extends HiveObject {
  AirdropHiveDto({
    required this.personalLPAmount,
    required this.isMailFilled,
    required this.isMailConfirmed,
  });

  factory AirdropHiveDto.fromModel(Airdrop airdrop) {
    return AirdropHiveDto(
      isMailFilled: airdrop.isMailFilled,
      personalLPAmount: airdrop.personalLPAmount,
      isMailConfirmed: airdrop.isMailConfirmed,
    );
  }

  @HiveField(0)
  double personalLPAmount;

  @HiveField(1)
  bool isMailFilled;

  @HiveField(2)
  bool isMailConfirmed;

  Airdrop toModel() {
    return Airdrop(
      personalLPAmount: personalLPAmount,
      isMailFilled: isMailFilled,
      isMailConfirmed: isMailConfirmed,
    );
  }
}

extension AirdropHiveConversionExt on Airdrop {
  AirdropHiveDto toHive() => AirdropHiveDto(
        personalLPAmount: personalLPAmount,
        isMailFilled: isMailFilled,
        isMailConfirmed: isMailConfirmed,
      );
}
