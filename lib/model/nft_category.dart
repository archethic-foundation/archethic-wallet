/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:freezed_annotation/freezed_annotation.dart';

part 'nft_category.freezed.dart';
part 'nft_category.g.dart';

@freezed
class NftCategory with _$NftCategory {
  const factory NftCategory({
    @Default(0) int id,
    @Default('') name,
    @Default('') String image,
  }) = _NftCategory;
  const NftCategory._();

  factory NftCategory.fromJson(Map<String, dynamic> json) =>
      _$NftCategoryFromJson(json);
}
