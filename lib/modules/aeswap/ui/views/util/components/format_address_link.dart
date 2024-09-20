import 'package:aewallet/modules/aeswap/application/dex_blockchain.dart';

import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

enum TypeAddressLink { address, transaction, chain }

class FormatAddressLink extends ConsumerWidget {
  const FormatAddressLink({
    required this.address,
    this.iconSize = 12,
    this.typeAddress = TypeAddressLink.address,
    this.tooltipLink,
    super.key,
  });

  final String address;
  final TypeAddressLink typeAddress;
  final double iconSize;
  final String? tooltipLink;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: () async {
        final blockchain = await ref.read(
          DexBlockchainsProviders.getBlockchainFromEnv(
            aedappfm.EndpointUtil.getEnvironnement(),
          ).future,
        );
        if (typeAddress == TypeAddressLink.transaction) {
          await launchUrl(
            Uri.parse(
              '${blockchain!.urlExplorerTransaction}$address',
            ),
          );
        } else {
          if (typeAddress == TypeAddressLink.address) {
            await launchUrl(
              Uri.parse(
                '${blockchain!.urlExplorerAddress}$address',
              ),
            );
          } else {
            await launchUrl(
              Uri.parse(
                '${blockchain!.urlExplorerChain}$address',
              ),
            );
          }
        }
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 3),
        child: tooltipLink == null
            ? Icon(
                aedappfm.Iconsax.export_3,
                size: iconSize,
              )
            : Tooltip(
                message: tooltipLink,
                child: Icon(
                  aedappfm.Iconsax.export_3,
                  size: iconSize,
                ),
              ),
      ),
    );
  }
}
