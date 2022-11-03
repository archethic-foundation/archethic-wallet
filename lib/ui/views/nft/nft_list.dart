// Flutter imports:
// Project imports:
import 'package:aewallet/application/nft_category.dart';
import 'package:aewallet/application/settings.dart';
import 'package:aewallet/application/theme.dart';
import 'package:aewallet/appstate_container.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/model/address.dart';
import 'package:aewallet/ui/util/dimens.dart';
import 'package:aewallet/ui/util/ui_util.dart';
import 'package:aewallet/ui/views/nft/nft_card.dart';
import 'package:aewallet/ui/views/nft/nft_preview.dart';
import 'package:aewallet/ui/views/transfer/bloc/state.dart';
import 'package:aewallet/ui/views/transfer/layouts/transfer_sheet.dart';
import 'package:aewallet/ui/widgets/components/app_button.dart';
import 'package:aewallet/ui/widgets/components/app_button_tiny.dart';
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
    final accountSelected =
        StateContainer.of(context).appWallet!.appKeychain.getAccountSelected()!;
    final preferences = ref.watch(SettingsProviders.settings);
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
                                      AppButtonTiny(
                                        AppButtonTinyType.primary,
                                        localizations.send,
                                        Dimens.buttonTopDimens,
                                        key: const Key('sendNFT'),
                                        onPressed: () async {
                                          sl.get<HapticUtil>().feedback(
                                                FeedbackType.light,
                                                preferences.activeVibrations,
                                              );
                                          Sheets.showAppHeightNineSheet(
                                            context: context,
                                            ref: ref,
                                            widget: TransferSheet(
                                              transferType: TransferType.token,
                                              seed: (await StateContainer.of(
                                                context,
                                              ).getSeed())!,
                                              accountToken: accountSelected
                                                  .accountNFT![index],
                                              recipient: const TransferRecipient
                                                  .address(
                                                address: Address(''),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: <Widget>[
                                      AppButtonTiny(
                                        AppButtonTinyType.primary,
                                        localizations.viewExplorer,
                                        Dimens.buttonTopDimens,
                                        icon: Icon(
                                          Icons.more_horiz,
                                          color: theme.text,
                                        ),
                                        key: const Key('viewExplorer'),
                                        onPressed: () async {
                                          UIUtil.showWebview(
                                            context,
                                            '${StateContainer.of(context).curNetwork.getLink()}/explorer/transaction/${tokenInformations.address}',
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
              if (accountSelected.balance!.isNativeTokenValuePositive())
                AppButton(
                  AppButtonType.primary,
                  localizations.createNFT,
                  Dimens.buttonBottomDimens,
                  key: const Key('createNFT'),
                  onPressed: () async {
                    sl.get<HapticUtil>().feedback(
                          FeedbackType.light,
                          preferences.activeVibrations,
                        );
                    Navigator.of(context).pushNamed(
                      '/nft_creation',
                      arguments: {
                        'seed': await StateContainer.of(
                          context,
                        ).getSeed(),
                        'currentNftCategoryIndex': currentNftCategoryIndex,
                      },
                    );
                  },
                )
              else
                AppButton(
                  AppButtonType.primaryOutline,
                  localizations.createNFT,
                  Dimens.buttonBottomDimens,
                  key: const Key('createNFT'),
                  onPressed: () {},
                ),
            ],
          ),
        ],
      ),
    );
  }
}
