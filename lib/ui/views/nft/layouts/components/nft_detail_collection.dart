import 'dart:ui';
import 'package:aewallet/ui/themes/styles.dart';
import 'package:aewallet/ui/views/nft/layouts/components/nft_detail.dart';
import 'package:aewallet/ui/views/nft/layouts/components/thumbnail/nft_thumbnail.dart';
import 'package:aewallet/ui/widgets/components/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class NFTDetailCollection extends ConsumerStatefulWidget {
  const NFTDetailCollection({
    super.key,
    required this.name,
    required this.address,
    required this.symbol,
    required this.collection,
    required this.tokenId,
  });

  final String address;
  final String tokenId;
  final String name;
  final String symbol;
  final List<dynamic> collection;

  @override
  ConsumerState<NFTDetailCollection> createState() =>
      _NFTDetailCollectionState();
}

class _NFTDetailCollectionState extends ConsumerState<NFTDetailCollection> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 10,
        right: 10,
      ),
      child: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(
          dragDevices: {
            PointerDeviceKind.touch,
            PointerDeviceKind.mouse,
            PointerDeviceKind.trackpad,
          },
        ),
        child: DynamicHeightGridView(
          crossAxisCount: 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 30,
          shrinkWrap: true,
          itemCount: widget.collection.length,
          builder: (context, index) {
            final tokenInformation = widget.collection[index];

            return Column(
              children: [
                Text(
                  '${tokenInformation['name']}',
                  style: ArchethicThemeStyles.textStyleSize10W100Primary,
                ),
                const SizedBox(
                  height: 5,
                ),
                GestureDetector(
                  onTap: () {
                    context.push(
                      NFTDetail.routerPage,
                      extra: {
                        'address': widget.address,
                        'name': widget.name,
                        'nameInCollection': tokenInformation['name'],
                        'properties': tokenInformation,
                        'collection': const [],
                        'symbol': widget.symbol,
                        'tokenId': tokenInformation['id'] ?? index.toString(),
                        'detailCollection': true,
                      },
                    );
                  },
                  child: NFTThumbnail(
                    address: widget.address,
                    properties: tokenInformation,
                    roundBorder: true,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
