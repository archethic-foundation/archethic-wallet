/// SPDX-License-Identifier: AGPL-3.0-or-later
// ignore_for_file: avoid_unnecessary_containers

// Flutter imports:
import 'dart:convert';
import 'dart:io';

import 'package:aewallet/bus/nft_file_add_event.dart';
import 'package:aewallet/model/data/account_token.dart';
import 'package:aewallet/model/data/token_informations.dart';
import 'package:aewallet/model/data/token_informations_property.dart';
import 'package:aewallet/model/primary_currency.dart';
import 'package:aewallet/ui/util/ui_util.dart';
import 'package:aewallet/ui/views/nft/add_nft_file_confirm.dart';
import 'package:aewallet/ui/views/nft/nft_preview.dart';
import 'package:aewallet/ui/widgets/components/app_text_field.dart';
import 'package:aewallet/ui/widgets/components/balance_indicator.dart';
import 'package:aewallet/ui/widgets/components/sheet_util.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:event_taxi/event_taxi.dart';
import 'package:file_picker/file_picker.dart';
import 'package:filesize/filesize.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_size_text/auto_size_text.dart';

// Project imports:
import 'package:aewallet/appstate_container.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/ui/util/dimens.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/widgets/components/buttons.dart';
import 'package:aewallet/ui/widgets/components/tap_outside_unfocus.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mime_dart/mime_dart.dart';
import 'package:path/path.dart';
import 'package:image_picker/image_picker.dart';

class AddNFTFile extends StatefulWidget {
  const AddNFTFile({
    required this.process,
    this.primaryCurrency,
    super.key,
  });

  final AddNFTFileProcess? process;
  final PrimaryCurrencySetting? primaryCurrency;

  @override
  State<AddNFTFile> createState() => _AddNFTFileState();
}

enum AddNFTFileProcess { single, collection }

class _AddNFTFileState extends State<AddNFTFile> {
  File? file;
  String file64 = '';
  String typeMime = '';
  FocusNode? nftNameFocusNode;
  FocusNode? nftDescriptionFocusNode;
  FocusNode? nftPropertyNameFocusNode;
  FocusNode? nftPropertyValueFocusNode;
  TextEditingController? nftNameController;
  TextEditingController? nftDescriptionController;
  TextEditingController? nftPropertyNameController;
  TextEditingController? nftPropertyValueController;
  int importSelection = 0;
  List<TokenProperty> tokenProperties =
      List<TokenProperty>.empty(growable: true);
  String addNFTPropertyMessage = '';

