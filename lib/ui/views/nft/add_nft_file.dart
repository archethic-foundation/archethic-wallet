/// SPDX-License-Identifier: AGPL-3.0-or-later
// ignore_for_file: avoid_unnecessary_containers

// Flutter imports:
import 'dart:convert';
import 'dart:io';

import 'package:aewallet/bus/nft_file_add_event.dart';
import 'package:aewallet/model/primary_currency.dart';
import 'package:aewallet/service/app_service.dart';
import 'package:aewallet/ui/views/nft/add_nft_file_confirm.dart';
import 'package:aewallet/ui/views/nft/nft_preview.dart';
import 'package:aewallet/ui/widgets/components/app_text_field.dart';
import 'package:aewallet/ui/widgets/components/balance_indicator.dart';
import 'package:aewallet/ui/widgets/components/dialog.dart';
import 'package:aewallet/ui/widgets/components/network_indicator.dart';
import 'package:aewallet/ui/widgets/components/sheet_header.dart';
import 'package:aewallet/ui/widgets/components/sheet_util.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/haptic_util.dart';
import 'package:aewallet/util/mime_util.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:event_taxi/event_taxi.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Project imports:
import 'package:aewallet/appstate_container.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/ui/util/dimens.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/widgets/components/buttons.dart';
import 'package:aewallet/ui/widgets/components/tap_outside_unfocus.dart';
import 'package:flutter/services.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mime_dart/mime_dart.dart';
import 'package:path/path.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pdfx/pdfx.dart';

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
  Uint8List? fileDecodedForPreview;
  Uint8List? fileDecoded;
  int sizeFile = 0;
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
  String addNFTMessage = '';
  double feeEstimation = 0.0;
  bool? _isPressed;
  Token token = Token();

  @override
  void initState() {
    _isPressed = false;
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
            SheetHeader(
                title: AppLocalization.of(context)!.addNFTFile,
                widgetBeforeTitle: widget.process == AddNFTFileProcess.single
                    ? const NetworkIndicator()
                    : null,
                widgetAfterTitle: widget.process == AddNFTFileProcess.single
                    ? Container(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: BalanceIndicatorWidget(
                            primaryCurrency: widget.primaryCurrency,
                            displaySwitchButton: false),
                      )
                    : null),
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 80),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                              await setFileProperties(file!);
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
                                await setFileProperties(file!);
                              }
                            },
                            child: Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: <Widget>[
                                      SizedBox(
                                        width: 30,
                                        child: FaIcon(
                                            FontAwesomeIcons.photoFilm,
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
                                        style: AppStyles
                                            .textStyleSize12W400Primary(
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
                                  InkWell(
                                    onTap: () {
                                      sl.get<HapticUtil>().feedback(
                                          FeedbackType.light,
                                          StateContainer.of(context)
                                              .activeVibrations);
                                      AppDialogs.showInfoDialog(
                                        context,
                                        AppLocalization.of(context)!
                                            .informations,
                                        AppLocalization.of(context)!
                                            .nftAddPhotoFormatInfo,
                                      );
                                    },
                                    child: SizedBox(
                                      width: 30,
                                      child: FaIcon(FontAwesomeIcons.circleInfo,
                                          size: 18,
                                          color: StateContainer.of(context)
                                              .curTheme
                                              .text),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      Divider(
                        height: 2,
                        color: StateContainer.of(context).curTheme.text15,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Text(addNFTMessage,
                            textAlign: TextAlign.center,
                            style:
                                AppStyles.textStyleSize12W100Primary(context)),
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
                          LengthLimitingTextInputFormatter(30),
                        ],
                        onChanged: (_) async {
                          double fee = await getFee(context);
                          // Always reset the error message to be less annoying
                          setState(() {
                            feeEstimation = fee;
                          });
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
                          LengthLimitingTextInputFormatter(40),
                        ],
                        onChanged: (_) async {
                          double fee = await getFee(context);
                          // Always reset the error message to be less annoying
                          setState(() {
                            feeEstimation = fee;
                          });
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
                        onChanged: (_) async {
                          double fee = await getFee(context);
                          // Always reset the error message to be less annoying
                          setState(() {
                            feeEstimation = fee;
                          });
                        },
                        keyboardType: TextInputType.text,
                        style: AppStyles.textStyleSize16W600Primary(context),
                        inputFormatters: <LengthLimitingTextInputFormatter>[
                          LengthLimitingTextInputFormatter(20),
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
                        onChanged: (_) async {
                          double fee = await getFee(context);
                          // Always reset the error message to be less annoying
                          setState(() {
                            feeEstimation = fee;
                          });
                        },
                        keyboardType: TextInputType.text,
                        style: AppStyles.textStyleSize16W600Primary(context),
                        inputFormatters: <LengthLimitingTextInputFormatter>[
                          LengthLimitingTextInputFormatter(20),
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
                                  Dimens.buttonBottomDimens,
                                  onPressed: () async {
                                  if (validateAddNFTProperty() == true) {
                                    tokenProperties.sort(
                                        (TokenProperty a, TokenProperty b) => a
                                            .name!
                                            .toLowerCase()
                                            .compareTo(b.name!.toLowerCase()));
                                    double fee = await getFee(context);
                                    setState(() {
                                      tokenProperties.add(TokenProperty(
                                          name: nftPropertyNameController!.text,
                                          value: nftPropertyValueController!
                                              .text));
                                      nftPropertyNameController!.text = '';
                                      nftPropertyValueController!.text = '';
                                      FocusScope.of(context).requestFocus(
                                          nftPropertyNameFocusNode);
                                      feeEstimation = fee;
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
                      feeEstimation > 0
                          ? Padding(
                              padding:
                                  const EdgeInsets.only(left: 30, right: 30),
                              child: Text(
                                '${AppLocalization.of(context)!.estimatedFees}: $feeEstimation ${StateContainer.of(context).curNetwork.getNetworkCryptoCurrencyLabel()}',
                                style: AppStyles.textStyleSize14W100Primary(
                                    context),
                                textAlign: TextAlign.justify,
                              ),
                            )
                          : Padding(
                              padding:
                                  const EdgeInsets.only(left: 30, right: 30),
                              child: Text(
                                AppLocalization.of(context)!
                                    .estimatedFeesAddTokenNote,
                                style: AppStyles.textStyleSize14W100Primary(
                                    context),
                                textAlign: TextAlign.justify,
                              ),
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
                            context: context,
                            nftDescription: nftDescriptionController!.text,
                            nftTypeMime: typeMime,
                            nftFile: fileDecodedForPreview,
                            nftSize: sizeFile,
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
                      _isPressed == true
                          ? AppButton.buildAppButton(
                              const Key('addNFTFile'),
                              context,
                              AppButtonType.primaryOutline,
                              AppLocalization.of(context)!.addNFTFile,
                              Dimens.buttonTopDimens,
                              onPressed: () async {},
                            )
                          : AppButton.buildAppButton(
                              const Key('addNFTFile'),
                              context,
                              AppButtonType.primary,
                              AppLocalization.of(context)!.addNFTFile,
                              Dimens.buttonTopDimens,
                              onPressed: () async {
                                setState(() {
                                  _isPressed = true;
                                });
                                updateToken();
                                if (await validateAddNFT(context) == true) {
                                  if (widget.process ==
                                      AddNFTFileProcess.collection) {
                                    EventTaxiImpl.singleton().fire(
                                        NftFileAddEvent(
                                            tokenProperties: tokenProperties));
                                    Navigator.of(context).pop();
                                  } else {
                                    Sheets.showAppHeightNineSheet(
                                      context: context,
                                      widget: AddNFTFileConfirm(
                                          token: token,
                                          filePreview: fileDecodedForPreview!,
                                          sizeFile: sizeFile),
                                      onDisposed: () {
                                        if (mounted) {
                                          setState(() {
                                            _isPressed = false;
                                          });
                                        }
                                      },
                                    );
                                  }
                                } else {
                                  setState(() {
                                    _isPressed = false;
                                  });
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

  Future<bool> validateAddNFT(BuildContext context) async {
    bool isValid = true;
    setState(() {
      addNFTMessage = '';
    });

    if (file == null) {
      setState(() {
        addNFTMessage = 'Veuillez importer un fichier ou une photo.';
        isValid = false;
      });
    } else {
      if (nftNameController!.text.isEmpty) {
        setState(() {
          addNFTMessage = 'Le nom du NFT est obligatoire.';
          isValid = false;
        });
      } else {
        if (MimeUtil.isImage(typeMime) == false &&
            MimeUtil.isPdf(typeMime) == false) {
          setState(() {
            addNFTMessage = 'Le format n\'est pas pris en charge.';
            isValid = false;
          });
        } else {
          if (file64.length > 2500000) {
            setState(() {
              addNFTMessage = 'Le NFT ne peut excéder 2.5 Mo.';
              isValid = false;
            });
          } else {
            // Estimation of fees
            feeEstimation = await getFee(context);
            if (feeEstimation >
                StateContainer.of(context)
                    .appWallet!
                    .appKeychain!
                    .getAccountSelected()!
                    .balance!
                    .nativeTokenValue!) {
              isValid = false;
              setState(() {
                addNFTMessage = AppLocalization.of(context)!
                    .insufficientBalance
                    .replaceAll(
                        '%1',
                        StateContainer.of(context)
                            .curNetwork
                            .getNetworkCryptoCurrencyLabel());
              });
            }
          }
        }
      }
    }

    return isValid;
  }

  Future<void> setFileProperties(File file, {bool copyNFTName = false}) async {
    if (copyNFTName == true) {
      nftNameController!.text = basename(file.path);
    }
    fileDecoded = File(file.path).readAsBytesSync();
    file64 = base64Encode(fileDecoded!);
    sizeFile = fileDecoded!.length;

    try {
      typeMime = Mime.getTypesFromExtension(
          extension(file.path).replaceAll('.', ''))![0];
    } catch (e) {}

    if (MimeUtil.isImage(typeMime) == true) {
      fileDecodedForPreview = fileDecoded;
    } else {
      if (MimeUtil.isPdf(typeMime) == true) {
        PdfDocument pdfDocument = await PdfDocument.openData(
          File(file.path).readAsBytesSync(),
        );
        PdfPage pdfPage = await pdfDocument.getPage(1);

        PdfPageImage? pdfPageImage =
            await pdfPage.render(width: pdfPage.width, height: pdfPage.height);
        fileDecodedForPreview = pdfPageImage!.bytes;
      }
    }
    setState(() {});
  }

  Future<double> getFee(BuildContext context) async {
    double fee = 0;

    if (nftNameController!.text.isEmpty) {
      return fee;
    }
    try {
      final String? seed = await StateContainer.of(context).getSeed();
      final String originPrivateKey = sl.get<ApiService>().getOriginKey();
      updateToken();
      fee = await sl.get<AppService>().getFeesEstimationCreateToken(
          originPrivateKey,
          seed!,
          token,
          StateContainer.of(context)
              .appWallet!
              .appKeychain!
              .getAccountSelected()!
              .name!);
    } catch (e) {
      fee = 0;
    }
    return fee;
  }

  void updateToken() {
    tokenProperties.clear();
    tokenProperties.add(TokenProperty(name: 'file', value: file64));
    tokenProperties
        .add(TokenProperty(name: 'name', value: nftNameController!.text));
    tokenProperties.add(TokenProperty(
        name: 'description', value: nftDescriptionController!.text));
    tokenProperties.add(TokenProperty(name: 'type/mime', value: typeMime));

    token = Token(
        name: nftNameController!.text,
        supply: 100000000,
        symbol: '',
        id: "1",
        type: 'non-fungible');
    token.tokenProperties = List<List<TokenProperty>>.empty(growable: true);
    token.tokenProperties!.add(tokenProperties);
  }
}
