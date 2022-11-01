/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';

import 'package:aewallet/application/account.dart';
import 'package:aewallet/application/device_abilities.dart';
import 'package:aewallet/application/nft_category.dart';
import 'package:aewallet/application/settings.dart';
import 'package:aewallet/application/theme.dart';
import 'package:aewallet/appstate_container.dart';
import 'package:aewallet/bus/authenticated_event.dart';
import 'package:aewallet/bus/transaction_send_event.dart';
import 'package:aewallet/domain/models/transaction_event.dart';
import 'package:aewallet/infrastructure/repositories/transaction_token_builder.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/model/token_property_with_access_infos.dart';
// ignore: unused_import
import 'package:aewallet/service/app_service.dart';
import 'package:aewallet/ui/themes/themes.dart';
import 'package:aewallet/ui/util/dimens.dart';
import 'package:aewallet/ui/util/routes.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/util/ui_util.dart';
import 'package:aewallet/ui/views/authenticate/auth_factory.dart';
import 'package:aewallet/ui/views/nft_creation/bloc/provider.dart';
import 'package:aewallet/ui/views/nft_creation/bloc/state.dart';
import 'package:aewallet/ui/views/nft_creation/layouts/components/category_template_form.dart';
import 'package:aewallet/ui/views/nft_creation/layouts/components/nft_creation_process_file_access.dart';
import 'package:aewallet/ui/views/nft_creation/layouts/components/nft_creation_process_file_preview.dart';
import 'package:aewallet/ui/views/nft_creation/layouts/components/nft_creation_process_import_tab_camera.dart';
import 'package:aewallet/ui/views/nft_creation/layouts/components/nft_creation_process_import_tab_file.dart';
import 'package:aewallet/ui/views/nft_creation/layouts/components/nft_creation_process_import_tab_image.dart';
import 'package:aewallet/ui/views/nft_creation/layouts/components/nft_creation_process_property_access.dart';
import 'package:aewallet/ui/widgets/balance/balance_indicator.dart';
import 'package:aewallet/ui/widgets/components/app_button.dart';
import 'package:aewallet/ui/widgets/components/app_button_tiny.dart';
import 'package:aewallet/ui/widgets/components/app_text_field.dart';
import 'package:aewallet/ui/widgets/components/dialog.dart';
import 'package:aewallet/ui/widgets/components/icons.dart';
import 'package:aewallet/ui/widgets/components/show_sending_animation.dart';
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
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

part 'nft_creation_process_confirmation_tab.dart';
part 'nft_creation_process_import_tab.dart';
part 'nft_creation_process_infos_tab.dart';
part 'nft_creation_process_properties_tab.dart';

class NFTCreationProcess extends ConsumerWidget {
  const NFTCreationProcess({
    required this.currentNftCategoryIndex,
    super.key,
  });

  final int currentNftCategoryIndex;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // The main column that holds everything
    return ProviderScope(
      overrides: [
        NftCreationFormProvider.initialNftCreationForm.overrideWithValue(
          const NftCreationFormState(),
        ),
      ],
      child: NFTCreationProcessBody(
        currentNftCategoryIndex: currentNftCategoryIndex,
      ),
    );
  }
}

class NFTCreationProcessBody extends ConsumerStatefulWidget {
  const NFTCreationProcessBody({
    super.key,
    required this.currentNftCategoryIndex,
  });
  final int currentNftCategoryIndex;

  @override
  ConsumerState<NFTCreationProcessBody> createState() =>
      _NFTCreationProcessBodyState();
}

