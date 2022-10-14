/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';
import 'dart:io';

import 'package:aewallet/application/account.dart';
import 'package:aewallet/application/nft_category.dart';
import 'package:aewallet/application/theme.dart';
import 'package:aewallet/appstate_container.dart';
import 'package:aewallet/bus/authenticated_event.dart';
import 'package:aewallet/bus/transaction_send_event.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/model/primary_currency.dart';
import 'package:aewallet/model/token_property_with_access_infos.dart';
import 'package:aewallet/service/app_service.dart';
import 'package:aewallet/ui/util/dimens.dart';
import 'package:aewallet/ui/util/routes.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/util/ui_util.dart';
import 'package:aewallet/ui/views/authenticate/auth_factory.dart';
import 'package:aewallet/ui/views/nft_creation/bloc/provider.dart';
import 'package:aewallet/ui/views/nft_creation/bloc/transaction_builder.dart';
import 'package:aewallet/ui/views/nft_creation/layouts/components/category_template_form.dart';
import 'package:aewallet/ui/views/nft_creation/layouts/components/nft_creation_process_file_access.dart';
import 'package:aewallet/ui/views/nft_creation/layouts/components/nft_creation_process_file_preview.dart';
import 'package:aewallet/ui/views/nft_creation/layouts/components/nft_creation_process_import_tab_camera.dart';
import 'package:aewallet/ui/views/nft_creation/layouts/components/nft_creation_process_import_tab_file.dart';
import 'package:aewallet/ui/views/nft_creation/layouts/components/nft_creation_process_import_tab_image.dart';
import 'package:aewallet/ui/views/nft_creation/layouts/components/nft_creation_process_property_access.dart';
import 'package:aewallet/ui/widgets/balance/balance_indicator.dart';
import 'package:aewallet/ui/widgets/components/app_text_field.dart';
import 'package:aewallet/ui/widgets/components/buttons.dart';
import 'package:aewallet/ui/widgets/components/dialog.dart';
import 'package:aewallet/util/confirmations/transaction_sender.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/haptic_util.dart';
import 'package:aewallet/util/mime_util.dart';
import 'package:aewallet/util/preferences.dart';
import 'package:aewallet/util/user_data_util.dart';
// Package imports:
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:event_taxi/event_taxi.dart';
// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

part 'nft_creation_process_confirmation_tab.dart';
part 'nft_creation_process_import_tab.dart';
part 'nft_creation_process_infos_tab.dart';
part 'nft_creation_process_properties_tab.dart';

enum NFTCreationProcessTypeEnum { single, collection }

class NFTCreationProcess extends ConsumerStatefulWidget {
  const NFTCreationProcess({
    super.key,
    this.currentNftCategoryIndex,
    this.process,
    this.primaryCurrency,
  });
  final int? currentNftCategoryIndex;
  final NFTCreationProcessTypeEnum? process;
  final PrimaryCurrencySetting? primaryCurrency;

  @override
  ConsumerState<NFTCreationProcess> createState() => _NFTCreationProcessState();
}

