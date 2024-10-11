import 'package:aewallet/modules/aeswap/application/dex_blockchain.dart';
import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/util/ui_util.dart';

import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';
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
    final localizations = AppLocalizations.of(context)!;
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
                    child: Container(
                      height: 40,
                      width: 40,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        gradient: aedappfm.AppThemeBase.gradientBtn,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        aedappfm.Iconsax.copy,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                    onTap: () async {
                      await Clipboard.setData(
                        ClipboardData(text: address),
                      );
                      UIUtil.showSnackbar(
                        localizations.addressCopied,
                        context,
                        ref,
                        ArchethicTheme.text,
                        ArchethicTheme.snackBarShadow,
                        icon: Symbols.info,
                      );
                    },
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    child: Container(
                      height: 40,
                      width: 40,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        gradient: aedappfm.AppThemeBase.gradientBtn,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        aedappfm.Iconsax.export_3,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                    onTap: () async {
                      final blockchain = await ref.read(
                        DexBlockchainsProviders.currentBlockchain.future,
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
