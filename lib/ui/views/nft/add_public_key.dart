/// SPDX-License-Identifier: AGPL-3.0-or-later

// Dart imports:
import 'dart:io';

// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// Project imports:
import 'package:aewallet/appstate_container.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/model/data/contact.dart';
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

class AddPublicKey extends StatefulWidget {
  const AddPublicKey(
      {super.key,
      required this.tokenPropertyWithAccessInfos,
      this.returnPublicKeys});

  final TokenPropertyWithAccessInfos tokenPropertyWithAccessInfos;
  final Function(List<String>)? returnPublicKeys;

  @override
  State<AddPublicKey> createState() => _AddPublicKeyState();
}

class _AddPublicKeyState extends State<AddPublicKey> {
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
    return Column(
      children: <Widget>[
        SheetHeader(title: AppLocalization.of(context)!.addPublicKeyHeader),
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
                          Text(widget.tokenPropertyWithAccessInfos
                              .tokenProperty!.keys.first),
                          Text(widget.tokenPropertyWithAccessInfos
                              .tokenProperty!.values.first),
                          Padding(
                            padding: const EdgeInsets.only(top: 20, bottom: 20),
                            child: Text(
                              'Add or remove public keys that can access this property.',
                              style:
                                  AppStyles.textStyleSize12W100Primary(context),
                              textAlign: TextAlign.justify,
                            ),
                          ),
                          AppTextField(
                            focusNode: publicKeyAccessFocusNode,
                            controller: publicKeyAccessController,
                            cursorColor:
                                StateContainer.of(context).curTheme.text,
                            textInputAction: TextInputAction.next,
                            labelText:
                                AppLocalization.of(context)!.publicKeyAddHint,
                            autocorrect: false,
                            maxLines: 3,
                            keyboardType: TextInputType.text,
                            style:
                                AppStyles.textStyleSize16W600Primary(context),
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
                                        .activeVibrations);
                                Contact? contact =
                                    await ContactsDialog.getDialog(context);
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
                                              .activeVibrations);
                                      UIUtil.cancelLockEvent();
                                      final String? scanResult =
                                          await UserDataUtil.getQRData(
                                              DataType.raw, context);
                                      QRScanErrs.errorList;
                                      if (scanResult == null) {
                                        UIUtil.showSnackbar(
                                            AppLocalization.of(context)!
                                                .qrInvalidAddress,
                                            context,
                                            StateContainer.of(context)
                                                .curTheme
                                                .text!,
                                            StateContainer.of(context)
                                                .curTheme
                                                .snackBarShadow!);
                                      } else if (QRScanErrs.errorList
                                          .contains(scanResult)) {
                                        UIUtil.showSnackbar(
                                            scanResult,
                                            context,
                                            StateContainer.of(context)
                                                .curTheme
                                                .text!,
                                            StateContainer.of(context)
                                                .curTheme
                                                .snackBarShadow!);
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
                              publicKeyAccessController!.text.isNotEmpty &&
                                      publicKeyAccessController!.text.isNotEmpty
                                  ? AppButton.buildAppButtonTiny(
                                      const Key('addPublicKey'),
                                      context,
                                      AppButtonType.primary,
                                      AppLocalization.of(context)!
                                          .addNFTProperty,
                                      Dimens.buttonBottomDimens,
                                      onPressed: () async {
                                      sl.get<HapticUtil>().feedback(
                                          FeedbackType.light,
                                          StateContainer.of(context)
                                              .activeVibrations);
                                      setState(() {
                                        publicKeys!.add(
                                            publicKeyAccessController!.text);
                                        publicKeys!.sort((a, b) => a
                                            .toLowerCase()
                                            .compareTo(b.toLowerCase()));
                                        publicKeyAccessController!.text = '';
                                      });
                                    })
                                  : AppButton.buildAppButtonTiny(
                                      const Key('addPublicKey'),
                                      context,
                                      AppButtonType.primaryOutline,
                                      AppLocalization.of(context)!
                                          .addNFTProperty,
                                      Dimens.buttonBottomDimens,
                                      onPressed: () {}),
                            ],
                          ),
                          if (publicKeys != null)
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 20, left: 10, right: 10),
                              child: Wrap(
                                  alignment: WrapAlignment.start,
                                  children: publicKeys!
                                      .asMap()
                                      .entries
                                      .map((MapEntry<dynamic, String> entry) {
                                    return Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: _buildLine(context, entry.value),
                                    );
                                  }).toList()),
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

  Widget _buildLine(BuildContext context, String publicKey) {
    return Container(
      padding: const EdgeInsets.only(bottom: 8),
      child: GestureDetector(
        onTap: () async {},
        onLongPress: () {},
        child: Card(
          shape: RoundedRectangleBorder(
            side: BorderSide(
                color: StateContainer.of(context)
                    .curTheme
                    .backgroundAccountsListCardSelected!,
                width: 1.0),
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 0,
          color: StateContainer.of(context)
              .curTheme
              .backgroundAccountsListCardSelected,
          child: Container(
            height: 60,
            color:
                StateContainer.of(context).curTheme.backgroundAccountsListCard,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                                    style: AppStyles.textStyleSize12W600Primary(
                                        context),
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
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                        color: StateContainer.of(context)
                                            .curTheme
                                            .backgroundDark!
                                            .withOpacity(0.3),
                                        border: Border.all(
                                            color: StateContainer.of(context)
                                                .curTheme
                                                .backgroundDarkest!
                                                .withOpacity(0.2),
                                            width: 2),
                                      ),
                                      child: IconButton(
                                        icon: Icon(Icons.close,
                                            color: StateContainer.of(context)
                                                .curTheme
                                                .backgroundDarkest!,
                                            size: 21),
                                        onPressed: () {
                                          sl.get<HapticUtil>().feedback(
                                              FeedbackType.light,
                                              StateContainer.of(context)
                                                  .activeVibrations);
                                          AppDialogs.showConfirmDialog(
                                              context,
                                              'Delete public key',
                                              'Are you sure ?',
                                              AppLocalization.of(context)!
                                                  .deleteOption, () {
                                            sl.get<HapticUtil>().feedback(
                                                FeedbackType.light,
                                                StateContainer.of(context)
                                                    .activeVibrations);
                                            publicKeys!.removeWhere((element) =>
                                                element == publicKey);

                                            setState(() {});
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
