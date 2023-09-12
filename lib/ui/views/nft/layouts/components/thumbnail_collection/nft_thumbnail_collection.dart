import 'package:aewallet/ui/views/nft/layouts/components/thumbnail/nft_thumbnail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NFTThumbnailCollection extends ConsumerWidget {
  const NFTThumbnailCollection({
    super.key,
    required this.address,
    required this.collection,
    this.nameInCollection,
    this.roundBorder = false,
    this.withContentInfo = false,
  });

  final String address;
  final String? nameInCollection;
  final List<Map<String, dynamic>> collection;
  final bool roundBorder;
  final bool withContentInfo;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (collection.isEmpty) {
      return Container();
    }

    if (collection.length == 1) {
      return NFTThumbnail(
        address: address,
        properties: collection[0],
        roundBorder: roundBorder,
      );
    }

    return GridView.count(
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      shrinkWrap: true,
      children: [
        NFTThumbnail(
          address: address,
          properties: collection[0],
          roundBorder: roundBorder,
        ),
        NFTThumbnail(
          address: address,
          properties: collection[1],
          roundBorder: roundBorder,
        ),
        if (collection.length > 2)
          NFTThumbnail(
            address: address,
            properties: collection[2],
            roundBorder: roundBorder,
          ),
        if (collection.length > 3)
          NFTThumbnail(
            address: address,
            properties: collection[3],
            roundBorder: roundBorder,
          ),
      ],
    );
  }
}
