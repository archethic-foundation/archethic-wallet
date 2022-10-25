/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/application/settings.dart';
import 'package:aewallet/application/theme.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/views/nft_creation/bloc/provider.dart';
import 'package:aewallet/ui/views/nft_creation/layouts/add_public_key.dart';
import 'package:aewallet/ui/widgets/components/dialog.dart';
import 'package:aewallet/ui/widgets/components/sheet_util.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/haptic_util.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';

class NFTCreationProcessFileAccess extends ConsumerWidget {
  const NFTCreationProcessFileAccess({
    this.readOnly = false,
    super.key,
  });

  final bool readOnly;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nftCreation = ref.watch(NftCreationFormProvider.nftCreationForm);
    if (nftCreation.file == null) {
      return const SizedBox();
    }
    final localizations = AppLocalization.of(context)!;
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final preferences = ref.watch(SettingsProviders.settings);

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: GestureDetector(
        onTap: () async {},
        onLongPress: () {},
        child: Card(
          shape: RoundedRectangleBorder(
            side: nftCreation.file!.values.first.isNotEmpty
                ? const BorderSide(
                    color: Colors.redAccent,
                    width: 2,
                  )
                : BorderSide(
                    color: theme.backgroundAccountsListCardSelected!,
                  ),
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 0,
          color: theme.backgroundAccountsListCardSelected,
          child: Padding(
            padding: const EdgeInsets.only(
              top: 10,
              bottom: 10,
              right: 5,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                if (nftCreation.file!.values.first.isNotEmpty)
                  Column(
                    children: [
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: AutoSizeText(
                                  'File',
                                  style: theme.textStyleSize12W600Primary,
                                ),
                              ),
                              Container(
                                width: 200,
                                padding: const EdgeInsets.only(left: 20),
                                child: AutoSizeText(
                                  nftCreation.file!.values.first[0],
                                  style: theme.textStyleSize12W400Primary,
                                ),
                              ),
                              if (nftCreation.file!.values.length == 1)
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width - 180,
                                  padding: const EdgeInsets.only(
                                    left: 20,
                                  ),
                                  child: AutoSizeText(
                                    localizations.nftAssetProtected1PublicKey,
                                    style: theme.textStyleSize12W400Primary,
                                  ),
                                )
                              else
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width - 180,
                                  padding: const EdgeInsets.only(
                                    left: 20,
                                  ),
                                  child: AutoSizeText(
                                    localizations.nftAssetProtectedPublicKeys
                                        .replaceAll(
                                      '%1',
                                      nftCreation.file!.values.length
                                          .toString(),
                                    ),
                                    style: theme.textStyleSize12W400Primary,
                                  ),
                                )
                            ],
                          ),
                        ],
                      ),
                    ],
                  )
                else
                  Container(
                    width: MediaQuery.of(context).size.width - 180,
                    padding: const EdgeInsets.only(
                      left: 20,
                    ),
                    child: AutoSizeText(
                      localizations.nftAssetNotProtected,
                      style: theme.textStyleSize12W400Primary,
                    ),
                  ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: Container(
                        alignment: Alignment.center,
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: theme.backgroundDark!.withOpacity(0.3),
                          border: Border.all(
                            color: theme.backgroundDarkest!.withOpacity(0.2),
                            width: 2,
                          ),
                        ),
                        child: IconButton(
                          icon: Icon(
                            Icons.key,
                            color: theme.backgroundDarkest,
                            size: 21,
                          ),
                          onPressed: () {
                            sl.get<HapticUtil>().feedback(
                                  FeedbackType.light,
                                  preferences.activeVibrations,
                                );
                            Sheets.showAppHeightNineSheet(
                              context: context,
                              ref: ref,
                              overrides: [
                                NftCreationFormProvider.initialNftCreationForm
                                    .overrideWithValue(
                                  nftCreation,
                                ),
                              ],
                              widget: const AddPublicKey(
                                propertyName: 'file',
                                propertyValue: '',
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    if (readOnly == false)
                      Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child: Container(
                          alignment: Alignment.center,
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: theme.backgroundDark!.withOpacity(0.3),
                            border: Border.all(
                              color: theme.backgroundDarkest!.withOpacity(0.2),
                              width: 2,
                            ),
                          ),
                          child: IconButton(
                            icon: Icon(
                              Icons.close,
                              color: theme.backgroundDarkest,
                              size: 21,
                            ),
                            onPressed: () {
                              final nftCreationNotifier = ref.watch(
                                NftCreationFormProvider
                                    .nftCreationForm.notifier,
                              );
                              sl.get<HapticUtil>().feedback(
                                    FeedbackType.light,
                                    preferences.activeVibrations,
                                  );
                              AppDialogs.showConfirmDialog(
                                  context,
                                  ref,
                                  localizations.deleteFile,
                                  localizations.areYouSure,
                                  localizations.deleteOption, () {
                                sl.get<HapticUtil>().feedback(
                                      FeedbackType.light,
                                      preferences.activeVibrations,
                                    );
                                nftCreationNotifier.removeFileProperties();
                              });
                            },
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
