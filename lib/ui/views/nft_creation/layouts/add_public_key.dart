/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/application/device_abilities.dart';
import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/application/settings/theme.dart';
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
import 'package:aewallet/ui/widgets/components/scrollbar.dart';
import 'package:aewallet/ui/widgets/components/sheet_header.dart';
import 'package:aewallet/ui/widgets/components/tap_outside_unfocus.dart';
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

class AddPublicKey extends ConsumerStatefulWidget {
  const AddPublicKey({
    super.key,
    required this.propertyName,
    required this.propertyValue,
    required this.readOnly,
  });

  final String propertyName;
  final String propertyValue;
  final bool readOnly;

  @override
  ConsumerState<AddPublicKey> createState() => _AddPublicKeyState();
}

class _AddPublicKeyState extends ConsumerState<AddPublicKey> {
  late ScrollController scrollController;

  @override
  void initState() {
    scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalization.of(context)!;
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final preferences = ref.watch(SettingsProviders.settings);
    final nftCreation = ref.watch(
      NftCreationFormProvider.nftCreationForm(
        ref.read(
          NftCreationFormProvider.nftCreationFormArgs,
        ),
      ),
    );
    return TapOutsideUnfocus(
      child: SafeArea(
        minimum:
            EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.035),
        child: Column(
          children: <Widget>[
            SheetHeader(
              title: widget.readOnly
                  ? localizations.getPublicKeyHeader
                  : localizations.addPublicKeyHeader,
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(bottom: 10),
                child: ArchethicScrollbar(
                  child: Column(
                    children: <Widget>[
                      Text(
                        widget.propertyName,
                      ),
                      if (widget.propertyValue.isNotEmpty)
                        Text(
                          widget.propertyValue,
                        ),
                      if (widget.readOnly == false)
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Text(
                            localizations.propertyAccessDescription,
                            style: theme.textStyleSize12W100Primary,
                            textAlign: TextAlign.justify,
                          ),
                        )
                      else
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Text(
                            localizations.propertyAccessDescriptionReadOnly,
                            style: theme.textStyleSize12W100Primary,
                            textAlign: TextAlign.justify,
                          ),
                        ),
                      if (widget.readOnly == false)
                        const AddPublicKeyTextFieldPk(),
                      if (widget.readOnly == false)
                        const SizedBox(
                          height: 20,
                        ),
                      if (widget.readOnly == false)
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

                                  ref
                                      .watch(
                                        NftCreationFormProvider.nftCreationForm(
                                          ref.read(
                                            NftCreationFormProvider
                                                .nftCreationFormArgs,
                                          ),
                                        ).notifier,
                                      )
                                      .addPublicKey(
                                        widget.propertyName,
                                        nftCreation.propertyAccessRecipient,
                                        context,
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
                        propertyName: widget.propertyName,
                        propertyValue: widget.propertyValue,
                        readOnly: widget.readOnly,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Row(
              children: <Widget>[
                AppButtonTiny(
                  AppButtonTinyType.primary,
                  localizations.close,
                  Dimens.buttonTopDimens,
                  key: const Key('close'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
