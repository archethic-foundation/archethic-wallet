/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/application/account/providers.dart';
import 'package:aewallet/application/connectivity_status.dart';
import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/application/settings/theme.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/model/data/token_informations.dart';
import 'package:aewallet/ui/util/dimens.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/util/ui_util.dart';
import 'package:aewallet/ui/views/nft/layouts/components/nft_preview.dart';
import 'package:aewallet/ui/views/transfer/bloc/state.dart';
import 'package:aewallet/ui/views/transfer/layouts/transfer_sheet.dart';
import 'package:aewallet/ui/widgets/components/app_button_tiny.dart';
import 'package:aewallet/ui/widgets/components/icons.dart';
import 'package:aewallet/ui/widgets/components/qr_code_with_options.dart';
import 'package:aewallet/ui/widgets/components/scrollbar.dart';
import 'package:aewallet/ui/widgets/components/sheet_header.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/haptic_util.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NFTDetail extends ConsumerStatefulWidget {
  const NFTDetail({
    super.key,
    required this.tokenInformations,
    this.displaySendButton = true,
  });

  final TokenInformations tokenInformations;
  final bool displaySendButton;

  @override
  ConsumerState<NFTDetail> createState() => _NFTDetailState();
}

class _NFTDetailState extends ConsumerState<NFTDetail> {
  late ScrollController scrollController;

  @override
  void initState() {
    scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final localizations = AppLocalization.of(context)!;
    final preferences = ref.watch(SettingsProviders.settings);
    final accountSelected =
        ref.watch(AccountProviders.selectedAccount).valueOrNull;
    final connectivityStatusProvider = ref.watch(connectivityStatusProviders);

    if (accountSelected == null) return const SizedBox();
    return SafeArea(
      minimum:
          EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.035),
      child: Column(
        children: <Widget>[
          SheetHeader(
            title: widget.tokenInformations.name!,
            widgetLeft: const SizedBox(width: 50),
            widgetRight: SizedBox(
              width: 50,
              child: Padding(
                padding: const EdgeInsets.only(top: 20, right: 20),
                child: InkWell(
                  child: const Icon(
                    FontAwesomeIcons.qrcode,
                    size: 30,
                  ),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(32)),
                          ),
                          contentPadding: const EdgeInsets.only(top: 10),
                          content: Padding(
                            padding: const EdgeInsets.only(
                              left: 20,
                              right: 20,
                              top: 20,
                              bottom: 40,
                            ),
                            child: QRCodeWithOptions(
                              infoQRCode: widget.tokenInformations.address!
                                  .toUpperCase(),
                              size: 150,
                              messageCopied: localizations.addressCopied,
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ),
          if (widget.tokenInformations.symbol != null &&
              widget.tokenInformations.symbol!.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                '[${widget.tokenInformations.symbol}]',
                style: theme.textStyleSize12W400Primary,
              ),
            ),
          Expanded(
            child: Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.8,
                child: SafeArea(
                  minimum: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.height * 0.035,
                    top: 50,
                  ),
                  child: ArchethicScrollbar(
                    child: Column(
                      children: <Widget>[
                        NFTPreviewWidget(
                          tokenInformations: widget.tokenInformations,
                          nftPropertiesDeleteAction: false,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          if (widget.displaySendButton)
            Row(
              children: <Widget>[
                if (connectivityStatusProvider ==
                    ConnectivityStatus.isConnected)
                  AppButtonTiny(
                    AppButtonTinyType.primary,
                    localizations.send,
                    Dimens.buttonTopDimens,
                    key: const Key('sendNFT'),
                    icon: Icon(
                      UiIcons.send,
                      color: theme.mainButtonLabel,
                      size: 14,
                    ),
                    onPressed: () async {
                      sl.get<HapticUtil>().feedback(
                            FeedbackType.light,
                            preferences.activeVibrations,
                          );
                      await TransferSheet(
                        transferType: TransferType.nft,
                        accountToken: accountSelected.accountNFT!.firstWhere(
                          (element) =>
                              element.tokenInformations!.id ==
                              widget.tokenInformations.id,
                        ),
                        recipient: const TransferRecipient.address(
                          address: Address(address: ''),
                        ),
                      ).show(
                        context: context,
                        ref: ref,
                      );
                    },
                  )
                else
                  AppButtonTiny(
                    AppButtonTinyType.primaryOutline,
                    localizations.send,
                    Dimens.buttonTopDimens,
                    key: const Key('sendNFT'),
                    icon: Icon(
                      UiIcons.send,
                      color: theme.mainButtonLabel!.withOpacity(0.3),
                      size: 14,
                    ),
                    onPressed: () {},
                  ),
              ],
            ),
          Row(
            children: <Widget>[
              if (connectivityStatusProvider == ConnectivityStatus.isConnected)
                AppButtonTiny(
                  AppButtonTinyType.primary,
                  localizations.viewExplorer,
                  Dimens.buttonBottomDimens,
                  icon: Icon(
                    Icons.more_horiz,
                    color: theme.mainButtonLabel,
                    size: 14,
                  ),
                  key: const Key('viewExplorer'),
                  onPressed: () async {
                    UIUtil.showWebview(
                      context,
                      '${ref.read(SettingsProviders.settings).network.getLink()}/explorer/transaction/${widget.tokenInformations.address}',
                      '',
                    );
                  },
                )
              else
                AppButtonTiny(
                  AppButtonTinyType.primaryOutline,
                  localizations.viewExplorer,
                  Dimens.buttonBottomDimens,
                  icon: Icon(
                    Icons.more_horiz,
                    color: theme.mainButtonLabel!.withOpacity(0.3),
                    size: 14,
                  ),
                  key: const Key('viewExplorer'),
                  onPressed: () {},
                ),
            ],
          ),
        ],
      ),
    );
  }
}
