import 'dart:ui';

import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/ui/themes/styles.dart';
import 'package:aewallet/ui/util/responsive.dart';
import 'package:aewallet/ui/views/nft/layouts/components/nft_detail.dart';
import 'package:aewallet/ui/views/nft/layouts/components/thumbnail/nft_thumbnail.dart';
import 'package:aewallet/ui/widgets/components/dynamic_height_grid_view.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/haptic_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:go_router/go_router.dart';

class NFTDetailCollection extends ConsumerWidget {
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
  Widget build(BuildContext context, WidgetRef ref) {
    final preferences = ref.watch(SettingsProviders.settings);

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
          crossAxisCount:
              Responsive.isDesktop(context) || Responsive.isTablet(context)
                  ? 3
                  : 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 30,
          shrinkWrap: true,
          itemCount: collection.length,
          builder: (context, index) {
            final tokenInformation = collection[index];

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
                    sl.get<HapticUtil>().feedback(
                          FeedbackType.light,
                          preferences.activeVibrations,
                        );

                    context.push(
                      NFTDetail.routerPage,
                      extra: {
                        'address': address,
                        'name': name,
                        'nameInCollection': tokenInformation['name'],
                        'properties': tokenInformation,
                        'collection': const [],
                        'symbol': symbol,
                        'tokenId': tokenInformation['id'] ?? index.toString(),
                        'detailCollection': true,
                      },
                    );
                  },
                  child: NFTThumbnail(
                    address: address,
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
