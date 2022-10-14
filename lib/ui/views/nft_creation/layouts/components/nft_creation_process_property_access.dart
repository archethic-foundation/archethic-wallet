/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/application/theme.dart';
import 'package:aewallet/appstate_container.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/views/nft_creation/bloc/provider.dart';
import 'package:aewallet/ui/views/nft_creation/layouts/add_public_key.dart';
import 'package:aewallet/ui/views/nft_creation/layouts/get_public_key.dart';
import 'package:aewallet/ui/widgets/components/dialog.dart';
import 'package:aewallet/ui/widgets/components/sheet_util.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/haptic_util.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';

class NFTCreationProcessPropertyAccess extends ConsumerWidget {
  const NFTCreationProcessPropertyAccess({
    required this.propertyName,
    required this.propertyValue,
    required this.publicKeys,
    this.readOnly = false,
    this.propertiesHidden,
    super.key,
  });

  final String propertyName;
  final String propertyValue;
  final bool readOnly;
  final List<String>? propertiesHidden;
  final List<String> publicKeys;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (propertiesHidden != null && propertiesHidden!.contains(propertyName)) {
      return const SizedBox();
    }

    final localizations = AppLocalization.of(context)!;
    final theme = ref.watch(ThemeProviders.selectedTheme);

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: GestureDetector(
        onTap: () async {},
        onLongPress: () {},
        child: Card(
          shape: RoundedRectangleBorder(
            side: publicKeys.isNotEmpty
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
                                propertyName,
                                style: theme.textStyleSize12W600Primary,
                              ),
                            ),
                            Container(
                              width: 200,
                              padding: const EdgeInsets.only(left: 20),
                              child: AutoSizeText(
                                propertyValue,
                                style: theme.textStyleSize12W400Primary,
                              ),
                            ),
                            if (publicKeys.isNotEmpty)
                              if (publicKeys.length == 1)
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width - 180,
                                  padding: const EdgeInsets.only(
                                    left: 20,
                                  ),
                                  child: AutoSizeText(
                                    localizations
                                        .nftPropertyProtected1PublicKey,
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
                                    localizations.nftPropertyProtectedPublicKeys
                                        .replaceAll(
                                            '%1', publicKeys.length.toString()),
                                    style: theme.textStyleSize12W400Primary,
                                  ),
                                )
                            else
                              Container(
                                width: MediaQuery.of(context).size.width - 180,
                                padding: const EdgeInsets.only(left: 20),
                                child: AutoSizeText(
                                  localizations.nftPropertyNotProtected,
                                  style: theme.textStyleSize12W400Primary,
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    if (publicKeys.isNotEmpty)
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
                                    StateContainer.of(context).activeVibrations,
                                  );
                              if (readOnly) {
                                Sheets.showAppHeightNineSheet(
                                  context: context,
                                  ref: ref,
                                  widget: GetPublicKeys(
                                    propertyName: propertyName,
                                    propertyValue: propertyValue,
                                  ),
                                );
                              } else {
                                Sheets.showAppHeightNineSheet(
                                  context: context,
                                  ref: ref,
                                  widget: AddPublicKey(
                                    propertyName: propertyName,
                                    propertyValue: propertyValue,
                                  ),
                                );
                              }
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
                                NftCreationProvider.nftCreation.notifier,
                              );
                              sl.get<HapticUtil>().feedback(
                                    FeedbackType.light,
                                    StateContainer.of(context).activeVibrations,
                                  );
                              AppDialogs.showConfirmDialog(
                                  context,
                                  ref,
                                  localizations.deleteProperty,
                                  localizations.areYouSure,
                                  AppLocalization.of(context)!.deleteOption,
                                  () {
                                sl.get<HapticUtil>().feedback(
                                      FeedbackType.light,
                                      StateContainer.of(context)
                                          .activeVibrations,
                                    );
                                nftCreationNotifier.removeProperty(
                                  propertyName,
                                );
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
