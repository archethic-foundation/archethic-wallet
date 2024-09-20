/// SPDX-License-Identifier: AGPL-3.0-or-later
part of 'dex_pool.dart';

@riverpod
Future<void> _removePoolFromFavorite(
  _RemovePoolFromFavoriteRef ref,
  String poolGenesisAddress,
) async {
  final favoritePoolsDatasource =
      await HiveFavoritePoolsDatasource.getInstance();
  await favoritePoolsDatasource.removeFavoritePool(
    aedappfm.EndpointUtil.getEnvironnement(),
    poolGenesisAddress,
  );
}

@riverpod
Future<void> _addPoolFromFavorite(
  _AddPoolFromFavoriteRef ref,
  String poolGenesisAddress,
) async {
  final favoritePoolsDatasource =
      await HiveFavoritePoolsDatasource.getInstance();
  await favoritePoolsDatasource.addFavoritePool(
    aedappfm.EndpointUtil.getEnvironnement(),
    poolGenesisAddress,
  );
}
