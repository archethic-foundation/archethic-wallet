import 'package:aewallet/application/connectivity_status.dart';
import 'package:aewallet/application/device_abilities.dart';
import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/application/settings/theme.dart';
import 'package:aewallet/application/wallet/wallet.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/model/data/token_informations.dart';
import 'package:aewallet/ui/util/dimens.dart';
import 'package:aewallet/ui/util/formatters.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/util/ui_util.dart';
import 'package:aewallet/ui/views/main/bloc/nft_search_bar_provider.dart';
import 'package:aewallet/ui/views/main/bloc/nft_search_bar_state.dart';
import 'package:aewallet/ui/views/nft/layouts/components/nft_detail.dart';
import 'package:aewallet/ui/widgets/components/app_button_tiny.dart';
import 'package:aewallet/ui/widgets/components/app_text_field.dart';
import 'package:aewallet/ui/widgets/components/sheet_util.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/haptic_util.dart';
import 'package:aewallet/util/user_data_util.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NFTSearchBar extends ConsumerStatefulWidget {
  const NFTSearchBar({super.key});

  @override
  ConsumerState<NFTSearchBar> createState() => _NFTSearchBarState();
}

class _NFTSearchBarState extends ConsumerState<NFTSearchBar> {
  late TextEditingController searchController;

  @override
  void initState() {
    super.initState();

    searchController = TextEditingController();
    _updateAdressTextController();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void _updateAdressTextController() {
    searchController.text = ref
        .read(
          NftSearchBarProvider.nftSearchBar,
        )
        .searchCriteria;
  }

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final preferences = ref.watch(SettingsProviders.settings);
    final hasQRCode = ref.watch(DeviceAbilities.hasQRCodeProvider);
    final session = ref.watch(SessionProviders.session).loggedIn!;
    final localizations = AppLocalization.of(context)!;
    final nftSearchBar = ref.watch(
      NftSearchBarProvider.nftSearchBar,
    );
    final nftSearchBarNotifier = ref.watch(
      NftSearchBarProvider.nftSearchBar.notifier,
    );
    final connectivityStatusProvider = ref.watch(connectivityStatusProviders);
    ref.listen<NftSearchBarState>(
      NftSearchBarProvider.nftSearchBar,
      (_, nftSearchBar) {
        if (nftSearchBar.isControlsOk) {
          Sheets.showAppHeightNineSheet(
            context: context,
            ref: ref,
            widget: NFTDetail(
              tokenInformations:
                  nftSearchBar.tokenInformations ?? TokenInformations(),
              displaySendButton: false,
            ),
          );

          nftSearchBarNotifier.reset();
          return;
        }

        if (nftSearchBar.error.isEmpty) return;

        UIUtil.showSnackbar(
          nftSearchBar.error,
          context,
          ref,
          theme.text!,
          theme.snackBarShadow!,
          duration: const Duration(seconds: 5),
        );

        ref
            .read(
              NftSearchBarProvider.nftSearchBar.notifier,
            )
            .setError('');
      },
    );

    return Column(
      children: [
        TextFormField(
          textAlignVertical: TextAlignVertical.center,
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
                      sl.get<HapticUtil>().feedback(
                            FeedbackType.light,
                            preferences.activeVibrations,
                          );
                      final scanResult = await UserDataUtil.getQRData(
                        DataType.address,
                        context,
                        ref,
                      );
                      if (scanResult == null) {
                        UIUtil.showSnackbar(
                          AppLocalization.of(
                            context,
                          )!
                              .qrInvalidAddress,
                          context,
                          ref,
                          theme.text!,
                          theme.snackBarShadow!,
                        );
                      } else if (QRScanErrs.errorList.contains(scanResult)) {
                        UIUtil.showSnackbar(
                          scanResult,
                          context,
                          ref,
                          theme.text!,
                          theme.snackBarShadow!,
                        );
                        return;
                      } else {
                        final address = Address(address: scanResult);
                        nftSearchBarNotifier
                            .setSearchCriteria(address.address!);
                        _updateAdressTextController();
                      }
                    },
                  )
                : null,
            suffixIcon: TextFieldButton(
              icon: FontAwesomeIcons.paste,
              onPressed: () async {
                sl.get<HapticUtil>().feedback(
                      FeedbackType.light,
                      preferences.activeVibrations,
                    );
                Clipboard.getData('text/plain')
                    .then((ClipboardData? data) async {
                  if (data == null || data.text == null) {
                    return;
                  }
                  nftSearchBarNotifier.setSearchCriteria(data.text!);
                  _updateAdressTextController();
                });
              },
            ),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(90),
              ),
              borderSide: BorderSide.none,
            ),
            hintStyle: theme.textStyleSize12W400Primary,
            filled: true,
            fillColor: theme.text30,
            hintText: localizations.searchNFTHint,
          ),
          style: theme.textStyleSize12W400Primary,
          textAlign: TextAlign.center,
          controller: searchController,
          autocorrect: false,
          maxLines: 2,
          textInputAction: TextInputAction.done,
          cursorColor: theme.text,
          inputFormatters: <TextInputFormatter>[
            UpperCaseTextFormatter(),
            LengthLimitingTextInputFormatter(68),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: nftSearchBar.loading
              ? AppButtonTinyWithoutExpanded(
                  AppButtonTinyType.primaryOutline,
                  width: MediaQuery.of(context).size.width,
                  localizations.search,
                  Dimens.buttonTopDimens,
                  key: const Key('search'),
                  icon: Icon(
                    Icons.search,
                    color: theme.text30,
                    size: 14,
                  ),
                  showProgressIndicator: true,
                  onPressed: () {},
                )
              : connectivityStatusProvider == ConnectivityStatus.isConnected
                  ? AppButtonTinyWithoutExpanded(
                      AppButtonTinyType.primary,
                      width: MediaQuery.of(context).size.width,
                      localizations.search,
                      Dimens.buttonTopDimens,
                      key: const Key('search'),
                      icon: Icon(
                        Icons.search,
                        color: theme.text,
                        size: 14,
                      ),
                      showProgressIndicator: nftSearchBar.loading,
                      onPressed: () async {
                        sl.get<HapticUtil>().feedback(
                              FeedbackType.light,
                              preferences.activeVibrations,
                            );
                        final nameEncoded = Uri.encodeFull(
                          session.wallet.appKeychain.getAccountSelected()!.name,
                        );

                        await nftSearchBarNotifier.searchNFT(
                          searchController.text,
                          context,
                          session
                              .wallet
                              .keychainSecuredInfos
                              .services['archethic-wallet-$nameEncoded']!
                              .keyPair!,
                        );
                      },
                    )
                  : AppButtonTinyWithoutExpanded(
                      AppButtonTinyType.primaryOutline,
                      width: MediaQuery.of(context).size.width,
                      localizations.search,
                      Dimens.buttonTopDimens,
                      key: const Key('search'),
                      icon: Icon(
                        Icons.search,
                        color: theme.text30,
                        size: 14,
                      ),
                      onPressed: () {},
                    ),
        ),
      ],
    );
  }
}
