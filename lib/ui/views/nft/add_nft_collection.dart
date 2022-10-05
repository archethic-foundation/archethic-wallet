/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';

import 'package:aewallet/bus/nft_file_add_event.dart';
import 'package:aewallet/model/primary_currency.dart';
// Package imports:
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:event_taxi/event_taxi.dart';
// Flutter imports:
import 'package:flutter/material.dart';

class AddNFTCollection extends StatefulWidget {
  const AddNFTCollection({
    super.key,
    this.primaryCurrency,
  });

  final PrimaryCurrencySetting? primaryCurrency;

  @override
  State<AddNFTCollection> createState() => _AddNFTCollectionState();
}

class _AddNFTCollectionState extends State<AddNFTCollection> {
  FocusNode? collectionNameFocusNode;
  FocusNode? collectionSymbolFocusNode;
  TextEditingController? collectionNameController;
  TextEditingController? collectionSymbolController;
  String? collectionNameValidationText;
  String? collectionSymbolValidationText;

  double feeEstimation = 0;
  bool? _isPressed;
  bool validRequest = true;

  int? supply;
  Token? token = Token(
    name: '',
    supply: 1,
    symbol: '',
    type: 'non-fungible',
    tokenProperties: {},
  );

  StreamSubscription<NftFileAddEvent>? _nftFileAddEventSub;

  void _registerBus() {
    _nftFileAddEventSub = EventTaxiImpl.singleton()
        .registerTo<NftFileAddEvent>()
        .listen((NftFileAddEvent event) {
      token!.tokenProperties!.addAll(event.tokenProperties!);
      setState(() {});
    });
  }

  void _destroyBus() {
    _nftFileAddEventSub?.cancel();
  }

  @override
  void initState() {
    _registerBus();

    super.initState();

    _isPressed = false;
    collectionNameFocusNode = FocusNode();
    collectionSymbolFocusNode = FocusNode();
    collectionNameController = TextEditingController();
    collectionSymbolController = TextEditingController();
    supply = 1;

    collectionNameValidationText = '';
    collectionSymbolValidationText = '';
  }

