/// SPDX-License-Identifier: AGPL-3.0-or-later

// Project imports:
import 'package:aewallet/application/device_abilities.dart';
import 'package:aewallet/application/settings.dart';
import 'package:aewallet/application/theme.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/model/data/appdb.dart';
import 'package:aewallet/model/data/contact.dart';
import 'package:aewallet/model/public_key.dart';
import 'package:aewallet/ui/util/dimens.dart';
import 'package:aewallet/ui/util/formatters.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/util/ui_util.dart';
import 'package:aewallet/ui/views/nft_creation/bloc/provider.dart';
import 'package:aewallet/ui/views/nft_creation/bloc/state.dart';
import 'package:aewallet/ui/views/nft_creation/layouts/get_public_key.dart';
import 'package:aewallet/ui/widgets/components/app_button_tiny.dart';
import 'package:aewallet/ui/widgets/components/app_text_field.dart';
import 'package:aewallet/ui/widgets/components/icons.dart';
import 'package:aewallet/ui/widgets/components/sheet_header.dart';
import 'package:aewallet/ui/widgets/dialogs/contacts_dialog.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/haptic_util.dart';
import 'package:aewallet/util/user_data_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

part 'components/add_public_key_textfield_pk.dart';

class AddPublicKey extends ConsumerWidget {
  const AddPublicKey({
    super.key,
    required this.propertyName,
    required this.propertyValue,
  });

  final String propertyName;
  final String propertyValue;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalization.of(context)!;
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final preferences = ref.watch(SettingsProviders.settings);
    final nftCreation = ref.watch(NftCreationFormProvider.nftCreationForm);

    return Column(
      children: <Widget>[
        SheetHeader(title: localizations.addPublicKeyHeader),
        Expanded(
          child: Center(
            child: Stack(
              children: <Widget>[
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.8,
                  child: SafeArea(
                    minimum: EdgeInsets.only(
                      bottom: MediaQuery.of(context).size.height * 0.035,
                      top: 20,
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          Text(
                            propertyName,
                          ),
                          Text(
                            propertyValue,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: Text(
                              localizations.propertyAccessDescription,
                              style: theme.textStyleSize12W100Primary,
                              textAlign: TextAlign.justify,
                            ),
                          ),
                          const AddPublicKeyTextFieldPk(),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: <Widget>[
                              if (nftCreation.canAddAccess)
                                AppButtonTiny(
                                  AppButtonTinyType.primary,
                                  localizations.propertyAccessAddAccess,
                                  Dimens.buttonBottomDimens,
                                  key: const Key('addPublicKey'),
                                  onPressed: () async {
                                    sl.get<HapticUtil>().feedback(
                                          FeedbackType.light,
                                          preferences.activeVibrations,
                                        );

                                    final nftCreationNotifier = ref.watch(
                                      NftCreationFormProvider
                                          .nftCreationForm.notifier,
                                    );
                                    nftCreationNotifier.addPublicKey(
                                      propertyName,
                                      nftCreation.propertyAccessRecipient,
                                    );
                                  },
                                )
                              else
                                AppButtonTiny(
                                  AppButtonTinyType.primaryOutline,
                                  localizations.propertyAccessAddAccess,
                                  Dimens.buttonBottomDimens,
                                  key: const Key('addPublicKey'),
                                  onPressed: () {},
                                ),
                            ],
                          ),
                          GetPublicKeys(
                            propertyName: propertyName,
                            propertyValue: propertyValue,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
