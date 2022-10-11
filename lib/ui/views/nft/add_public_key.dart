/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:io';

// Project imports:
import 'package:aewallet/application/theme.dart';
import 'package:aewallet/appstate_container.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/model/token_property_with_access_infos.dart';
import 'package:aewallet/ui/util/dimens.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/util/ui_util.dart';
import 'package:aewallet/ui/widgets/components/app_text_field.dart';
import 'package:aewallet/ui/widgets/components/buttons.dart';
import 'package:aewallet/ui/widgets/components/dialog.dart';
import 'package:aewallet/ui/widgets/components/sheet_header.dart';
import 'package:aewallet/ui/widgets/dialogs/contacts_dialog.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/haptic_util.dart';
import 'package:aewallet/util/user_data_util.dart';
// Package imports:
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:auto_size_text/auto_size_text.dart';
// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AddPublicKey extends ConsumerStatefulWidget {
  const AddPublicKey({
    super.key,
    required this.tokenPropertyWithAccessInfos,
    this.returnPublicKeys,
  });

  final TokenPropertyWithAccessInfos tokenPropertyWithAccessInfos;
  final Function(List<String>)? returnPublicKeys;

  @override
  ConsumerState<AddPublicKey> createState() => _AddPublicKeyState();
}

class _AddPublicKeyState extends ConsumerState<AddPublicKey> {
  FocusNode? publicKeyAccessFocusNode;
  TextEditingController? publicKeyAccessController;
  List<String>? publicKeys;

  @override
  void initState() {
    publicKeyAccessFocusNode = FocusNode();
    publicKeyAccessController = TextEditingController();
    publicKeys = List<String>.empty(growable: true);
    if (widget.tokenPropertyWithAccessInfos.publicKeysList != null) {
      publicKeys = widget.tokenPropertyWithAccessInfos.publicKeysList;
      publicKeys!.sort((a, b) => a.toLowerCase().compareTo(b.toLowerCase()));
    }
    super.initState();
  }

  @override
  void dispose() {
    Future.delayed(Duration.zero, () {
      widget.returnPublicKeys!(publicKeys!);
    });

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalization.of(context)!;
    final theme = ref.watch(ThemeProviders.selectedTheme);

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
                            widget.tokenPropertyWithAccessInfos.tokenProperty!
                                .keys.first,
                          ),
                          Text(
                            widget.tokenPropertyWithAccessInfos.tokenProperty!
                                .values.first,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20, bottom: 20),
                            child: Text(
                              'Add or remove public keys that can access this property.',
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
                            onChanged: (_) {
                              setState(() {});
                            },
                            prefixButton: TextFieldButton(
                              icon: FontAwesomeIcons.at,
                              onPressed: () async {
                                sl.get<HapticUtil>().feedback(
                                      FeedbackType.light,
                                      StateContainer.of(context)
                                          .activeVibrations,
                                    );
                                final contact = await ContactsDialog.getDialog(
                                  context,
                                  ref,
                                );
                                if (contact != null && contact.name != null) {
                                  publicKeyAccessController!.text =
                                      contact.name!;
                                  setState(() {});
                                }
                              },
                            ),
                            suffixButton: kIsWeb == false &&
                                    (Platform.isIOS || Platform.isAndroid)
                                ? TextFieldButton(
                                    icon: FontAwesomeIcons.qrcode,
                                    onPressed: () async {
                                      sl.get<HapticUtil>().feedback(
                                            FeedbackType.light,
                                            StateContainer.of(context)
                                                .activeVibrations,
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
                                        setState(() {
                                          publicKeyAccessController!.text =
                                              scanResult;
                                        });
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
                              if (publicKeyAccessController!.text.isNotEmpty &&
                                  publicKeyAccessController!.text.isNotEmpty)
                                AppButton.buildAppButtonTiny(
                                  const Key('addPublicKey'),
                                  context,
                                  ref,
                                  AppButtonType.primary,
                                  localizations.addNFTProperty,
                                  Dimens.buttonBottomDimens,
                                  onPressed: () async {
                                    sl.get<HapticUtil>().feedback(
                                          FeedbackType.light,
                                          StateContainer.of(context)
                                              .activeVibrations,
                                        );
                                    if (publicKeyAccessController!.text.length <
                                            68 ||
                                        !isHex(
                                          publicKeyAccessController!.text,
                                        )) {
                                      UIUtil.showSnackbar(
                                        'The public key is not valid.',
                                        context,
                                        ref,
                                        theme.text!,
                                        theme.snackBarShadow!,
                                      );
                                    } else {
                                      setState(() {
                                        publicKeys!.add(
                                          publicKeyAccessController!.text,
                                        );
                                        publicKeys!.sort(
                                          (a, b) => a
                                              .toLowerCase()
                                              .compareTo(b.toLowerCase()),
                                        );
                                        publicKeyAccessController!.text = '';
                                      });
                                    }
                                  },
                                )
                              else
                                AppButton.buildAppButtonTiny(
                                  const Key('addPublicKey'),
                                  context,
                                  ref,
                                  AppButtonType.primaryOutline,
                                  localizations.addNFTProperty,
                                  Dimens.buttonBottomDimens,
                                  onPressed: () {},
                                ),
                            ],
                          ),
                          if (publicKeys != null)
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 20,
                                left: 10,
                                right: 10,
                              ),
                              child: Wrap(
                                children: publicKeys!
                                    .asMap()
                                    .entries
                                    .map((MapEntry<dynamic, String> entry) {
                                  return Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: _AddPublicKeyLine(
                                      publicKey: entry.value,
                                      onRemovePublicKey: () {
                                        setState(() {
                                          publicKeys!.removeWhere(
                                            (element) => element == entry.value,
                                          );
                                        });
                                      },
                                    ),
                                  );
                                }).toList(),
                              ),
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

class _AddPublicKeyLine extends ConsumerWidget {
  const _AddPublicKeyLine({
    required this.publicKey,
    required this.onRemovePublicKey,
  });

  final String publicKey;
  final VoidCallback onRemovePublicKey;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalization.of(context)!;
    final theme = ref.watch(ThemeProviders.selectedTheme);

    return Container(
      padding: const EdgeInsets.only(bottom: 8),
      child: GestureDetector(
        onTap: () async {},
        onLongPress: () {},
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
                                        color: theme.backgroundDark!
                                            .withOpacity(0.3),
                                        border: Border.all(
                                          color: theme.backgroundDarkest!
                                              .withOpacity(0.2),
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
                                          sl.get<HapticUtil>().feedback(
                                                FeedbackType.light,
                                                StateContainer.of(context)
                                                    .activeVibrations,
                                              );
                                          AppDialogs.showConfirmDialog(
                                            context,
                                            ref,
                                            'Delete public key', // TODO(reddwarf03): to internationalize
                                            'Are you sure ?',
                                            localizations.deleteOption,
                                            () {
                                              sl.get<HapticUtil>().feedback(
                                                    FeedbackType.light,
                                                    StateContainer.of(context)
                                                        .activeVibrations,
                                                  );
                                            },
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ],
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
      ),
    );
  }
}
