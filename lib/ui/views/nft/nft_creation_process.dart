/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';
import 'dart:io';

import 'package:aewallet/bus/authenticated_event.dart';
import 'package:aewallet/bus/transaction_send_event.dart';
import 'package:aewallet/model/primary_currency.dart';
import 'package:aewallet/model/token_property_with_access_infos.dart';
import 'package:aewallet/util/confirmations/subscription_channel.dart';
// Package imports:
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

part 'nft_creation_process_confirmation_tab.dart';
part 'nft_creation_process_import_tab.dart';
part 'nft_creation_process_infos_tab.dart';
part 'nft_creation_process_properties_tab.dart';

enum NFTCreationProcessType { single, collection }

class NFTCreationProcess extends StatefulWidget {
  const NFTCreationProcess({
    super.key,
    this.currentNftCategoryIndex,
    this.process,
    this.primaryCurrency,
  });
  final int? currentNftCategoryIndex;
  final NFTCreationProcessType? process;
  final PrimaryCurrencySetting? primaryCurrency;

  @override
  State<NFTCreationProcess> createState() => _NFTCreationProcessState();
}

class _NFTCreationProcessState extends State<NFTCreationProcess>
    with TickerProviderStateMixin {
  PageController? pageController;
  int currentPage = 0;

  //
  File? file;
  Uint8List? fileDecodedForPreview;
  Uint8List? fileDecoded;
  String typeMime = '';
  String file64 = '';
  int sizeFile = 0;
  FocusNode? nftNameFocusNode;
  FocusNode? nftDescriptionFocusNode;
  FocusNode? nftPropertyNameFocusNode;
  FocusNode? nftPropertyValueFocusNode;
  TextEditingController? nftNameController;
  TextEditingController? nftDescriptionController;
  TextEditingController? nftPropertySearchController;
  TextEditingController? nftPropertyNameController;
  TextEditingController? nftPropertyValueController;
  String addNFTMessage = '';
  String addNFTPropertyMessage = '';
  List<TokenPropertyWithAccessInfos> tokenPropertyWithAccessInfosList =
      List<TokenPropertyWithAccessInfos>.empty(growable: true);
  TokenPropertyWithAccessInfos? tokenPropertyAsset =
      TokenPropertyWithAccessInfos(tokenProperty: <String, String>{'file': ''});

  Token token = Token();
  int tabActiveIndex = 0;
  double feeEstimation = 0;
  bool? isPressed;

  SubscriptionChannel subscriptionChannel = SubscriptionChannel();

  StreamSubscription<AuthenticatedEvent>? _authSub;
  StreamSubscription<TransactionSendEvent>? _sendTxSub;

  FocusNode nftPropertyNameStoreFocusNode = FocusNode();
  TextEditingController nftPropertyNameStoreController =
      TextEditingController();
  FocusNode nftPropertyIdCardFocusNode = FocusNode();
  TextEditingController nftPropertyIdCardController = TextEditingController();
  FocusNode nftPropertyExpiryDateFocusNode = FocusNode();
  TextEditingController nftPropertyxpiryDateController =
      TextEditingController();

  FocusNode nftPropertyAuthorFocusNode = FocusNode();
  TextEditingController nftPropertyAuthorController = TextEditingController();
  FocusNode nftPropertyCompositorFocusNode = FocusNode();
  TextEditingController nftPropertyCompositorController =
      TextEditingController();
/*
  @override
  void initState() {
    _registerBus();
    pageController = PageController()
      ..addListener(() {
        final newPage = pageController!.page!.round();
        if (currentPage != newPage) {
          setState(() => currentPage = newPage);
        }
      });
    nftNameFocusNode = FocusNode();
    nftDescriptionFocusNode = FocusNode();
    nftPropertyNameFocusNode = FocusNode();
    nftPropertyValueFocusNode = FocusNode();
    nftNameController = TextEditingController();
    nftDescriptionController = TextEditingController();
    nftPropertyNameController = TextEditingController();
    nftPropertyValueController = TextEditingController();
    nftPropertySearchController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    pageController!.dispose();
    _destroyBus();
    super.dispose();
  }

  void _destroyBus() {
    _authSub?.cancel();
    _sendTxSub?.cancel();
  }

  void _showSendingAnimation(BuildContext context) {
    Navigator.of(context).push(
      AnimationLoadingOverlay(
        AnimationType.send,
        StateContainer.of(context).curTheme.animationOverlayStrong!,
        StateContainer.of(context).curTheme.animationOverlayMedium!,
      ),
    );
  }

  void _registerBus() {
    _authSub = EventTaxiImpl.singleton()
        .registerTo<AuthenticatedEvent>()
        .listen((AuthenticatedEvent event) {
       _doAdd();
    });

    _sendTxSub = EventTaxiImpl.singleton()
        .registerTo<TransactionSendEvent>()
        .listen((TransactionSendEvent event) async {
      if (event.response != 'ok' && event.nbConfirmations == 0) {
        // Send failed

        Navigator.of(context).pop();

        UIUtil.showSnackbar(
          event.response!,
          context,
          StateContainer.of(context).curTheme.text!,
          StateContainer.of(context).curTheme.snackBarShadow!,
          duration: const Duration(seconds: 5),
        );
        Navigator.of(context).pop();
      } else {
        if (event.response == 'ok' &&
            ConfirmationsUtil.isEnoughConfirmations(
              event.nbConfirmations!,
              event.maxConfirmations!,
            )) {
          UIUtil.showSnackbar(
            event.nbConfirmations == 1
                ? AppLocalization.of(context)!
                    .nftCreationTransactionConfirmed1
                    .replaceAll('%1', event.nbConfirmations.toString())
                    .replaceAll('%2', event.maxConfirmations.toString())
                : AppLocalization.of(context)!
                    .nftCreationTransactionConfirmed
                    .replaceAll('%1', event.nbConfirmations.toString())
                    .replaceAll('%2', event.maxConfirmations.toString()),
            context,
            StateContainer.of(context).curTheme.text!,
            StateContainer.of(context).curTheme.snackBarShadow!,
            duration: const Duration(milliseconds: 5000),
          );

          await StateContainer.of(context)
              .appWallet!
              .appKeychain!
              .getAccountSelected()!
              .updateNftInfosOffChain(
                tokenAddress: event.transactionAddress,
                categoryNftIndex: widget.currentNftCategoryIndex,
              );

          StateContainer.of(context).requestUpdate();

          Navigator.of(context)
              .popUntil(RouteUtils.withNameLike('/nft_list_per_category'));
        } else {
          UIUtil.showSnackbar(
            AppLocalization.of(context)!.notEnoughConfirmations,
            context,
            StateContainer.of(context).curTheme.text!,
            StateContainer.of(context).curTheme.snackBarShadow!,
          );
          Navigator.of(context).pop();
        }
      }
    });
  }
*/
  @override
  Widget build(BuildContext context) {
    // TODO(reddwarf03): refacto code with Riverpod
    return const SizedBox();
  }
}
/*
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: DecoratedBox(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              StateContainer.of(context).curTheme.background4Small!,
            ),
            fit: BoxFit.fitHeight,
          ),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: <Color>[
              StateContainer.of(context).curTheme.backgroundDark!,
              StateContainer.of(context).curTheme.background!
            ],
          ),
        ),
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) =>
              SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsetsDirectional.only(
                            start: smallScreen(context) ? 15 : 20,
                          ),
                          height: 50,
                          width: 50,
                          child: BackButton(
                            key: const Key('back'),
                            color: StateContainer.of(context).curTheme.text,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      ],
                    ),
                    BalanceIndicatorWidget(
                      primaryCurrency: widget.primaryCurrency,
                      displaySwitchButton: false,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10, top: 10),
                      child: Column(
                        children: [
                          Card(
                            elevation: 5,
                            shadowColor: Colors.black,
                            color: StateContainer.of(context)
                                .curTheme
                                .backgroundDark,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: const BorderSide(
                                color: Colors.white10,
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                StateContainer.of(context)
                                    .appWallet!
                                    .appKeychain!
                                    .getAccountSelected()!
                                    .getListNftCategory(context)[
                                        widget.currentNftCategoryIndex!]
                                    .image!,
                                width: 40,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Divider(
                  height: 2,
                  color: StateContainer.of(context).curTheme.text15,
                ),
                Expanded(
                  child: Container(
                    constraints: const BoxConstraints.expand(height: 100),
                    child: ContainedTabBarView(
                      tabBarViewProperties: const TabBarViewProperties(
                        physics: NeverScrollableScrollPhysics(),
                      ),
                      tabBarProperties: TabBarProperties(
                        labelColor: StateContainer.of(context).curTheme.text,
                        labelStyle:
                            theme.textStyleSize10W100Primary,
                        indicatorSize: TabBarIndicatorSize.label,
                        indicatorColor:
                            StateContainer.of(context).curTheme.text,
                      ),
                      tabs: [
                        Tab(
                          text: AppLocalization.of(context)!
                              .nftCreationProcessTabImportHeader,
                          icon: const Icon(Icons.arrow_downward),
                        ),
                        Tab(
                          text: AppLocalization.of(context)!
                              .nftCreationProcessTabDescriptionHeader,
                          icon: const Icon(Icons.info_outline),
                        ),
                        Tab(
                          text: AppLocalization.of(context)!
                              .nftCreationProcessTabPropertiesHeader,
                          icon: const Icon(Icons.insert_comment_rounded),
                        ),
                        Tab(
                          text: AppLocalization.of(context)!
                              .nftCreationProcessTabConfirmationHeader,
                          icon: const Icon(
                            Icons.check_circle_outline_outlined,
                          ),
                        ),
                      ],
                      views: const [
                        _NFTCreationProcessImportTab(),
                        _NFTCreationProcessInfosTab(),
                        _NFTCreationProcessPropertiesTab(),
                        _NFTCreationProcessConfirmationTab()
                      ],
                      onChange: (index) {
                        updateToken();
                        tabActiveIndex = index;
                        if (tabActiveIndex == 3) {
                          feeEstimation = getFee(context);
                        }
                        setState(() {});
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTokenProperty(
    BuildContext context,
    TokenPropertyWithAccessInfos tokenPropertyWithAccessInfos, {
    bool readOnly = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: GestureDetector(
        onTap: () async {},
        onLongPress: () {},
        child: Card(
          shape: RoundedRectangleBorder(
            side: tokenPropertyWithAccessInfos.publicKeysList != null &&
                    tokenPropertyWithAccessInfos.publicKeysList!.isNotEmpty
                ? const BorderSide(color: Colors.redAccent, width: 2)
                : BorderSide(
                    color: StateContainer.of(context)
                        .curTheme
                        .backgroundAccountsListCardSelected!,
                  ),
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 0,
          color: StateContainer.of(context)
              .curTheme
              .backgroundAccountsListCardSelected,
          child: Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10, right: 5),
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
                                tokenPropertyWithAccessInfos
                                    .tokenProperty!.keys.first,
                                style: theme.textStyleSize12W600Primary,
                              ),
                            ),
                            Container(
                              width: 200,
                              padding: const EdgeInsets.only(left: 20),
                              child: AutoSizeText(
                                tokenPropertyWithAccessInfos
                                    .tokenProperty!.values.first,
                                style: theme.textStyleSize12W400Primary,
                              ),
                            ),
                            if (tokenPropertyWithAccessInfos.publicKeysList !=
                                    null &&
                                tokenPropertyWithAccessInfos
                                    .publicKeysList!.isNotEmpty)
                              tokenPropertyWithAccessInfos
                                          .publicKeysList!.length ==
                                      1
                                  ? Container(
                                      width: MediaQuery.of(context).size.width -
                                          180,
                                      padding: const EdgeInsets.only(left: 20),
                                      child: AutoSizeText(
                                        'This property is protected and accessible by ${tokenPropertyWithAccessInfos.publicKeysList!.length} public key',
                                        style: AppStyles
                                            .textStyleSize12W400Primary(
                                          context,
                                        ),
                                      ),
                                    )
                                  : Container(
                                      width: MediaQuery.of(context).size.width -
                                          180,
                                      padding: const EdgeInsets.only(left: 20),
                                      child: AutoSizeText(
                                        'This property is protected and accessible by ${tokenPropertyWithAccessInfos.publicKeysList!.length} public keys',
                                        style: AppStyles
                                            .textStyleSize12W400Primary(
                                          context,
                                        ),
                                      ),
                                    )
                            else
                              Container(
                                width: MediaQuery.of(context).size.width - 180,
                                padding: const EdgeInsets.only(left: 20),
                                child: AutoSizeText(
                                  'This property is accessible by everyone',
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
                    Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: Container(
                        alignment: Alignment.center,
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: StateContainer.of(context)
                              .curTheme
                              .backgroundDark!
                              .withOpacity(0.3),
                          border: Border.all(
                            color: StateContainer.of(context)
                                .curTheme
                                .backgroundDarkest!
                                .withOpacity(0.2),
                            width: 2,
                          ),
                        ),
                        child: IconButton(
                          icon: Icon(
                            Icons.key,
                            color: StateContainer.of(context)
                                .curTheme
                                .backgroundDarkest,
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
                                widget: GetPublicKeys(
                                  tokenPropertyWithAccessInfos:
                                      tokenPropertyWithAccessInfos,
                                ),
                              );
                            } else {
                              Sheets.showAppHeightNineSheet(
                                context: context,
                                widget: AddPublicKey(
                                  tokenPropertyWithAccessInfos:
                                      tokenPropertyWithAccessInfos,
                                  returnPublicKeys:
                                      (List<String> publicKeysList) {
                                    tokenPropertyWithAccessInfos
                                        .publicKeysList = publicKeysList;

                                    setState(() {});
                                  },
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
                            color: StateContainer.of(context)
                                .curTheme
                                .backgroundDark!
                                .withOpacity(0.3),
                            border: Border.all(
                              color: StateContainer.of(context)
                                  .curTheme
                                  .backgroundDarkest!
                                  .withOpacity(0.2),
                              width: 2,
                            ),
                          ),
                          child: IconButton(
                            icon: Icon(
                              Icons.close,
                              color: StateContainer.of(context)
                                  .curTheme
                                  .backgroundDarkest,
                              size: 21,
                            ),
                            onPressed: () {
                              sl.get<HapticUtil>().feedback(
                                    FeedbackType.light,
                                    StateContainer.of(context).activeVibrations,
                                  );
                              AppDialogs.showConfirmDialog(
                                  context,
                                  'Delete property',
                                  'Are you sure ?',
                                  AppLocalization.of(context)!.deleteOption,
                                  () {
                                sl.get<HapticUtil>().feedback(
                                      FeedbackType.light,
                                      StateContainer.of(context)
                                          .activeVibrations,
                                    );

                                tokenPropertyWithAccessInfosList.removeWhere(
                                  (element) =>
                                      element.tokenProperty!.keys.first ==
                                      tokenPropertyWithAccessInfos
                                          .tokenProperty!.keys.first,
                                );
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
        ),
      ),
    );
  }

  bool validateAddNFTProperty() {
    var isValid = true;
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
        for (final tokenPropertyWithAccessInfos
            in tokenPropertyWithAccessInfosList) {
          if (tokenPropertyWithAccessInfos.tokenProperty!.keys.first ==
              nftPropertyNameController!.text) {
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

  void updateToken() {
    token = Token(
      name: nftNameController!.text,
      supply: 100000000,
      symbol: '',
      id: '1',
      type: 'non-fungible',
      tokenProperties: {},
    );

    for (final tokenPropertyWithAccessInfos
        in tokenPropertyWithAccessInfosList) {
      token.tokenProperties!
          .addAll(tokenPropertyWithAccessInfos.tokenProperty!);
    }
  }

  double getFee(BuildContext context) {
    var fee = 0.0;

    if (token.name!.isEmpty) {
      return fee;
    }
    try {
      final originPrivateKey = sl.get<ApiService>().getOriginKey();
      StateContainer.of(context).getSeed().then((String? seed) {
        sl
            .get<AppService>()
            .getFeesEstimationCreateToken(
              originPrivateKey,
              seed!,
              token,
              StateContainer.of(context)
                  .appWallet!
                  .appKeychain!
                  .getAccountSelected()!
                  .name!,
            )
            .then((value) {
          setState(() {
            fee = value;
          });
        });
      });
    } catch (e) {
      fee = 0;
    }
    return fee;
  }

  Future<bool> validateAddNFT(BuildContext context) async {
    var isValid = true;
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
            addNFTMessage = "Le format n'est pas pris en charge.";
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
            //feeEstimation = await getFee(context);
            if (feeEstimation >
                StateContainer.of(context)
                    .appWallet!
                    .appKeychain!
                    .getAccountSelected()!
                    .balance!
                    .nativeTokenValue!) {
              isValid = false;
              setState(() {
                addNFTMessage =
                    AppLocalization.of(context)!.insufficientBalance.replaceAll(
                          '%1',
                          StateContainer.of(context)
                              .curNetwork
                              .getNetworkCryptoCurrencyLabel(),
                        );
              });
            }
          }
        }
      }
    }

    return isValid;
  }

  Future<void> _doAdd() async {
    try {
      _showSendingAnimation(context);
      final seed = await StateContainer.of(context).getSeed();
      final originPrivateKey = sl.get<ApiService>().getOriginKey();
      final keychain = await sl.get<ApiService>().getKeychain(seed!);
      final nameEncoded = Uri.encodeFull(
        StateContainer.of(context)
            .appWallet!
            .appKeychain!
            .getAccountSelected()!
            .name!,
      );
      final service = 'archethic-wallet-$nameEncoded';
      final index = (await sl.get<ApiService>().getTransactionIndex(
                uint8ListToHex(keychain.deriveAddress(service)),
              ))
          .chainLength!;

      final transaction =
          Transaction(type: 'token', data: Transaction.initData());

      final aesKey = uint8ListToHex(
        Uint8List.fromList(
          List<int>.generate(32, (int i) => Random.secure().nextInt(256)),
        ),
      );

      final walletKeyPair = keychain.deriveKeypair(service);

      for (final tokenPropertyWithAccessInfos
          in tokenPropertyWithAccessInfosList) {
        if (tokenPropertyWithAccessInfos.publicKeysList != null &&
            tokenPropertyWithAccessInfos.publicKeysList!.isNotEmpty) {
          final authorizedPublicKeys = List<String>.empty(growable: true);
          authorizedPublicKeys.add(uint8ListToHex(walletKeyPair.publicKey));

          for (final publicKey
              in tokenPropertyWithAccessInfos.publicKeysList!) {
            authorizedPublicKeys.add(publicKey);
          }

          final authorizedKeys = List<AuthorizedKey>.empty(growable: true);
          for (final key in authorizedPublicKeys) {
            authorizedKeys.add(
              AuthorizedKey(
                encryptedSecretKey: uint8ListToHex(ecEncrypt(aesKey, key)),
                publicKey: key,
              ),
            );
          }

          transaction.addOwnership(
            aesEncrypt(
              tokenPropertyWithAccessInfos.tokenProperty!.toString(),
              aesKey,
            ),
            authorizedKeys,
          );
        }
      }

      final clearTokenPropertyList = <String, dynamic>{};
      for (final tokenPropertyWithAccessInfos
          in tokenPropertyWithAccessInfosList) {
        if (tokenPropertyWithAccessInfos.publicKeysList == null ||
            tokenPropertyWithAccessInfos.publicKeysList!.isEmpty) {
          clearTokenPropertyList
              .addAll(tokenPropertyWithAccessInfos.tokenProperty!);
        }
      }

      final content = tokenToJsonForTxDataContent(
        Token(
          name: token.name,
          supply: token.supply,
          type: token.type,
          symbol: token.symbol,
          tokenProperties: clearTokenPropertyList,
        ),
      );
      transaction.setContent(content);
      final signedTx = keychain
          .buildTransaction(transaction, service, index)
          .originSign(originPrivateKey);

      var transactionStatus = TransactionStatus();

      final preferences = await Preferences.getInstance();
      await subscriptionChannel.connect(
        await preferences.getNetwork().getPhoenixHttpLink(),
        await preferences.getNetwork().getWebsocketUri(),
      );

      void waitConfirmationsNFT(QueryResult event) {
        waitConfirmations(event, transactionAddress: signedTx.address);
      }

      subscriptionChannel.addSubscriptionTransactionConfirmed(
        transaction.address!,
        waitConfirmationsNFT,
      );

      await Future.delayed(const Duration(seconds: 1));

      transactionStatus = await sl.get<ApiService>().sendTx(signedTx);

      if (transactionStatus.status == 'invalid') {
        EventTaxiImpl.singleton().fire(
          TransactionSendEvent(
            transactionType: TransactionSendEventType.token,
            response: '',
            nbConfirmations: 0,
          ),
        );
        subscriptionChannel.close();
      }
    } on ArchethicConnectionException {
      EventTaxiImpl.singleton().fire(
        TransactionSendEvent(
          transactionType: TransactionSendEventType.token,
          response: AppLocalization.of(context)!.noConnection,
          nbConfirmations: 0,
        ),
      );
      subscriptionChannel.close();
    } on Exception {
      EventTaxiImpl.singleton().fire(
        TransactionSendEvent(
          transactionType: TransactionSendEventType.token,
          response: AppLocalization.of(context)!.keychainNotExistWarning,
          nbConfirmations: 0,
        ),
      );
      subscriptionChannel.close();
    }
  }

  void waitConfirmations(QueryResult event, {String? transactionAddress}) {
    var nbConfirmations = 0;
    var maxConfirmations = 0;
    if (event.data != null && event.data!['transactionConfirmed'] != null) {
      if (event.data!['transactionConfirmed']['nbConfirmations'] != null) {
        nbConfirmations =
            event.data!['transactionConfirmed']['nbConfirmations'];
      }
      if (event.data!['transactionConfirmed']['maxConfirmations'] != null) {
        maxConfirmations =
            event.data!['transactionConfirmed']['maxConfirmations'];
      }
      EventTaxiImpl.singleton().fire(
        TransactionSendEvent(
          transactionType: TransactionSendEventType.token,
          response: 'ok',
          transactionAddress: transactionAddress,
          nbConfirmations: nbConfirmations,
          maxConfirmations: maxConfirmations,
        ),
      );
    } else {
      EventTaxiImpl.singleton().fire(
        TransactionSendEvent(
          transactionType: TransactionSendEventType.token,
          nbConfirmations: 0,
          maxConfirmations: 0,
          response: 'ko',
        ),
      );
    }
    subscriptionChannel.close();
  }

  Widget getCategoryTemplateForm(
    BuildContext context,
    int currentNftCategoryIndex,
  ) {
    switch (currentNftCategoryIndex) {
      case 4:
        return Column(
          children: [
            Text(
              'Properties required by the category:',
              style: theme.textStyleSize12W100Primary,
              textAlign: TextAlign.justify,
            ),
            getNftPropertyAppTextField(
              nftPropertyAuthorFocusNode,
              nftPropertyAuthorController,
              'Compositor',
              'Compositor',
            ),
            getNftPropertyAppTextField(
              nftPropertyCompositorFocusNode,
              nftPropertyCompositorController,
              'Author',
              'Author',
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Divider(
                height: 2,
                color: StateContainer.of(context).curTheme.text15,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                'Optional properties:',
                style: theme.textStyleSize12W100Primary,
                textAlign: TextAlign.justify,
              ),
            ),
          ],
        );
      case 6:
        return Column(
          children: [
            Text(
              'Properties required by the category:',
              style: theme.textStyleSize12W100Primary,
              textAlign: TextAlign.justify,
            ),
            getNftPropertyAppTextField(
              nftPropertyNameStoreFocusNode,
              nftPropertyNameStoreController,
              'Name of the store',
              'Name of the store',
            ),
            getNftPropertyAppTextField(
              nftPropertyIdCardFocusNode,
              nftPropertyIdCardController,
              'Id Card',
              'Id Card',
            ),
            getNftPropertyAppTextField(
              nftPropertyExpiryDateFocusNode,
              nftPropertyxpiryDateController,
              'Expiry date',
              'Expiry Date',
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Divider(
                height: 2,
                color: StateContainer.of(context).curTheme.text15,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                'Optional properties:',
                style: theme.textStyleSize12W100Primary,
                textAlign: TextAlign.justify,
              ),
            ),
          ],
        );

      default:
        return const SizedBox();
    }
  }

  Widget getNftPropertyAppTextField(
    FocusNode focusNode,
    TextEditingController textEditingController,
    String hint,
    String propertyKey,
  ) {
    return AppTextField(
      focusNode: focusNode,
      controller: textEditingController,
      cursorColor: StateContainer.of(context).curTheme.text,
      textInputAction: TextInputAction.next,
      labelText: hint,
      autocorrect: false,
      keyboardType: TextInputType.text,
      style: theme.textStyleSize16W600Primary,
      inputFormatters: <LengthLimitingTextInputFormatter>[
        LengthLimitingTextInputFormatter(30),
      ],
      onChanged: (text) {
        if (text == '') {
          tokenPropertyWithAccessInfosList.removeWhere(
            (element) => element.tokenProperty!.keys.first == propertyKey,
          );
        } else {
          tokenPropertyWithAccessInfosList.removeWhere(
            (element) => element.tokenProperty!.keys.first == propertyKey,
          );
          tokenPropertyWithAccessInfosList.add(
            TokenPropertyWithAccessInfos(
              tokenProperty: {propertyKey: textEditingController.text},
            ),
          );
          tokenPropertyWithAccessInfosList.sort(
            (
              TokenPropertyWithAccessInfos a,
              TokenPropertyWithAccessInfos b,
            ) =>
                a.tokenProperty!.keys.first
                    .toLowerCase()
                    .compareTo(b.tokenProperty!.keys.first.toLowerCase()),
          );
        }

        setState(() {});
      },
      suffixButton: kIsWeb == false && (Platform.isIOS || Platform.isAndroid)
          ? TextFieldButton(
              icon: FontAwesomeIcons.qrcode,
              onPressed: () async {
                sl.get<HapticUtil>().feedback(
                      FeedbackType.light,
                      StateContainer.of(context).activeVibrations,
                    );
                UIUtil.cancelLockEvent();
                final scanResult =
                    await UserDataUtil.getQRData(DataType.raw, context);
                if (scanResult == null) {
                  UIUtil.showSnackbar(
                    AppLocalization.of(context)!.qrInvalidAddress,
                    context,
                    StateContainer.of(context).curTheme.text!,
                    StateContainer.of(context).curTheme.snackBarShadow!,
                  );
                } else if (QRScanErrs.errorList.contains(scanResult)) {
                  UIUtil.showSnackbar(
                    scanResult,
                    context,
                    StateContainer.of(context).curTheme.text!,
                    StateContainer.of(context).curTheme.snackBarShadow!,
                  );
                  return;
                } else {
                  setState(() {
                    textEditingController.text = scanResult;
                  });
                }
              },
            )
          : null,
    );
  }
}
*/
