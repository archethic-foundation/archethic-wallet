import 'package:aewallet/modules/aeswap/application/dex_blockchain.dart';

import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

enum TypeAddressLinkCopyBigIcon { address, transaction, chain }

class FormatAddressLinkCopyBigIcon extends ConsumerWidget {
  const FormatAddressLinkCopyBigIcon({
    required this.address,
    this.reduceAddress = false,
    this.fontSize = 13,
    this.iconSize = 13,
    this.typeAddress = TypeAddressLinkCopyBigIcon.address,
    this.header,
    super.key,
  });

  final String address;
  final bool reduceAddress;
  final double fontSize;
  final double iconSize;
  final TypeAddressLinkCopyBigIcon typeAddress;
  final String? header;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: constraints.maxWidth * 0.6,
              child: header != null
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SelectableText(
                          '$header',
                          style: TextStyle(fontSize: fontSize),
                        ),
                        SelectableText(
                          reduceAddress
                              ? aedappfm.AddressUtil.reduceAddress(address)
                              : address,
                          style: TextStyle(fontSize: fontSize),
                        ),
                      ],
                    )
                  : SelectableText(
                      reduceAddress
                          ? aedappfm.AddressUtil.reduceAddress(address)
                          : address,
                      style: TextStyle(fontSize: fontSize),
                    ),
            ),
            SizedBox(
              width: constraints.maxWidth * 0.4,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () async {
                      await Clipboard.setData(
                        ClipboardData(text: address),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor:
                              Theme.of(context).snackBarTheme.backgroundColor,
                          content: SelectableText(
                            AppLocalizations.of(context)!.addressCopied,
                            style: Theme.of(context)
                                .snackBarTheme
                                .contentTextStyle,
                          ),
                          duration: const Duration(seconds: 3),
                          action: SnackBarAction(
                            label: AppLocalizations.of(context)!.ok,
                            onPressed: () {},
                          ),
                        ),
                      );
                    },
                    child: SizedBox(
                      height: 40,
                      width: 45,
                      child: Card(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            color: aedappfm
                                .ArchethicThemeBase.brightPurpleHoverBorder
                                .withOpacity(1),
                            width: 0.5,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        elevation: 0,
                        color: aedappfm
                            .ArchethicThemeBase.brightPurpleHoverBackground,
                        child: const Padding(
                          padding: EdgeInsets.only(
                            top: 5,
                            bottom: 5,
                            left: 10,
                            right: 10,
                          ),
                          child: Icon(
                            aedappfm.Iconsax.copy,
                            size: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      final blockchain = await ref.read(
                        DexBlockchainsProviders.getBlockchainFromEnv(
                          aedappfm.EndpointUtil.getEnvironnement(),
                        ).future,
                      );
                      if (typeAddress ==
                          TypeAddressLinkCopyBigIcon.transaction) {
                        await launchUrl(
                          Uri.parse(
                            '${blockchain!.urlExplorerTransaction}$address',
                          ),
                        );
                      } else {
                        if (typeAddress == TypeAddressLinkCopyBigIcon.address) {
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
                    child: SizedBox(
                      height: 40,
                      width: 45,
                      child: Card(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            color: aedappfm
                                .ArchethicThemeBase.brightPurpleHoverBorder
                                .withOpacity(1),
                            width: 0.5,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        elevation: 0,
                        color: aedappfm
                            .ArchethicThemeBase.brightPurpleHoverBackground,
                        child: const Padding(
                          padding: EdgeInsets.only(
                            top: 5,
                            bottom: 5,
                            left: 10,
                            right: 10,
                          ),
                          child: Icon(
                            aedappfm.Iconsax.export_3,
                            size: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
