/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';

import 'package:aewallet/application/account/providers.dart';
import 'package:aewallet/application/device_abilities.dart';
import 'package:aewallet/application/nft_category.dart';
import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/application/settings/theme.dart';
import 'package:aewallet/application/wallet/wallet.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/model/address.dart';
import 'package:aewallet/model/data/account.dart';
import 'package:aewallet/model/nft_category.dart';
import 'package:aewallet/service/app_service.dart';
import 'package:aewallet/ui/util/formatters.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/util/ui_util.dart';
import 'package:aewallet/ui/views/nft/layouts/components/nft_detail.dart';
import 'package:aewallet/ui/views/nft/layouts/nft_category_menu.dart';
import 'package:aewallet/ui/widgets/components/refresh_indicator.dart';
import 'package:aewallet/ui/widgets/components/sheet_util.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/haptic_util.dart';
import 'package:aewallet/util/user_data_util.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'nft_tab.g.dart';

@riverpod
List<NftCategory> fetchNftCategory(
  FetchNftCategoryRef ref, {
  required Account account,
  required BuildContext context,
}) {
  final nftCategoryListCustomized = List<NftCategory>.empty(growable: true);
  if (account.nftCategoryList == null) {
    return ref.read(NftCategoryProviders.getListByDefault(context: context));
  }

  for (final nftCategoryId in account.nftCategoryList!) {
    nftCategoryListCustomized.add(
      ref
          .read(NftCategoryProviders.getListByDefault(context: context))
          .elementAt(nftCategoryId),
    );
  }
  return nftCategoryListCustomized;
}

class NFTTab extends ConsumerStatefulWidget {
  const NFTTab({super.key});

  @override
  ConsumerState<NFTTab> createState() => _NFTTabState();
}

