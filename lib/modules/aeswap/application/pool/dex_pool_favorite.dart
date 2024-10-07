/// SPDX-License-Identifier: AGPL-3.0-or-later
part of 'dex_pool.dart';

@riverpod
class _PoolFavoriteNotifier extends _$PoolFavoriteNotifier {
  @override
  Future<bool> build(String poolAddress) async {
    final environment = ref.watch(environmentProvider);
    final favoritePoolsDatasource =
        await HiveFavoritePoolsDatasource.getInstance();
    return favoritePoolsDatasource.isFavoritePool(
      environment.name,
      poolAddress,
    );
  }

  Future<void> addToFavorite() => update((_) async {
        final favoritePoolsDatasource =
            await HiveFavoritePoolsDatasource.getInstance();
        await favoritePoolsDatasource.addFavoritePool(
          ref.watch(environmentProvider).name,
          poolAddress,
        );
        return true;
      });

  Future<void> removeFromFavorite() => update((_) async {
        final favoritePoolsDatasource =
            await HiveFavoritePoolsDatasource.getInstance();
        await favoritePoolsDatasource.removeFavoritePool(
          ref.watch(environmentProvider).name,
          poolAddress,
        );
        return false;
      });
}
