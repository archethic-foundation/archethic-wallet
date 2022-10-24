/// SPDX-License-Identifier: AGPL-3.0-or-later

// Project imports:
import 'package:aewallet/application/device_abilities.dart';
import 'package:aewallet/application/settings.dart';
import 'package:aewallet/application/theme.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/ui/util/dimens.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/util/ui_util.dart';
import 'package:aewallet/ui/views/nft_creation/bloc/provider.dart';
import 'package:aewallet/ui/views/nft_creation/layouts/get_public_key.dart';
import 'package:aewallet/ui/widgets/components/app_button_tiny.dart';
import 'package:aewallet/ui/widgets/components/app_text_field.dart';
import 'package:aewallet/ui/widgets/components/sheet_header.dart';
import 'package:aewallet/ui/widgets/dialogs/contacts_dialog.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/haptic_util.dart';
import 'package:aewallet/util/user_data_util.dart';
// Package imports:
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AddPublicKey extends ConsumerStatefulWidget {
  const AddPublicKey({
    super.key,
    required this.propertyName,
    required this.propertyValue,
  });

  final String propertyName;
  final String propertyValue;

  @override
  ConsumerState<AddPublicKey> createState() => _AddPublicKeyState();
}

class _AddPublicKeyState extends ConsumerState<AddPublicKey> {
  late FocusNode publicKeyAccessFocusNode;
  late TextEditingController publicKeyAccessController;

  @override
  void initState() {
    super.initState();

    publicKeyAccessFocusNode = FocusNode();
    publicKeyAccessController = TextEditingController();
  }

  @override
  void dispose() {
    publicKeyAccessFocusNode.dispose();
    publicKeyAccessController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalization.of(context)!;
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final preferences = ref.watch(SettingsProviders.settings);
    final nftCreation = ref.read(NftCreationFormProvider.nftCreationForm);
    final nftCreationNotifier =
        ref.watch(NftCreationFormProvider.nftCreationForm.notifier);
    final hasQRCode = ref.watch(DeviceAbilities.hasQRCodeProvider);

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
                            widget.propertyName,
                          ),
                          Text(
                            widget.propertyValue,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20, bottom: 20),
                            child: Text(
                              localizations.propertyAccessDescription,
                              style: theme.textStyleSize12W100Primary,
                              textAlign: TextAlign.justify,
                            ),
                          ),
                          AppTextField(
                            focusNode: publicKeyAccessFocusNode,
                            controller: publicKeyAccessController,
                            cursorColor: theme.text,
                            textInputAction: TextInputAction.next,
                            labelText: localizations.publicKeyAddHint,
                            autocorrect: false,
                            maxLines: 3,
                            keyboardType: TextInputType.text,
                            style: theme.textStyleSize16W600Primary,
                            inputFormatters: <LengthLimitingTextInputFormatter>[
                              LengthLimitingTextInputFormatter(68),
                            ],
                            onChanged: (text) {
                              nftCreationNotifier.addPublicKey(
                                widget.propertyName,
                                text,
                              );
                            },
                            prefixButton: TextFieldButton(
                              icon: FontAwesomeIcons.at,
                              onPressed: () async {
                                sl.get<HapticUtil>().feedback(
                                      FeedbackType.light,
                                      preferences.activeVibrations,
                                    );
                                final contact = await ContactsDialog.getDialog(
                                  context,
                                  ref,
                                );
                                if (contact != null) {
                                  publicKeyAccessController.text = contact.name;
                                }
                              },
                            ),
                            suffixButton: hasQRCode
                                ? TextFieldButton(
                                    icon: FontAwesomeIcons.qrcode,
                                    onPressed: () async {
                                      sl.get<HapticUtil>().feedback(
                                            FeedbackType.light,
                                            preferences.activeVibrations,
                                          );
                                      UIUtil.cancelLockEvent();
                                      final scanResult =
                                          await UserDataUtil.getQRData(
                                        DataType.raw,
                                        context,
                                        ref,
                                      );
                                      if (scanResult == null) {
                                        UIUtil.showSnackbar(
                                          localizations.qrInvalidAddress,
                                          context,
                                          ref,
                                          theme.text!,
                                          theme.snackBarShadow!,
                                        );
                                      } else if (QRScanErrs.errorList
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
                                        publicKeyAccessController.text =
                                            scanResult;
                                      }
                                    },
                                  )
                                : null,
                          ),
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
                                    if (publicKeyAccessController.text.length <
                                            68 ||
                                        !isHex(
                                          publicKeyAccessController.text,
                                        )) {
                                      UIUtil.showSnackbar(
                                        localizations.propertyAccessAddAccess,
                                        context,
                                        ref,
                                        theme.text!,
                                        theme.snackBarShadow!,
                                      );
                                    } else {
                                      final nftCreationNotifier = ref.watch(
                                        NftCreationFormProvider
                                            .nftCreationForm.notifier,
                                      );
                                      nftCreationNotifier.addPublicKey(
                                        widget.propertyName,
                                        publicKeyAccessController.text,
                                      );

                                      publicKeyAccessController.text = '';
                                    }
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
