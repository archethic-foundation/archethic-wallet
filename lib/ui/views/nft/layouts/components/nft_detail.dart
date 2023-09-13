import 'package:aewallet/application/account/providers.dart';
import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/application/settings/theme.dart';
import 'package:aewallet/model/data/account.dart';
import 'package:aewallet/model/data/account_token.dart';
import 'package:aewallet/ui/util/dimens.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/util/ui_util.dart';
import 'package:aewallet/ui/views/nft/layouts/components/nft_detail_collection.dart';
import 'package:aewallet/ui/views/nft/layouts/components/nft_detail_properties.dart';
import 'package:aewallet/ui/views/nft/layouts/components/thumbnail/nft_thumbnail.dart';
import 'package:aewallet/ui/views/transfer/bloc/state.dart';
import 'package:aewallet/ui/views/transfer/layouts/transfer_sheet.dart';
import 'package:aewallet/ui/widgets/components/app_button_tiny.dart';
import 'package:aewallet/ui/widgets/components/qr_code_with_options.dart';
import 'package:aewallet/ui/widgets/components/scrollbar.dart';
import 'package:aewallet/ui/widgets/components/sheet_header.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/haptic_util.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:material_symbols_icons/symbols.dart';

class NFTDetail extends ConsumerStatefulWidget {
  const NFTDetail({
    super.key,
    required this.name,
    required this.address,
    required this.symbol,
    required this.properties,
    required this.collection,
    required this.tokenId,
    required this.detailCollection,
    this.nameInCollection,
    this.displaySendButton = true,
  });

  final bool displaySendButton;
  final String name;
  final String address;
  final String symbol;
  final String tokenId;
  final List<Map<String, dynamic>> collection;
  final Map<String, dynamic> properties;
  final String? nameInCollection;
  final bool detailCollection;

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
    final localizations = AppLocalizations.of(context)!;
    final preferences = ref.watch(SettingsProviders.settings);
    final accountSelected =
        ref.watch(AccountProviders.selectedAccount).valueOrNull;

    if (accountSelected == null) return const SizedBox();
    return SafeArea(
      minimum:
          EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.035),
      child: Column(
        children: <Widget>[
          SheetHeader(
            title: widget.name,
            widgetLeft: const SizedBox(width: 50),
            widgetRight: SizedBox(
              width: 50,
              child: Padding(
                padding: const EdgeInsets.only(top: 20, right: 20),
                child: InkWell(
                  child: const Icon(
                    Symbols.qr_code_scanner,
                    size: 30,
                    weight: IconSize.weightM,
                    opticalSize: IconSize.opticalSizeM,
                    grade: IconSize.gradeM,
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
                              infoQRCode: widget.address.toUpperCase(),
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
          if (widget.symbol.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                '[${widget.symbol}]',
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
                    top: 20,
                  ),
                  child: widget.collection.isEmpty
                      ? ArchethicScrollbar(
                          child: Column(
                            children: <Widget>[
                              NFTThumbnail(
                                nameInCollection: widget.nameInCollection,
                                address: widget.address,
                                properties: widget.properties,
                                withContentInfo: true,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              NFTDetailProperties(
                                properties: widget.properties,
                              ),
                            ],
                          ),
                        )
                      : Column(
                          children: [
                            NFTDetailProperties(
                              properties: widget.properties,
                            ),
                            Expanded(
                              child: NFTDetailCollection(
                                address: widget.address,
                                collection: widget.collection,
                                tokenId: widget.tokenId,
                                name: widget.name,
                                symbol: widget.symbol,
                              ),
                            ),
                          ],
                        ),
                ),
              ),
            ),
          ),
          if (widget.displaySendButton)
            Row(
              children: <Widget>[
                AppButtonTinyConnectivity(
                  localizations.send,
                  Dimens.buttonTopDimens,
                  key: const Key('sendNFT'),
                  icon: Symbols.call_made,
                  onPressed: () async {
                    sl.get<HapticUtil>().feedback(
                          FeedbackType.light,
                          preferences.activeVibrations,
                        );
                    final accountToken = getAccountToken(accountSelected);

                    await TransferSheet(
                      transferType: TransferType.nft,
                      accountToken: accountToken,
                      recipient: const TransferRecipient.address(
                        address: Address(address: ''),
                      ),
                      tokenId: widget.tokenId,
                    ).show(
                      context: context,
                      ref: ref,
                    );
                  },
                ),
              ],
            ),
          Row(
            children: <Widget>[
              AppButtonTinyConnectivity(
                localizations.viewExplorer,
                Dimens.buttonBottomDimens,
                icon: Symbols.more_horiz,
                key: const Key('viewExplorer'),
                onPressed: () async {
                  UIUtil.showWebview(
                    context,
                    '${ref.read(SettingsProviders.settings).network.getLink()}/explorer/transaction/${widget.address}',
                    '',
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  AccountToken getAccountToken(Account accountSelected) {
    // Single token selected
    if (accountSelected.accountNFT!.any(
      (element) => element.tokenInformation!.id == widget.tokenId,
    )) {
      return accountSelected.accountNFT!.firstWhere(
        (element) => element.tokenInformation!.id == widget.tokenId,
      );
      // Collection token selected
    } else if (accountSelected.accountNFTCollections!.any(
      (element) => element.tokenInformation!.id == widget.tokenId,
    )) {
      return accountSelected.accountNFTCollections!.firstWhere(
        (element) => element.tokenInformation!.id == widget.tokenId,
      );
      // Single token from a collection selected
    } else {
      return accountSelected.accountNFTCollections!.firstWhere(
        (element) =>
            element.tokenInformation!.address == widget.address &&
            element.tokenInformation!.tokenCollection!.any(
              (element) => element['id'] == widget.tokenId,
            ),
      );
    }
  }
}