  @override
  void dispose() {
    _destroyBus();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //TODO(reddwarf03): refacto code with Riverpod
    return const SizedBox();
  }
}
   /* 
    final bottom = MediaQuery.of(context).viewInsets.bottom;
    final localizations = AppLocalization.of(context)!;
    final theme = StateContainer.of(context).curTheme;
    return TapOutsideUnfocus(
      child: SafeArea(
        minimum:
            EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.035),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SheetHeader(
              title: localizations.createNFTCollection,
              widgetBeforeTitle: BalanceIndicatorWidget(
                primaryCurrency: widget.primaryCurrency,
                displaySwitchButton: false,
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _AddNFTCollectionInfos(bottom: bottom),
                      _AddNFTCollectionNFTListPreview(
                        token: token!,
                      ),
                      if (feeEstimation > 0)
                        Padding(
                          padding: const EdgeInsets.only(left: 30, right: 30),
                          child: Text(
                            '${localizations.estimatedFees}: $feeEstimation ${StateContainer.of(context).curNetwork.getNetworkCryptoCurrencyLabel()}',
                            style: AppStyles.textStyleSize14W100Primary(
                              context,
                            ),
                            textAlign: TextAlign.justify,
                          ),
                        )
                      else
                        Padding(
                          padding: const EdgeInsets.only(left: 30, right: 30),
                          child: Text(
                            localizations.estimatedFeesAddTokenNote,
                            style: AppStyles.textStyleSize14W100Primary(
                              context,
                            ),
                            textAlign: TextAlign.justify,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
            Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    if (_isPressed == true ||
                        (_isPressed == false &&
                            (collectionNameController!.text.isEmpty ||
                                collectionSymbolController!.text.isEmpty)))
                      AppButton.buildAppButton(
                        const Key('createNFTCollection'),
                        context,
                        AppButtonType.primaryOutline,
                        localizations.createNFTCollection,
                        Dimens.buttonTopDimens,
                        onPressed: () {},
                      )
                    else
                      AppButton.buildAppButton(
                        const Key('createNFTCollection'),
                        context,
                        AppButtonType.primary,
                        localizations.createNFTCollection,
                        Dimens.buttonTopDimens,
                        onPressed: () async {
                          setState(() {
                            _isPressed = true;
                          });

                          validRequest = await _validateRequest(context);
                          if (validRequest) {
                            Sheets.showAppHeightNineSheet(
                              onDisposed: () {
                                if (mounted) {
                                  setState(() {
                                    _isPressed = false;
                                  });
                                }
                              },
                              context: context,
                              widget: AddNFTCollectionConfirm(
                                token: token,
                                feeEstimation: feeEstimation,
                              ),
                            );
                          } else {
                            setState(() {
                              _isPressed = false;
                            });
                            Navigator.of(context).popUntil(
                              RouteUtils.withNameLike('/home'),
                            );
                          }
                        },
                      ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    if (_isPressed == true ||
                        (_isPressed == false &&
                            (collectionNameController!.text.isEmpty ||
                                collectionSymbolController!.text.isEmpty)))
                      AppButton.buildAppButton(
                        const Key('saveNFTCollectionInLocal'),
                        context,
                        AppButtonType.primaryOutline,
                        localizations.saveNFTCollectionInLocal,
                        Dimens.buttonBottomDimens,
                        onPressed: () {},
                      )
                    else
                      AppButton.buildAppButton(
                        const Key('saveNFTCollectionInLocal'),
                        context,
                        AppButtonType.primary,
                        localizations.saveNFTCollectionInLocal,
                        Dimens.buttonBottomDimens,
                        onPressed: () async {
                          setState(() {
                            _isPressed = true;
                          });

                          validRequest = await _validateRequest(context);
                          if (validRequest) {
                            var tokenInformations = TokenInformations();
                            tokenInformations.tokenProperties =
                                List<TokenInformationsProperty>.empty(
                              growable: true,
                            );
                            tokenInformations = TokenInformationsService
                                .tokenToTokenInformations(token!);
                            tokenInformations.onChain = false;
                            if (StateContainer.of(context)
                                    .appWallet!
                                    .appKeychain!
                                    .getAccountSelected()!
                                    .accountNFT ==
                                null) {
                              StateContainer.of(context)
                                  .appWallet!
                                  .appKeychain!
                                  .getAccountSelected()!
                                  .accountNFT = List<AccountToken>.empty(
                                growable: true,
                              );
                            }
                            StateContainer.of(context)
                                .appWallet!
                                .appKeychain!
                                .getAccountSelected()!
                                .accountNFT!
                                .add(
                                  AccountToken(
                                    tokenInformations: tokenInformations,
                                  ),
                                );
                            UIUtil.showSnackbar(
                              'Saved',
                              context,
                              theme.text!,
                              StateContainer.of(context)
                                  .curTheme
                                  .snackBarShadow!,
                            );
                            Navigator.of(context).pop();
                          }
                          setState(() {
                            _isPressed = false;
                          });
                        },
                      ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> _validateRequest(BuildContext context) async {
    final localizations = AppLocalization.of(context)!;
    var isValid = true;
    setState(() {
      collectionNameValidationText = '';
      collectionSymbolValidationText = '';
    });
    if (collectionNameController!.text.isEmpty) {
      isValid = false;
      setState(() {
        collectionNameValidationText = localizations.tokenNameMissing;
      });
    }
    if (collectionSymbolController!.text.isEmpty) {
      isValid = false;
      setState(() {
        collectionSymbolValidationText = localizations.tokenSymbolMissing;
      });
    }

    // Estimation of fees
    feeEstimation = await getFee(context);
    return isValid;
  }

  Future<double> getFee(BuildContext context) async {
    var fee = 0.0;
    if (collectionSymbolController!.text.isEmpty ||
        collectionNameController!.text.isEmpty) {
      return fee;
    }
    try {
      final seed = await StateContainer.of(context).getSeed();
      final originPrivateKey = sl.get<ApiService>().getOriginKey();
      fee = await sl.get<AppService>().getFeesEstimationCreateToken(
            originPrivateKey,
            seed!,
            token!,
            StateContainer.of(context)
                .appWallet!
                .appKeychain!
                .getAccountSelected()!
                .name!,
          );
    } catch (e) {
      fee = 0;
    }
    return fee;
  }
}

class _AddNFTCollectionInfos extends StatelessWidget {
  const _AddNFTCollectionInfos({required this.bottom, super.key});

  final double bottom;

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalization.of(context)!;
    final theme = StateContainer.of(context).curTheme;

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(bottom: bottom + 80),
            child: Column(
              children: <Widget>[
                AppTextField(
                  focusNode: collectionNameFocusNode,
                  controller: collectionNameController,
                  cursorColor: theme.text,
                  textInputAction: TextInputAction.next,
                  labelText: localizations.tokenNameHint,
                  autocorrect: false,
                  keyboardType: TextInputType.text,
                  style: AppStyles.textStyleSize16W600Primary(context),
                  inputFormatters: <LengthLimitingTextInputFormatter>[
                    LengthLimitingTextInputFormatter(40),
                  ],
                  onChanged: (String text) async {
                    final fee = await getFee(context);
                    // Always reset the error message to be less annoying
                    setState(() {
                      feeEstimation = fee;
                      token!.name = text;
                    });
                  },
                ),
                Container(
                  margin: const EdgeInsets.only(top: 5, bottom: 5),
                  child: Text(
                    collectionNameValidationText!,
                    style: AppStyles.textStyleSize14W600Primary(context),
                  ),
                ),
                AppTextField(
                  focusNode: collectionSymbolFocusNode,
                  controller: collectionSymbolController,
                  cursorColor: theme.text,
                  textInputAction: TextInputAction.next,
                  labelText: localizations.tokenSymbolHint,
                  autocorrect: false,
                  keyboardType: TextInputType.text,
                  style: AppStyles.textStyleSize16W600Primary(context),
                  inputFormatters: [
                    UpperCaseTextFormatter(),
                    LengthLimitingTextInputFormatter(4),
                  ],
                  onChanged: (String text) async {
                    final fee = await getFee(context);
                    // Always reset the error message to be less annoying
                    setState(() {
                      feeEstimation = fee;
                      token!.symbol = text;
                    });
                  },
                ),
                Container(
                  margin: const EdgeInsets.only(top: 5, bottom: 5),
                  child: Text(
                    collectionSymbolValidationText!,
                    style: AppStyles.textStyleSize14W600Primary(context),
                  ),
                ),
                Row(
                  children: <Widget>[
                    if (collectionNameController!.text.isNotEmpty &&
                        collectionSymbolController!.text.isNotEmpty)
                      AppButton.buildAppButtonTiny(
                        const Key('addNFT'),
                        context,
                        AppButtonType.primary,
                        localizations.addNFTFile,
                        Dimens.buttonBottomDimens,
                        onPressed: () {
                          /* Sheets.showAppHeightNineSheet(
                                context: context,
                                widget: const AddNFTFile(
                                    process: AddNFTFileProcess.collection));*/
                        },
                      )
                    else
                      AppButton.buildAppButtonTiny(
                        const Key('addNFT'),
                        context,
                        AppButtonType.primaryOutline,
                        localizations.addNFTFile,
                        Dimens.buttonBottomDimens,
                        onPressed: () {},
                      )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AddNFTCollectionNFTListPreview extends StatelessWidget {
  const _AddNFTCollectionNFTListPreview({required this.token, super.key});

  final Token token;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        // Settings items
        ListView.separated(
          itemCount: token.tokenProperties!.length,
          physics: const NeverScrollableScrollPhysics(),
          separatorBuilder: (BuildContext context, int index) {
            return const SizedBox(height: 10);
          },
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return const SizedBox();

            // Map<String, dynamic>? properties = token!.tokenProperties!;
            // Image? image;
            // String name = '';
            // String typeMime = '';
            // String description = '';
            // Uint8List? imageDecoded;
            // properties.forEach((key, value) {
            //   switch (key) {
            //     case 'file':
            //       // final directory = await getApplicationDocumentsDirectory();
            //       // file = File(base64Decode(tokenProperty.value));
            //       imageDecoded = base64Decode(value);
            //       break;
            //     case 'type/mime':
            //       typeMime = value;
            //       break;
            //     case 'name':
            //       name = value;
            //       break;
            //     case 'description':
            //       description = value;
            //       break;
            //     default:
            //       break;
            //   }
            // });

            // return NFTCard(
            //   onTap: () {},
            //   heroTag: name,
            //   image: imageDecoded!,
            //   description: description,
            //   name: name,
            // );
          },
        ),
      ],
    );
  }
}
*/
  