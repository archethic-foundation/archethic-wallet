// Flutter imports:
// Project imports:
import 'package:aewallet/application/currency.dart';
import 'package:aewallet/application/nft_category.dart';
import 'package:aewallet/application/theme.dart';
import 'package:aewallet/appstate_container.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/ui/util/dimens.dart';
import 'package:aewallet/ui/util/ui_util.dart';
import 'package:aewallet/ui/views/nft/nft_card.dart';
import 'package:aewallet/ui/views/nft/nft_preview.dart';
import 'package:aewallet/ui/views/nft_creation/bloc/provider.dart';
import 'package:aewallet/ui/views/nft_creation/layouts/nft_creation_process.dart';
import 'package:aewallet/ui/views/uco/layout/transfer_sheet.dart';
import 'package:aewallet/ui/widgets/components/buttons.dart';
import 'package:aewallet/ui/widgets/components/sheet_util.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/haptic_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// Package imports:
import 'package:flutter_vibrate/flutter_vibrate.dart';

class NFTList extends ConsumerWidget {
  const NFTList({super.key, this.currentNftCategoryIndex});
  final int? currentNftCategoryIndex;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalization.of(context)!;
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final accountSelected = StateContainer.of(context)
        .appWallet!
        .appKeychain!
        .getAccountSelected()!;
    final nftCategories = ref.read(
      NftCategoryProviders.fetchNftCategory(
        context: context,
        account: accountSelected,
      ),
    );
    final accountTokenList = accountSelected
        .getAccountNFTFiltered(nftCategories[currentNftCategoryIndex!].id);
    return SizedBox(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.8,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                            CurrencyProviders.selectedCurrency,
                                          );
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
                  // TODO(reddwarf03): See with Charly how to reinit the form
                  ref.invalidate(NftCreationProvider.nftCreation);

                  sl.get<HapticUtil>().feedback(
                        FeedbackType.light,
                        StateContainer.of(context).activeVibrations,
                      );
                  Navigator.of(context).pushNamed(
                    '/nft_creation',
                    arguments: {
                      'currentNftCategoryIndex': currentNftCategoryIndex!,
                      'process': NFTCreationProcessTypeEnum.single,
                      'primaryCurrency':
                          StateContainer.of(context).curPrimaryCurrency
                    },
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