class _NFTCreationProcessState extends ConsumerState<NFTCreationProcess>
    with TickerProviderStateMixin {
  PageController? pageController;
  int currentPage = 0;

  List<TokenPropertyWithAccessInfos> tokenPropertyWithAccessInfosList =
      List<TokenPropertyWithAccessInfos>.empty(growable: true);
  TokenPropertyWithAccessInfos? tokenPropertyAsset =
      TokenPropertyWithAccessInfos(tokenProperty: <String, String>{'file': ''});

  Token token = Token();
  int tabActiveIndex = 0;
  bool? isPressed;

  StreamSubscription<AuthenticatedEvent>? _authSub;
  StreamSubscription<TransactionSendEvent>? _sendTxSub;

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
    final theme = ref.watch(ThemeProviders.selectedTheme);
    Navigator.of(context).push(
      AnimationLoadingOverlay(
        AnimationType.send,
        theme.animationOverlayStrong!,
        theme.animationOverlayMedium!,
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
      final theme = ref.watch(ThemeProviders.selectedTheme);
      if (event.response != 'ok' && event.nbConfirmations == 0) {
        // Send failed

        Navigator.of(context).pop();

        UIUtil.showSnackbar(
          event.response!,
          context,
          ref,
          theme.text!,
          theme.snackBarShadow!,
          duration: const Duration(seconds: 5),
        );
        Navigator.of(context).pop();
      } else {
        if (event.response == 'ok' &&
            TransactionConfirmation.isEnoughConfirmations(
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
            ref,
            theme.text!,
            theme.snackBarShadow!,
            duration: const Duration(milliseconds: 5000),
          );

          await StateContainer.of(context)
              .appWallet!
              .appKeychain!
              .getAccountSelected()!
              .updateNftInfosOffChain(
                tokenAddress: event.params!['transactionAddress']! as String,
                categoryNftIndex: widget.currentNftCategoryIndex,
              );

          StateContainer.of(context).requestUpdate();

          Navigator.of(context)
              .popUntil(RouteUtils.withNameLike('/nft_list_per_category'));
        } else {
          UIUtil.showSnackbar(
            AppLocalization.of(context)!.notEnoughConfirmations,
            context,
            ref,
            theme.text!,
            theme.snackBarShadow!,
          );
          Navigator.of(context).pop();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final accountSelected =
        ref.read(AccountProviders.getSelectedAccount(context: context));
    final listNftCategory = ref.watch(
      NftCategoryProviders.fetchNftCategory(
        context: context,
        account: accountSelected!,
      ),
    );
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: DecoratedBox(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              theme.background4Small!,
            ),
            fit: BoxFit.fitHeight,
          ),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: <Color>[theme.backgroundDark!, theme.background!],
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
                            color: theme.text,
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
                            color: theme.backgroundDark,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: const BorderSide(
                                color: Colors.white10,
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                listNftCategory[widget.currentNftCategoryIndex!]
                                    .image,
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
                  color: theme.text15,
                ),
                Expanded(
                  child: Container(
                    constraints: const BoxConstraints.expand(height: 100),
                    child: ContainedTabBarView(
                      tabBarViewProperties: const TabBarViewProperties(
                        physics: NeverScrollableScrollPhysics(),
                      ),
                      tabBarProperties: TabBarProperties(
                        labelColor: theme.text,
                        labelStyle: theme.textStyleSize10W100Primary,
                        indicatorSize: TabBarIndicatorSize.label,
                        indicatorColor: theme.text,
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
                      views: [
                        NFTCreationProcessImportTab(
                          tabActiveIndex: tabActiveIndex,
                          currentNftCategoryIndex:
                              widget.currentNftCategoryIndex!,
                        ),
                        const NFTCreationProcessInfosTab(),
                        NFTCreationProcessPropertiesTab(
                          widget.currentNftCategoryIndex!,
                        ),
                        NFTCreationProcessConfirmationTab(
                          tabActiveIndex: tabActiveIndex,
                        ),
                      ],
                      onChange: (index) {
                        tabActiveIndex = index;
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

  Future<void> _doAdd() async {
    final nftCreation = ref.watch(NftCreationProvider.nftCreation);

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
              uint8ListToHex(
                keychain.deriveAddress(service),
              ),
            ))
        .chainLength!;

    final tokenProperties = <String, dynamic>{};
    for (final element in nftCreation.properties) {
      tokenProperties[element.propertyName] = element.propertyValue;
    }

    final transaction = TokenTransaction.build(
      keychain: keychain,
      index: index,
      originPrivateKey: originPrivateKey,
      serviceName: service,
      tokenName: nftCreation.name,
      tokenInitialSupply: 1,
      tokenSymbol: '',
      tokenProperties: tokenProperties,
    );

    final preferences = await Preferences.getInstance();

    final TransactionSenderInterface transactionSender =
        ArchethicTransactionSender(
      phoenixHttpEndpoint: await preferences.getNetwork().getPhoenixHttpLink(),
      websocketEndpoint: await preferences.getNetwork().getWebsocketUri(),
    );

    await transactionSender.send(
      transaction: transaction,
      onConfirmation: (confirmation) async {
        EventTaxiImpl.singleton().fire(
          TransactionSendEvent(
            transactionType: TransactionSendEventType.token,
            response: 'ok',
            nbConfirmations: confirmation.nbConfirmations,
            maxConfirmations: confirmation.maxConfirmations,
            params: <String, Object>{
              'transactionAddress': transaction.address!,
            },
          ),
        );
      },
      onError: (error) async {
        error.maybeMap(
          connectivity: (_) {
            EventTaxiImpl.singleton().fire(
              TransactionSendEvent(
                transactionType: TransactionSendEventType.token,
                response: AppLocalization.of(context)!.noConnection,
                nbConfirmations: 0,
              ),
            );
          },
          other: (_) {
            EventTaxiImpl.singleton().fire(
              TransactionSendEvent(
                transactionType: TransactionSendEventType.token,
                response: AppLocalization.of(context)!.keychainNotExistWarning,
                nbConfirmations: 0,
              ),
            );
          },
          invalidConfirmation: (_) {
            EventTaxiImpl.singleton().fire(
              TransactionSendEvent(
                transactionType: TransactionSendEventType.token,
                nbConfirmations: 0,
                maxConfirmations: 0,
                response: 'ko',
              ),
            );
          },
          orElse: () {
            EventTaxiImpl.singleton().fire(
              TransactionSendEvent(
                transactionType: TransactionSendEventType.token,
                response: '',
                nbConfirmations: 0,
              ),
            );
          },
        );
      },
    );
  }
}
