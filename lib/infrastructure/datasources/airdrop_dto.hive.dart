import 'package:aewallet/infrastructure/datasources/appdb.hive.dart';
import 'package:aewallet/model/airdrop.dart';
import 'package:hive/hive.dart';

part 'airdrop_dto.hive.g.dart';

@HiveType(typeId: HiveTypeIds.airdrop)
class AirdropHiveDto extends HiveObject {
  AirdropHiveDto({
    required this.isFarming,
    required this.isMailFilled,
    this.currentStep,
    this.personalMultiplier,
    required this.currentAirdropValue,
  });

  factory AirdropHiveDto.fromModel(Airdrop airdrop) {
    return AirdropHiveDto(
      isFarming: airdrop.isFarming,
      isMailFilled: airdrop.isMailFilled,
      currentStep: airdrop.currentStep,
      personalMultiplier: airdrop.personalMultiplier,
      currentAirdropValue: airdrop.currentAirdropValue,
    );
  }

  @HiveField(0)
  bool isFarming;

  @HiveField(1)
  bool isMailFilled;

  @HiveField(2)
  int? currentStep;

  @HiveField(3)
  int? personalMultiplier;

  @HiveField(4)
  double currentAirdropValue;

  Airdrop toModel() {
    return Airdrop(
      isFarming: isFarming,
      isMailFilled: isMailFilled,
      currentStep: currentStep,
      personalMultiplier: personalMultiplier,
      currentAirdropValue: currentAirdropValue,
    );
  }
}

extension AirdropHiveConversionExt on Airdrop {
  AirdropHiveDto toHive() => AirdropHiveDto(
        isFarming: isFarming,
        isMailFilled: isMailFilled,
        currentStep: currentStep,
        personalMultiplier: personalMultiplier,
        currentAirdropValue: currentAirdropValue,
      );
}
