import 'package:aewallet/infrastructure/datasources/airdrop_datasource.hive.dart';
import 'package:aewallet/infrastructure/datasources/airdrop_dto.hive.dart';
import 'package:aewallet/model/airdrop.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'airdrop_notifier.g.dart';

@riverpod
class AirdropNotifier extends _$AirdropNotifier {
  @override
  FutureOr<Airdrop?> build() async {
    final airdropHiveDatasource = await AirdropHiveDatasource.getInstance();
    final _airdropDto = airdropHiveDatasource.getAirdrop();
    if (_airdropDto != null) {
      return _airdropDto.toModel();
    }
    return null;
  }

  Future<void> deleteAirdrop(
    Ref ref,
  ) async {
    final airdropHiveDatasource = await AirdropHiveDatasource.getInstance();
    await airdropHiveDatasource.removeAirdrop();
  }

  Future<void> setAirdrop(Airdrop airdrop) async {
    try {
      final _airdropDto = airdrop.toHive();
      final airdropHiveDatasource = await AirdropHiveDatasource.getInstance();
      await airdropHiveDatasource.setAirdrop(_airdropDto);

      state = AsyncValue.data(airdrop);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
      rethrow;
    }
  }
}
