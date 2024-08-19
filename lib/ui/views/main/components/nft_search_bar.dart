import 'package:aewallet/application/connectivity_status.dart';
import 'package:aewallet/application/device_abilities.dart';
import 'package:aewallet/application/session/session.dart';
import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/themes/styles.dart';
import 'package:aewallet/ui/util/formatters.dart';
import 'package:aewallet/ui/util/ui_util.dart';
import 'package:aewallet/ui/views/main/bloc/nft_search_bar_provider.dart';
import 'package:aewallet/ui/views/main/bloc/nft_search_bar_state.dart';
import 'package:aewallet/ui/views/nft/layouts/components/nft_detail.dart';
import 'package:aewallet/ui/views/nft_creation/bloc/provider.dart';
import 'package:aewallet/ui/views/nft_creation/layouts/nft_creation_process_sheet.dart';
import 'package:aewallet/ui/widgets/components/paste_icon.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/haptic_util.dart';
import 'package:aewallet/util/user_data_util.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';

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
    final preferences = ref.watch(SettingsProviders.settings);
    final hasQRCode = ref.watch(DeviceAbilities.hasQRCodeProvider);
    final session = ref.watch(sessionNotifierProvider).loggedIn!;
    final localizations = AppLocalizations.of(context)!;
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
          context.push(
            NFTDetail.routerPage,
            extra: {
              'address': nftSearchBar.tokenInformation!.address ?? '',
              'name': nftSearchBar.tokenInformation!.name ?? '',
              'properties':
                  nftSearchBar.tokenInformation!.tokenProperties ?? {},
              'collection':
                  nftSearchBar.tokenInformation!.tokenCollection ?? [],
              'symbol': nftSearchBar.tokenInformation!.symbol ?? '',
              'tokenId': nftSearchBar.tokenInformation!.id ?? '',
              'detailCollection': false,
            },
          );

          nftSearchBarNotifier.reset();
          return;
        }

        if (nftSearchBar.error.isEmpty) return;

        UIUtil.showSnackbar(
          nftSearchBar.error,
          context,
          ref,
          ArchethicTheme.text,
          ArchethicTheme.snackBarShadow,
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
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: TextFormField(
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.zero,
                  prefixIcon: hasQRCode
                      ? InkWell(
                          child: Icon(
                            Symbols.qr_code_scanner,
                            color: ArchethicTheme.text,
                            size: 24,
                            weight: IconSize.weightM,
                            opticalSize: IconSize.opticalSizeM,
                            grade: IconSize.gradeM,
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
                                AppLocalizations.of(
                                  context,
                                )!
                                    .qrInvalidAddress,
                                context,
                                ref,
                                ArchethicTheme.text,
                                ArchethicTheme.snackBarShadow,
                              );
                            } else if (QRScanErrs.errorList
                                .contains(scanResult)) {
                              UIUtil.showSnackbar(
                                scanResult,
                                context,
                                ref,
                                ArchethicTheme.text,
                                ArchethicTheme.snackBarShadow,
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
                      : Icon(
                          Symbols.search,
                          color: ArchethicTheme.text,
                          size: 18,
                          weight: IconSize.weightM,
                          opticalSize: IconSize.opticalSizeM,
                          grade: IconSize.gradeM,
                        ),
                  suffixIcon: PasteIcon(
                    onPaste: (String value) {
                      nftSearchBarNotifier.setSearchCriteria(value);
                      _updateAdressTextController();
                    },
                  ),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(90),
                    ),
                    borderSide: BorderSide.none,
                  ),
                  hintStyle: ArchethicThemeStyles.textStyleSize12W100Primary,
                  filled: true,
                  hintText: localizations.searchNFTHint,
                ),
                style: ArchethicThemeStyles.textStyleSize12W100Primary,
                textAlign: TextAlign.left,
                controller: searchController,
                autocorrect: false,
                maxLines: 2,
                textInputAction: TextInputAction.done,
                cursorColor: ArchethicTheme.text,
                inputFormatters: <TextInputFormatter>[
                  UpperCaseTextFormatter(),
                  LengthLimitingTextInputFormatter(68),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: nftSearchBar.loading ||
                            connectivityStatusProvider ==
                                ConnectivityStatus.isConnected
                        ? () {}
                        : () async {
                            sl.get<HapticUtil>().feedback(
                                  FeedbackType.light,
                                  preferences.activeVibrations,
                                );

                            final selectedAccount = await session
                                .wallet.appKeychain
                                .getAccountSelected();
                            await nftSearchBarNotifier.searchNFT(
                              searchController.text,
                              context,
                              session.wallet.keychainSecuredInfos
                                  .services[selectedAccount!.name]!.keyPair!,
                            );
                          },
                    child: Container(
                      height: 30,
                      width: 30,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        gradient: aedappfm.AppThemeBase.gradientBtn,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Symbols.search,
                        size: 15,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () async {
                      sl.get<HapticUtil>().feedback(
                            FeedbackType.light,
                            preferences.activeVibrations,
                          );

                      ref
                          .read(
                            NftCreationFormProvider
                                .nftCreationFormArgs.notifier,
                          )
                          .state = const NftCreationFormNotifierParams();
                      context.go(
                        NftCreationProcessSheet.routerPage,
                      );
                    },
                    child: Container(
                      height: 30,
                      width: 30,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        gradient: aedappfm.AppThemeBase.gradientBtn,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Symbols.add,
                        size: 15,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
