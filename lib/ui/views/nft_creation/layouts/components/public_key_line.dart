import 'package:aewallet/application/settings.dart';
import 'package:aewallet/application/theme.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/views/nft_creation/bloc/provider.dart';
import 'package:aewallet/ui/widgets/components/dialog.dart';
import 'package:aewallet/ui/widgets/components/item_remove_button.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/haptic_util.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';

class PublicKeyLine extends ConsumerWidget {
  const PublicKeyLine({
    super.key,
    required this.propertyName,
    required this.publicKey,
  });

  final String propertyName;
  final String publicKey;

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final preferences = ref.watch(SettingsProviders.settings);
    final localizations = AppLocalization.of(context)!;

    return Container(
      padding: const EdgeInsets.only(bottom: 8),
      child: Card(
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: theme.backgroundAccountsListCardSelected!,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 0,
        color: theme.backgroundAccountsListCardSelected,
        child: Container(
          height: 60,
          color: theme.backgroundAccountsListCard,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(top: 10),
                        width: MediaQuery.of(context).size.width - 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                AutoSizeText(
                                  '${publicKey.substring(0, 15)}...${publicKey.substring(publicKey.length - 15)}',
                                  style: theme.textStyleSize12W600Primary,
                                ),
                              ],
                            ),
                            ItemRemoveButton(
                              onPressed: () {
                                AppDialogs.showConfirmDialog(
                                    context,
                                    ref,
                                    localizations.removePublicKey,
                                    localizations.areYouSure,
                                    localizations.deleteOption, () {
                                  sl.get<HapticUtil>().feedback(
                                        FeedbackType.light,
                                        preferences.activeVibrations,
                                      );
                                  ref
                                      .watch(
                                        NftCreationFormProvider.nftCreationForm(
                                          ref.read(
                                            NftCreationFormProvider
                                                .nftCreationFormArgs,
                                          ),
                                        ).notifier,
                                      )
                                      .removePublicKey(
                                        propertyName,
                                        publicKey,
                                      );
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