class _NFTCreationProcessBodyState extends ConsumerState<NFTCreationProcessBody>
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

  Future<void> _showSendSucceed(
    TransactionSendEvent event,
    BaseTheme theme,
  ) async {
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
        .appKeychain
        .getAccountSelected()!
        .updateNftInfosOffChain(
          tokenAddress: event.transactionAddress,
          categoryNftIndex: widget.currentNftCategoryIndex,
        );

    StateContainer.of(context).requestUpdate();

    Navigator.of(context).popUntil(
      RouteUtils.withNameLike('/nft_list_per_category'),
    );
  }

  void _showSendFailed(
    TransactionSendEvent event,
    BaseTheme theme,
  ) {
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
  }

  void _showNotEnoughConfirmation(BaseTheme theme) {
    UIUtil.showSnackbar(
      AppLocalization.of(context)!.notEnoughConfirmations,
      context,
      ref,
      theme.text!,
      theme.snackBarShadow!,
    );
    Navigator.of(context).pop();
  }

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

  void _registerBus() {
    _authSub = EventTaxiImpl.singleton()
        .registerTo<AuthenticatedEvent>()
        .listen((AuthenticatedEvent event) async {
      final theme = ref.watch(ThemeProviders.selectedTheme);
      ShowSendingAnimation.build(
        context,
        theme,
      );
      final nftCreationNotifier =
          ref.watch(NftCreationFormProvider.nftCreationForm.notifier);
      final seed = await StateContainer.of(context).getSeed();
      final accountSelected = StateContainer.of(context)
          .appWallet!
          .appKeychain
          .getAccountSelected()!;
      await nftCreationNotifier.buildTransaction(seed!, accountSelected.name!);
      await nftCreationNotifier.send(context);
    });

    _sendTxSub = EventTaxiImpl.singleton()
        .registerTo<TransactionSendEvent>()
        .listen((TransactionSendEvent event) async {
      final theme = ref.watch(ThemeProviders.selectedTheme);
      if (event.response != 'ok' && event.nbConfirmations == 0) {
        // Send failed
        _showSendFailed(event, theme);
        return;
      }

      if (event.response == 'ok' &&
          TransactionConfirmation.isEnoughConfirmations(
            event.nbConfirmations!,
            event.maxConfirmations!,
          )) {
        await _showSendSucceed(event, theme);
        return;
      }

      _showNotEnoughConfirmation(theme);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final localizations = AppLocalization.of(context)!;
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
                    const BalanceIndicatorWidget(
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
                                listNftCategory[widget.currentNftCategoryIndex]
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
                          icon: const Icon(UiIcons.nft_creation_process_import),
                        ),
                        Tab(
                          text: localizations
                              .nftCreationProcessTabDescriptionHeader,
                          icon: const Icon(
                            UiIcons.nft_creation_process_description,
                          ),
                        ),
                        Tab(
                          text: localizations
                              .nftCreationProcessTabPropertiesHeader,
                          icon: const Icon(
                            UiIcons.nft_creation_process_properties,
                          ),
                        ),
                        Tab(
                          text: localizations
                              .nftCreationProcessTabConfirmationHeader,
                          icon: const Icon(
                            UiIcons.nft_creation_process_confirmation,
                          ),
                        ),
                      ],
                      views: [
                        // TODO(reddwarf03): remove params with providers
                        NFTCreationProcessImportTab(
                          tabActiveIndex: tabActiveIndex,
                          currentNftCategoryIndex:
                              widget.currentNftCategoryIndex,
                        ),
                        const NFTCreationProcessInfosTab(),
                        NFTCreationProcessPropertiesTab(
                          currentNftCategoryIndex:
                              widget.currentNftCategoryIndex,
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
    } catch (e) {
      fee = 0;
    }
    return fee;
  }

  Future<void> _doAdd() async {
    final nftCreation = ref.watch(NftCreationFormProvider.nftCreationForm);
    final theme = ref.watch(ThemeProviders.selectedTheme);
    ShowSendingAnimation.build(
      context,
      theme,
    );
    final seed = await StateContainer.of(context).getSeed();
    final originPrivateKey = sl.get<ApiService>().getOriginKey();
    final keychain = await sl.get<ApiService>().getKeychain(seed!);
    final nameEncoded = Uri.encodeFull(
      StateContainer.of(context)
          .appWallet!
          .appKeychain
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

    // TODO(reddwarf03): to fix
    final transaction = AddTokenTransactionBuilder.build(
      keychain: keychain,
      index: index,
      originPrivateKey: originPrivateKey,
      serviceName: service,
      tokenName: nftCreation.name,
      tokenInitialSupply: 1,
      tokenSymbol: '',
      //tokenProperties: tokenProperties,
    );

    final preferences = await Preferences.getInstance();

    final TransactionSenderInterface transactionSender =
        ArchethicTransactionSender(
      phoenixHttpEndpoint: preferences.getNetwork().getPhoenixHttpLink(),
      websocketEndpoint: preferences.getNetwork().getWebsocketUri(),
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
