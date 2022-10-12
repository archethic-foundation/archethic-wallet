// Flutter imports:
// Project imports:
import 'package:aewallet/application/currency.dart';
import 'package:aewallet/application/theme.dart';
import 'package:aewallet/appstate_container.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/ui/util/dimens.dart';
import 'package:aewallet/ui/util/ui_util.dart';
import 'package:aewallet/ui/views/nft/nft_creation_process.dart';
import 'package:aewallet/ui/views/nft/preview/nft_card.dart';
import 'package:aewallet/ui/views/nft/preview/nft_preview.dart';
import 'package:aewallet/ui/views/uco/layout/transfer_sheet.dart';
import 'package:aewallet/ui/widgets/components/buttons.dart';
import 'package:aewallet/ui/widgets/components/sheet_util.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/haptic_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// Package imports:
import 'package:flutter_vibrate/flutter_vibrate.dart';

class NFTList extends ConsumerStatefulWidget {
  const NFTList({super.key, this.currentNftCategoryIndex});
  final int? currentNftCategoryIndex;

  @override
  ConsumerState<NFTList> createState() => _NFTListState();
}

final GlobalKey expandedKey = GlobalKey();

class _NFTListState extends ConsumerState<NFTList> {
  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalization.of(context)!;
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final accountSelected = StateContainer.of(context)
        .appWallet!
        .appKeychain!
        .getAccountSelected()!;
    final accountTokenList =
        accountSelected.getAccountNFTFiltered(widget.currentNftCategoryIndex!);
    return SizedBox(
      key: expandedKey,
      width: double.infinity,
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: <Widget>[
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                primary: false,
                shrinkWrap: true,
                itemCount: accountTokenList.length,
                padding: const EdgeInsets.only(top: 20, bottom: 20),
                itemBuilder: (context, index) {
                  final tokenInformations =
                      accountTokenList[index].tokenInformations!;

                  return NFTCard(
                    tokenInformations: tokenInformations,
                    onTap: () {
                      showDialog(
                        barrierDismissible: true,
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(16),
                              ),
                              side: BorderSide(
                                color: theme.text45!,
                              ),
                            ),
                            content: SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  NFTPreviewWidget(
                                    tokenInformations: tokenInformations,
                                    nftPropertiesDeleteAction: false,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: <Widget>[
                                      AppButton.buildAppButtonTiny(
                                        const Key('sendNFT'),
                                        context,
                                        ref,
                                        AppButtonType.primary,
                                        localizations.send,
                                        Dimens.buttonTopDimens,
                                        onPressed: () async {
                                          final currency = ref.read(
                                              CurrencyProviders
                                                  .selectedCurrency);
                                          sl.get<HapticUtil>().feedback(
                                                FeedbackType.light,
                                                StateContainer.of(context)
                                                    .activeVibrations,
                                              );
                                          Sheets.showAppHeightNineSheet(
                                            context: context,
                                            ref: ref,
                                            widget: TransferSheet(
                                              accountToken: accountSelected
                                                  .accountNFT![index],
                                              primaryCurrency:
                                                  StateContainer.of(context)
                                                      .curPrimaryCurrency,
                                              title: localizations.transferNFT,
                                              localCurrency: currency,
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: <Widget>[
                                      AppButton.buildAppButtonTiny(
                                        const Key('viewExplorer'),
                                        context,
                                        ref,
                                        AppButtonType.primary,
                                        localizations.viewExplorer,
                                        Dimens.buttonTopDimens,
                                        icon: Icon(
                                          Icons.more_horiz,
                                          color: theme.text,
                                        ),
                                        onPressed: () async {
                                          UIUtil.showWebview(
                                            context,
                                            '${await StateContainer.of(context).curNetwork.getLink()}/explorer/transaction/${tokenInformations.address}',
                                            '',
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ),
          Row(
            children: <Widget>[
              AppButton.buildAppButton(
                const Key('createNFT'),
                context,
                ref,
                AppButtonType.primary,
                localizations.createNFT,
                Dimens.buttonBottomDimens,
                onPressed: () async {
                  /* Sheets.showAppHeightNineSheet(
                  context: context,
                  widget: AddNFTFile(
                    process: AddNFTFileProcess.single,
                    primaryCurrency:
                        StateContainer.of(context).curPrimaryCurrency,
                  ),
                );*/
                  sl.get<HapticUtil>().feedback(
                        FeedbackType.light,
                        StateContainer.of(context).activeVibrations,
                      );
                  Navigator.of(context).pushNamed(
                    '/nft_creation',
                    arguments: {
                      'currentNftCategoryIndex':
                          widget.currentNftCategoryIndex!,
                      'process': NFTCreationProcessType.single,
                      'primaryCurrency':
                          StateContainer.of(context).curPrimaryCurrency
                    },
                  );
                },
              ),
            ],
          ),
          /*Row(
            children: <Widget>[
              AppButton.buildAppButton(
                  const Key('createNFTCollection'),
                  context,
                  AppButtonType.primary,
                  localizations.createNFTCollection,
                  Dimens.buttonBottomDimens, onPressed: () {
                Sheets.showAppHeightNineSheet(
                    context: context,
                    widget: AddNFTCollection(
                      primaryCurrency:
                          StateContainer.of(context).curPrimaryCurrency,
                    ));
              }),
            ],
          ),*/
        ],
      ),
    );
  }
}
