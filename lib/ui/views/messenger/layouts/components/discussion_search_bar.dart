import 'package:aewallet/application/device_abilities.dart';
import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/application/session/session.dart';
import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/themes/styles.dart';
import 'package:aewallet/ui/util/formatters.dart';
import 'package:aewallet/ui/util/ui_util.dart';
import 'package:aewallet/ui/views/messenger/bloc/discussion_search_bar_provider.dart';
import 'package:aewallet/ui/views/messenger/bloc/discussion_search_bar_state.dart';
import 'package:aewallet/ui/views/messenger/layouts/add_discussion_sheet.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/haptic_util.dart';
import 'package:aewallet/util/user_data_util.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';

class DiscussionSearchBar extends ConsumerStatefulWidget {
  const DiscussionSearchBar({super.key});

  @override
  ConsumerState<DiscussionSearchBar> createState() =>
      _DiscussionSearchBarState();
}

class _DiscussionSearchBarState extends ConsumerState<DiscussionSearchBar> {
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
          DiscussionSearchBarProvider.discussionSearchBar,
        )
        .searchCriteria;
  }

  @override
  Widget build(BuildContext context) {
    final preferences = ref.watch(SettingsProviders.settings);
    final hasQRCode = ref.watch(DeviceAbilities.hasQRCodeProvider);
    final session = ref.watch(SessionProviders.session).loggedIn!;
    final localizations = AppLocalizations.of(context)!;
    final discussionSearchBarNotifier = ref.watch(
      DiscussionSearchBarProvider.discussionSearchBar.notifier,
    );
    ref.listen<DiscussionSearchBarState>(
      DiscussionSearchBarProvider.discussionSearchBar,
      (previousState, discussionSearchBar) {
        if (previousState?.searchCriteria !=
            discussionSearchBar.searchCriteria) {
          _updateAdressTextController();
        }
        if (discussionSearchBar.isControlsOk) {
          context.go(
            AddDiscussionSheet.routerPage,
            extra: discussionSearchBar.discussion,
          );
          discussionSearchBarNotifier.reset();
          return;
        }

        if (discussionSearchBar.error.isEmpty) return;

        UIUtil.showSnackbar(
          discussionSearchBar.error,
          context,
          ref,
          ArchethicTheme.text,
          ArchethicTheme.snackBarShadow,
          duration: const Duration(seconds: 5),
        );

        ref
            .read(
              DiscussionSearchBarProvider.discussionSearchBar.notifier,
            )
            .setError('');
      },
    );

    return Column(
      children: [
        TextFormField(
          onFieldSubmitted: (val) async {
            if (val.isEmpty) {
              return;
            }

            final name =
                (await session.wallet.appKeychain.getAccountSelected())!.name;

            await discussionSearchBarNotifier.searchDiscussion(
              searchController.text,
              context,
              session.wallet.keychainSecuredInfos.services[name]!.keyPair!,
            );
          },
          textAlignVertical: TextAlignVertical.center,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.zero,
            prefixIcon: Icon(
              Symbols.search,
              color: ArchethicTheme.text,
              size: 18,
              weight: IconSize.weightM,
              opticalSize: IconSize.opticalSizeM,
              grade: IconSize.gradeM,
            ),
            suffixIcon: hasQRCode
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
                      } else if (QRScanErrs.errorList.contains(scanResult)) {
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
                        discussionSearchBarNotifier
                            .setSearchCriteria(address.address!);
                        _updateAdressTextController();
                      }
                    },
                  )
                : null,
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(90),
              ),
              borderSide: BorderSide.none,
            ),
            hintStyle: ArchethicThemeStyles.textStyleSize12W100Primary,
            filled: true,
            fillColor: ArchethicTheme.text30,
            hintText: localizations.searchDiscussionHint,
          ),
          style: ArchethicThemeStyles.textStyleSize12W100Primary,
          textAlign: TextAlign.center,
          controller: searchController,
          autocorrect: false,
          maxLines:
              null, // max number of lines cannot be set because small devices (such as iPhone SE) cannot display 68 characters in 2 lines
          textInputAction: TextInputAction.search,
          cursorColor: ArchethicTheme.text,
          inputFormatters: <TextInputFormatter>[
            UpperCaseTextFormatter(),
            LengthLimitingTextInputFormatter(68),
          ],
        ),
      ],
    );
  }
}