  @override
  void initState() {
    nftNameFocusNode = FocusNode();
    nftDescriptionFocusNode = FocusNode();
    nftPropertyNameFocusNode = FocusNode();
    nftPropertyValueFocusNode = FocusNode();
    nftNameController = TextEditingController();
    nftDescriptionController = TextEditingController();
    nftPropertyNameController = TextEditingController();
    nftPropertyValueController = TextEditingController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TapOutsideUnfocus(
      child: SafeArea(
        minimum:
            EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.035),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(
                  width: 60,
                ),
                Column(
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      height: 5,
                      width: MediaQuery.of(context).size.width * 0.15,
                      decoration: BoxDecoration(
                        color: StateContainer.of(context).curTheme.text60,
                        borderRadius: BorderRadius.circular(100.0),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 15.0),
                      constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width - 140),
                      child: Column(
                        children: <Widget>[
                          AutoSizeText(
                            AppLocalization.of(context)!.addNFTFile,
                            style: AppStyles.textStyleSize24W700EquinoxPrimary(
                                context),
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            stepGranularity: 0.1,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 60,
                  height: 40,
                ),
              ],
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 80),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (widget.process == AddNFTFileProcess.single)
                        Container(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: BalanceIndicatorWidget(
                              primaryCurrency: widget.primaryCurrency,
                              displaySwitchButton: false),
                        ),
                      Text(
                        AppLocalization.of(context)!.nftAddStep1,
                        style: AppStyles.textStyleSize14W600Primary(context),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 40,
                        child: InkWell(
                          onTap: () async {
                            importSelection = 1;
                            FilePickerResult? result =
                                await FilePicker.platform.pickFiles();

                            if (result != null) {
                              file = File(result.files.single.path!);
                              setFileProperties(file!);
                            } else {
                              // User canceled the picker
                            }
                          },
                          child: Row(
                            children: <Widget>[
                              SizedBox(
                                width: 30,
                                child: FaIcon(FontAwesomeIcons.file,
                                    size: 18,
                                    color: StateContainer.of(context)
                                        .curTheme
                                        .text),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Text(
                                AppLocalization.of(context)!.nftAddImportFile,
                                style: AppStyles.textStyleSize12W400Primary(
                                    context),
                              ),
                              const SizedBox(
                                width: 30,
                              ),
                              if (importSelection == 1)
                                const Icon(
                                  Icons.check_circle,
                                  size: 16,
                                  color: Colors.green,
                                )
                            ],
                          ),
                        ),
                      ),
                      if (kIsWeb == false &&
                          (Platform.isAndroid || Platform.isIOS))
                        Divider(
                          height: 2,
                          color: StateContainer.of(context).curTheme.text15,
                        ),
                      if (kIsWeb == false &&
                          (Platform.isAndroid || Platform.isIOS))
                        SizedBox(
                          height: 40,
                          child: InkWell(
                            onTap: () async {
                              XFile? pickedFile = await ImagePicker().pickImage(
                                source: ImageSource.gallery,
                                maxWidth: 1800,
                                maxHeight: 1800,
                              );
                              if (pickedFile != null) {
                                importSelection = 2;
                                file = File(pickedFile.path);
                                setFileProperties(file!);
                              }
                            },
                            child: Container(
                              child: Row(
                                children: <Widget>[
                                  SizedBox(
                                    width: 30,
                                    child: FaIcon(FontAwesomeIcons.photoFilm,
                                        size: 18,
                                        color: StateContainer.of(context)
                                            .curTheme
                                            .text),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    AppLocalization.of(context)!
                                        .nftAddImportPhoto,
                                    style: AppStyles.textStyleSize12W400Primary(
                                        context),
                                  ),
                                  const SizedBox(
                                    width: 30,
                                  ),
                                  if (importSelection == 2)
                                    const Icon(
                                      Icons.check_circle,
                                      size: 16,
                                      color: Colors.green,
                                    )
                                ],
                              ),
                            ),
                          ),
                        ),
                      Divider(
                        height: 2,
                        color: StateContainer.of(context).curTheme.text15,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text(
                            AppLocalization.of(context)!.nftAddStep2,
                            style:
                                AppStyles.textStyleSize14W600Primary(context),
                          ),
                        ],
                      ),
                      AppTextField(
                        focusNode: nftNameFocusNode,
                        controller: nftNameController,
                        cursorColor: StateContainer.of(context).curTheme.text,
                        textInputAction: TextInputAction.next,
                        labelText: AppLocalization.of(context)!.nftNameHint,
                        autocorrect: false,
                        keyboardType: TextInputType.text,
                        style: AppStyles.textStyleSize16W600Primary(context),
                        inputFormatters: <LengthLimitingTextInputFormatter>[
                          LengthLimitingTextInputFormatter(40),
                        ],
                        onChanged: (_) {
                          setState(() {});
                        },
                      ),
                      AppTextField(
                        focusNode: nftDescriptionFocusNode,
                        controller: nftDescriptionController,
                        cursorColor: StateContainer.of(context).curTheme.text,
                        textInputAction: TextInputAction.next,
                        labelText:
                            AppLocalization.of(context)!.nftDescriptionHint,
                        autocorrect: false,
                        keyboardType: TextInputType.text,
                        style: AppStyles.textStyleSize16W600Primary(context),
                        inputFormatters: <LengthLimitingTextInputFormatter>[
                          LengthLimitingTextInputFormatter(100),
                        ],
                        onChanged: (_) {
                          setState(() {});
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Text(
                            AppLocalization.of(context)!.nftAddStep3,
                            style:
                                AppStyles.textStyleSize14W600Primary(context),
                          ),
                        ],
                      ),
                      AppTextField(
                        focusNode: nftPropertyNameFocusNode,
                        controller: nftPropertyNameController,
                        cursorColor: StateContainer.of(context).curTheme.text,
                        textInputAction: TextInputAction.next,
                        labelText:
                            AppLocalization.of(context)!.nftPropertyNameHint,
                        autocorrect: false,
                        onChanged: (_) {
                          setState(() {});
                        },
                        keyboardType: TextInputType.text,
                        style: AppStyles.textStyleSize16W600Primary(context),
                        inputFormatters: <LengthLimitingTextInputFormatter>[
                          LengthLimitingTextInputFormatter(40),
                        ],
                      ),
                      AppTextField(
                        focusNode: nftPropertyValueFocusNode,
                        controller: nftPropertyValueController,
                        cursorColor: StateContainer.of(context).curTheme.text,
                        textInputAction: TextInputAction.next,
                        labelText:
                            AppLocalization.of(context)!.nftPropertyValueHint,
                        autocorrect: false,
                        onChanged: (_) {
                          setState(() {});
                        },
                        keyboardType: TextInputType.text,
                        style: AppStyles.textStyleSize16W600Primary(context),
                        inputFormatters: <LengthLimitingTextInputFormatter>[
                          LengthLimitingTextInputFormatter(40),
                        ],
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Text(addNFTPropertyMessage,
                            textAlign: TextAlign.center,
                            style:
                                AppStyles.textStyleSize12W100Primary(context)),
                      ),
                      Row(
                        children: <Widget>[
                          nftPropertyNameController!.text.isNotEmpty &&
                                  nftPropertyValueController!.text.isNotEmpty
                              ? AppButton.buildAppButtonTiny(
                                  const Key('addNFTProperty'),
                                  context,
                                  AppButtonType.primary,
                                  AppLocalization.of(context)!.addNFTProperty,
                                  Dimens.buttonBottomDimens, onPressed: () {
                                  if (validateAddNFTProperty()) {
                                    tokenProperties.sort(
                                        (TokenProperty a, TokenProperty b) => a
                                            .name!
                                            .toLowerCase()
                                            .compareTo(b.name!.toLowerCase()));
                                    setState(() {
                                      tokenProperties.add(TokenProperty(
                                          name: nftPropertyNameController!.text,
                                          value: nftPropertyValueController!
                                              .text));
                                      nftPropertyNameController!.text = '';
                                      nftPropertyValueController!.text = '';
                                      FocusScope.of(context).requestFocus(
                                          nftPropertyNameFocusNode);
                                    });
                                  }
                                })
                              : AppButton.buildAppButtonTiny(
                                  const Key('addNFTProperty'),
                                  context,
                                  AppButtonType.primaryOutline,
                                  AppLocalization.of(context)!.addNFTProperty,
                                  Dimens.buttonBottomDimens,
                                  onPressed: () {})
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        children: [
                          Text(
                            AppLocalization.of(context)!.nftAddPreview,
                            style:
                                AppStyles.textStyleSize14W600Primary(context),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      if (file != null)
                        NFTPreviewWidget(
                            nftName: nftNameController!.text,
                            nftDescription: nftDescriptionController!.text,
                            nftFile: File(file!.path).readAsBytesSync(),
                            nftProperties: tokenProperties),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      AppButton.buildAppButton(
                        const Key('addNFTFile'),
                        context,
                        AppButtonType.primary,
                        AppLocalization.of(context)!.addNFTFile,
                        Dimens.buttonTopDimens,
                        onPressed: () async {
                          tokenProperties
                              .add(TokenProperty(name: 'file', value: file64));
                          tokenProperties.add(TokenProperty(
                              name: 'name', value: nftNameController!.text));
                          tokenProperties.add(TokenProperty(
                              name: 'description',
                              value: nftDescriptionController!.text));
                          tokenProperties.add(TokenProperty(
                              name: 'type/mime', value: typeMime));
                          if (widget.process == AddNFTFileProcess.collection) {
                            EventTaxiImpl.singleton().fire(NftFileAddEvent(
                                tokenProperties: tokenProperties));
                            Navigator.of(context).pop();
                          } else {
                            Token token = Token(
                                name: nftNameController!.text,
                                supply: 100000000,
                                symbol: '',
                                type: 'non-fungible');
                            token.tokenProperties =
                                List<List<TokenProperty>>.empty(growable: true);
                            token.tokenProperties!.add(tokenProperties);

                            Sheets.showAppHeightNineSheet(
                              context: context,
                              widget: AddNFTFileConfirm(token: token),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool validateAddNFTProperty() {
    bool isValid = true;
    setState(() {
      addNFTPropertyMessage = '';
    });

    if (nftPropertyNameController!.text.isEmpty) {
      setState(() {
        addNFTPropertyMessage = 'Le nom est obligatoire';
        isValid = false;
      });
    } else {
      if (nftPropertyValueController!.text.isEmpty) {
        setState(() {
          addNFTPropertyMessage = 'La valeur est obligatoire';
          isValid = false;
        });
      } else {
        for (TokenProperty tokenProperty in tokenProperties) {
          if (tokenProperty.name == nftPropertyNameController!.text) {
            setState(() {
              addNFTPropertyMessage = 'Le nom existe déjà';
              isValid = false;
            });
          }
        }
      }
    }

    return isValid;
  }

  void setFileProperties(File file, {bool copyNFTName = false}) {
    if (copyNFTName == true) {
      nftNameController!.text = basename(file.path);
    }
    final bytes = File(file.path).readAsBytesSync();
    file64 = base64Encode(bytes);
    try {
      typeMime = Mime.getTypesFromExtension(
          extension(file.path).replaceAll('.', ''))![0];
    } catch (e) {}
    setState(() {});
  }
}