class _NFTTabState extends ConsumerState<NFTTab> {
  TextEditingController searchController = TextEditingController();
  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final preferences = ref.watch(SettingsProviders.settings);
    final hasQRCode = ref.watch(DeviceAbilities.hasQRCodeProvider);
    final session = ref.read(SessionProviders.session).loggedIn!;
    final localizations = AppLocalization.of(context)!;
    return Column(
      children: [
        Expanded(
          child: ArchethicRefreshIndicator(
            onRefresh: () => Future<void>.sync(() async {
              sl.get<HapticUtil>().feedback(
                    FeedbackType.light,
                    preferences.activeVibrations,
                  );
              await ref
                  .read(AccountProviders.selectedAccount.notifier)
                  .refreshNFTs();
            }),
            child: ScrollConfiguration(
              behavior: ScrollConfiguration.of(context).copyWith(
                dragDevices: {
                  PointerDeviceKind.touch,
                  PointerDeviceKind.mouse,
                },
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          theme.background3Small!,
                        ),
                        fit: BoxFit.fitHeight,
                        opacity: 0.7,
                      ),
                    ),
                    child: CustomScrollView(
                      slivers: <Widget>[
                        SliverAppBar(
                          stretch: true,
                          automaticallyImplyLeading: false,
                          backgroundColor: Colors.transparent,
                          expandedHeight: 260,
                          flexibleSpace: FlexibleSpaceBar(
                            expandedTitleScale: 1,
                            stretchModes: const [
                              StretchMode.zoomBackground,
                              StretchMode.blurBackground,
                            ],
                            background: Stack(
                              children: [
                                DecoratedBox(
                                  position: DecorationPosition.foreground,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.center,
                                      colors: <Color>[
                                        theme.background!,
                                        Colors.transparent
                                      ],
                                    ),
                                  ),
                                  child: Image.asset(
                                    'assets/images/nft-create-new.jpg',
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    top: 250,
                                    left: 20,
                                    right: 20,
                                  ),
                                  child: Column(
                                    children: [
                                      Text(
                                        AppLocalization.of(context)!
                                            .nftTabDescriptionHeader,
                                        style: theme.textStyleSize12W400Primary,
                                        textAlign: TextAlign.justify,
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      // TODO(reddwarf03): Create a widget
                                      TextFormField(
                                        textAlignVertical:
                                            TextAlignVertical.center,
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.zero,
                                          prefixIcon: hasQRCode
                                              ? InkWell(
                                                  child: Icon(
                                                    FontAwesomeIcons.qrcode,
                                                    color: theme.text,
                                                    size: 24,
                                                  ),
                                                  onTap: () async {
                                                    sl
                                                        .get<HapticUtil>()
                                                        .feedback(
                                                          FeedbackType.light,
                                                          preferences
                                                              .activeVibrations,
                                                        );
                                                    final scanResult =
                                                        await UserDataUtil
                                                            .getQRData(
                                                      DataType.raw,
                                                      context,
                                                      ref,
                                                    );
                                                    if (scanResult == null) {
                                                      UIUtil.showSnackbar(
                                                        AppLocalization.of(
                                                                context,)!
                                                            .qrInvalidAddress,
                                                        context,
                                                        ref,
                                                        theme.text!,
                                                        theme.snackBarShadow!,
                                                      );
                                                    } else if (QRScanErrs
                                                        .errorList
                                                        .contains(scanResult)) {
                                                      UIUtil.showSnackbar(
                                                        scanResult,
                                                        context,
                                                        ref,
                                                        theme.text!,
                                                        theme.snackBarShadow!,
                                                      );
                                                      return;
                                                    } else {
                                                      searchController.text =
                                                          scanResult;
                                                    }
                                                  },
                                                )
                                              : null,
                                          suffixIcon: InkWell(
                                            child: Icon(
                                              Icons.search,
                                              color: theme.text,
                                              size: 26,
                                            ),
                                            onTap: () async {
                                              if (searchController
                                                  .text.isEmpty) {
                                                UIUtil.showSnackbar(
                                                  localizations.addressMissing,
                                                  context,
                                                  ref,
                                                  theme.text!,
                                                  theme.snackBarShadow!,
                                                  duration: const Duration(
                                                    seconds: 5,
                                                  ),
                                                );
                                                return;
                                              }
                                              if (!Address(
                                                searchController.text,
                                              ).isValid) {
                                                UIUtil.showSnackbar(
                                                  localizations.invalidAddress,
                                                  context,
                                                  ref,
                                                  theme.text!,
                                                  theme.snackBarShadow!,
                                                  duration: const Duration(
                                                    seconds: 5,
                                                  ),
                                                );
                                                return;
                                              }

                                              try {
                                                final tokenInformations =
                                                    await sl
                                                        .get<AppService>()
                                                        .getNFT(
                                                          searchController.text,
                                                          session.wallet.seed,
                                                          session.wallet
                                                              .appKeychain
                                                              .getAccountSelected()!
                                                              .name,
                                                        );

                                                if (tokenInformations == null) {
                                                  UIUtil.showSnackbar(
                                                    localizations.nftNotFound,
                                                    context,
                                                    ref,
                                                    theme.text!,
                                                    theme.snackBarShadow!,
                                                    duration: const Duration(
                                                      seconds: 5,
                                                    ),
                                                  );
                                                  return;
                                                }

                                                sl.get<HapticUtil>().feedback(
                                                      FeedbackType.light,
                                                      preferences
                                                          .activeVibrations,
                                                    );
                                                Sheets.showAppHeightNineSheet(
                                                  context: context,
                                                  ref: ref,
                                                  widget: NFTDetail(
                                                    tokenInformations:
                                                        tokenInformations,
                                                    displaySendButton: false,
                                                  ),
                                                );
                                                searchController.text = '';
                                              } catch (e) {
                                                UIUtil.showSnackbar(
                                                  e.toString(),
                                                  context,
                                                  ref,
                                                  theme.text!,
                                                  theme.snackBarShadow!,
                                                  duration: const Duration(
                                                    seconds: 5,
                                                  ),
                                                );
                                                return;
                                              }
                                            },
                                          ),
                                          border: const OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(90),
                                            ),
                                            borderSide: BorderSide.none,
                                          ),
                                          hintStyle:
                                              theme.textStyleSize12W400Primary,
                                          filled: true,
                                          fillColor: theme.text30,
                                          hintText: localizations.searchNFTHint,
                                        ),
                                        style: theme.textStyleSize12W400Primary,
                                        textAlign: TextAlign.center,
                                        controller: searchController,
                                        autocorrect: false,
                                        autofocus: true,
                                        maxLines: 2,
                                        cursorColor: theme.text,
                                        inputFormatters: <TextInputFormatter>[
                                          UpperCaseTextFormatter(),
                                          LengthLimitingTextInputFormatter(68),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const NftCategoryMenu(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
