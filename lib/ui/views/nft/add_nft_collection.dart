/// SPDX-License-Identifier: AGPL-3.0-or-later
// ignore_for_file: avoid_unnecessary_containers

// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:archethic_lib_dart/archethic_lib_dart.dart' show ApiService;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:page_view_indicators/page_view_indicators.dart';

// Project imports:
import 'package:aewallet/appstate_container.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/model/primary_currency.dart';
import 'package:aewallet/service/app_service.dart';
import 'package:aewallet/ui/util/dimens.dart';
import 'package:aewallet/ui/util/formatters.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/views/nft/add_nft_collection_confirm.dart';
import 'package:aewallet/ui/widgets/components/app_text_field.dart';
import 'package:aewallet/ui/widgets/components/buttons.dart';
import 'package:aewallet/ui/widgets/components/sheet_util.dart';
import 'package:aewallet/ui/widgets/components/tap_outside_unfocus.dart';
import 'package:aewallet/util/currency_util.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/haptic_util.dart';

class AddNFTCollection extends StatefulWidget {
  const AddNFTCollection({
    super.key,
    this.primaryCurrency,
  });

  final PrimaryCurrencySetting? primaryCurrency;

  @override
  State<AddNFTCollection> createState() => _AddNFTCollectionState();
}

enum PrimaryCurrency { network, selected }

class _AddNFTCollectionState extends State<AddNFTCollection> {
  FocusNode? collectionNameFocusNode;
  FocusNode? collectionSymbolFocusNode;
  FocusNode? collectionSupplyFocusNode;
  TextEditingController? collectionNameController;
  TextEditingController? collectionSymbolController;
  TextEditingController? collectionSupplyController;
  String? collectionNameValidationText;
  String? collectionSymbolValidationText;

  List<NftForm>? nftForms = List<NftForm>.empty(growable: true);

  bool? animationOpen;
  double feeEstimation = 0.0;
  bool? _isPressed;
  bool validRequest = true;
  PrimaryCurrency primaryCurrency = PrimaryCurrency.network;
  int? supply;

  @override
  void initState() {
    super.initState();
    if (widget.primaryCurrency!.primaryCurrency.name ==
        PrimaryCurrencySetting(AvailablePrimaryCurrency.native)
            .primaryCurrency
            .name) {
      primaryCurrency = PrimaryCurrency.network;
    } else {
      primaryCurrency = PrimaryCurrency.selected;
    }
    _isPressed = false;
    collectionNameFocusNode = FocusNode();
    collectionSymbolFocusNode = FocusNode();
    collectionSupplyFocusNode = FocusNode();
    collectionNameController = TextEditingController();
    collectionSymbolController = TextEditingController();
    supply = 1;
    collectionSupplyController = TextEditingController(text: supply.toString());

    collectionNameValidationText = '';
    collectionSymbolValidationText = '';

    nftForms!.add(NftForm(
        nftNameController: TextEditingController(),
        nftSymbolController: TextEditingController(),
        nftNameFocusNode: FocusNode(),
        nftSymbolFocusNode: FocusNode()));
  }

  @override
  Widget build(BuildContext context) {
    final double bottom = MediaQuery.of(context).viewInsets.bottom;
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
                          Column(
                            children: [
                              SvgPicture.asset(
                                '${StateContainer.of(context).curTheme.assetsFolder!}${StateContainer.of(context).curTheme.logoAlone!}.svg',
                                height: 30,
                              ),
                              Text(
                                  StateContainer.of(context)
                                      .curNetwork
                                      .getDisplayName(context),
                                  style: AppStyles.textStyleSize10W100Primary(
                                      context)),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          AutoSizeText(
                            AppLocalization.of(context)!.createNFTCollection,
                            style: AppStyles.textStyleSize24W700EquinoxPrimary(
                                context),
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            stepGranularity: 0.1,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          StateContainer.of(context).showBalance
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    primaryCurrency == PrimaryCurrency.selected
                                        ? Column(
                                            children: [
                                              _balanceSelected(context, true),
                                              _balanceNetwork(context, false),
                                            ],
                                          )
                                        : Column(
                                            children: [
                                              _balanceNetwork(context, true),
                                              _balanceSelected(context, false),
                                            ],
                                          ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.change_circle),
                                      alignment: Alignment.centerRight,
                                      color: StateContainer.of(context)
                                          .curTheme
                                          .textFieldIcon,
                                      onPressed: () {
                                        sl.get<HapticUtil>().feedback(
                                            FeedbackType.light,
                                            StateContainer.of(context)
                                                .activeVibrations);
                                        if (primaryCurrency ==
                                            PrimaryCurrency.network) {
                                          setState(() {
                                            primaryCurrency =
                                                PrimaryCurrency.selected;
                                          });
                                        } else {
                                          setState(() {
                                            primaryCurrency =
                                                PrimaryCurrency.network;
                                          });
                                        }
                                      },
                                    ),
                                  ],
                                )
                              : const SizedBox(),
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
            Center(
              child: ExpandablePageView(
                children: [
                  collectionInfos(context, bottom),
                  for (int i = 0; i < nftForms!.length; i++)
                    nftInfos(
                      context,
                      bottom,
                      nftForms![i],
                    ),
                ],
              ),
            ),
            feeEstimation > 0
                ? Padding(
                    padding: const EdgeInsets.only(left: 30, right: 30),
                    child: Text(
                      '${AppLocalization.of(context)!.estimatedFees}: $feeEstimation ${StateContainer.of(context).curNetwork.getNetworkCryptoCurrencyLabel()}',
                      style: AppStyles.textStyleSize14W100Primary(context),
                      textAlign: TextAlign.justify,
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.only(left: 30, right: 30),
                    child: Text(
                      AppLocalization.of(context)!.estimatedFeesAddTokenNote,
                      style: AppStyles.textStyleSize14W100Primary(context),
                      textAlign: TextAlign.justify,
                    ),
                  ),
            Container(
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      _isPressed == true
                          ? AppButton.buildAppButton(
                              const Key('createNFTCollection'),
                              context,
                              AppButtonType.primaryOutline,
                              AppLocalization.of(context)!.createNFTCollection,
                              Dimens.buttonTopDimens,
                              onPressed: () {},
                            )
                          : AppButton.buildAppButton(
                              const Key('createNFTCollection'),
                              context,
                              AppButtonType.primary,
                              AppLocalization.of(context)!.createNFTCollection,
                              Dimens.buttonTopDimens,
                              onPressed: () async {
                                setState(() {
                                  _isPressed = true;
                                });

                                validRequest = await _validateRequest();
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
                                      tokenName: collectionNameController!.text,
                                      tokenSymbol:
                                          collectionSymbolController!.text,
                                      feeEstimation: feeEstimation,
                                    ),
                                  );
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

  Widget collectionInfos(BuildContext context, double bottom) {
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
                  cursorColor: StateContainer.of(context).curTheme.text,
                  textInputAction: TextInputAction.next,
                  labelText: AppLocalization.of(context)!.tokenNameHint,
                  autocorrect: false,
                  keyboardType: TextInputType.text,
                  style: AppStyles.textStyleSize16W600Primary(context),
                  inputFormatters: <LengthLimitingTextInputFormatter>[
                    LengthLimitingTextInputFormatter(40),
                  ],
                  onChanged: (_) async {
                    double fee = await getFee();
                    // Always reset the error message to be less annoying
                    setState(() {
                      feeEstimation = fee;
                    });
                  },
                ),
                Container(
                  margin: const EdgeInsets.only(top: 5, bottom: 5),
                  child: Text(collectionNameValidationText!,
                      style: AppStyles.textStyleSize14W600Primary(context)),
                ),
                AppTextField(
                  focusNode: collectionSymbolFocusNode,
                  controller: collectionSymbolController,
                  cursorColor: StateContainer.of(context).curTheme.text,
                  textInputAction: TextInputAction.next,
                  labelText: AppLocalization.of(context)!.tokenSymbolHint,
                  autocorrect: false,
                  keyboardType: TextInputType.text,
                  style: AppStyles.textStyleSize16W600Primary(context),
                  inputFormatters: [
                    UpperCaseTextFormatter(),
                    LengthLimitingTextInputFormatter(4),
                  ],
                  onChanged: (_) async {
                    double fee = await getFee();
                    // Always reset the error message to be less annoying
                    setState(() {
                      feeEstimation = fee;
                    });
                  },
                ),
                Container(
                  margin: const EdgeInsets.only(top: 5, bottom: 5),
                  child: Text(collectionSymbolValidationText!,
                      style: AppStyles.textStyleSize14W600Primary(context)),
                ),
                AppTextField(
                  focusNode: collectionSupplyFocusNode,
                  controller: collectionSupplyController,
                  cursorColor: StateContainer.of(context).curTheme.text,
                  textInputAction: TextInputAction.next,
                  labelText:
                      AppLocalization.of(context)!.tokenInitialSupplyHint,
                  autocorrect: false,
                  keyboardType: TextInputType.text,
                  style: AppStyles.textStyleSize16W600Primary(context),
                  inputFormatters: [
                    UpperCaseTextFormatter(),
                    LengthLimitingTextInputFormatter(4),
                  ],
                  onChanged: (value) async {
                    double fee = await getFee();
                    if (int.tryParse(value) != null) {
                      int oldSupply = supply!;
                      supply = int.tryParse(value);
                      if (supply! > oldSupply) {
                        for (int i = 0; i < supply! - oldSupply; i++) {
                          nftForms!.add(NftForm(
                              nftNameController: TextEditingController(),
                              nftSymbolController: TextEditingController(),
                              nftNameFocusNode: FocusNode(),
                              nftSymbolFocusNode: FocusNode()));
                        }
                      }
                    }
                    // Always reset the error message to be less annoying
                    setState(() {
                      feeEstimation = fee;
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget nftInfos(BuildContext context, double bottom, NftForm nftForm) {
    String? nftNameValidationText = '';
    String? nftSymbolValidationText = '';

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(bottom: bottom + 80),
            child: Column(
              children: <Widget>[
                AppTextField(
                  focusNode: nftForm.nftNameFocusNode,
                  controller: nftForm.nftNameController,
                  cursorColor: StateContainer.of(context).curTheme.text,
                  textInputAction: TextInputAction.next,
                  labelText: AppLocalization.of(context)!.tokenNameHint,
                  autocorrect: false,
                  keyboardType: TextInputType.text,
                  style: AppStyles.textStyleSize16W600Primary(context),
                  inputFormatters: <LengthLimitingTextInputFormatter>[
                    LengthLimitingTextInputFormatter(40),
                  ],
                  onChanged: (_) async {
                    double fee = await getFee();
                    // Always reset the error message to be less annoying
                    setState(() {
                      feeEstimation = fee;
                    });
                  },
                ),
                Container(
                  margin: const EdgeInsets.only(top: 5, bottom: 5),
                  child: Text(nftNameValidationText,
                      style: AppStyles.textStyleSize14W600Primary(context)),
                ),
                AppTextField(
                  focusNode: nftForm.nftSymbolFocusNode,
                  controller: nftForm.nftSymbolController,
                  cursorColor: StateContainer.of(context).curTheme.text,
                  textInputAction: TextInputAction.next,
                  labelText: AppLocalization.of(context)!.tokenSymbolHint,
                  autocorrect: false,
                  keyboardType: TextInputType.text,
                  style: AppStyles.textStyleSize16W600Primary(context),
                  inputFormatters: [
                    UpperCaseTextFormatter(),
                    LengthLimitingTextInputFormatter(4),
                  ],
                  onChanged: (_) async {
                    double fee = await getFee();
                    // Always reset the error message to be less annoying
                    setState(() {
                      feeEstimation = fee;
                    });
                  },
                ),
                Container(
                  margin: const EdgeInsets.only(top: 5, bottom: 5),
                  child: Text(nftSymbolValidationText,
                      style: AppStyles.textStyleSize14W600Primary(context)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<bool> _validateRequest() async {
    bool isValid = true;
    setState(() {
      collectionNameValidationText = '';
      collectionSymbolValidationText = '';
    });
    if (collectionNameController!.text.isEmpty) {
      isValid = false;
      setState(() {
        collectionNameValidationText =
            AppLocalization.of(context)!.tokenNameMissing;
      });
    }
    if (collectionSymbolController!.text.isEmpty) {
      isValid = false;
      setState(() {
        collectionSymbolValidationText =
            AppLocalization.of(context)!.tokenSymbolMissing;
      });
    }

    // Estimation of fees
    feeEstimation = await getFee();
    return isValid;
  }

  Future<double> getFee() async {
    double fee = 0;
    if (collectionSymbolController!.text.isEmpty ||
        collectionNameController!.text.isEmpty) {
      return fee;
    }
    try {
      final String? seed = await StateContainer.of(context).getSeed();
      final String originPrivateKey = sl.get<ApiService>().getOriginKey();
      fee = await sl.get<AppService>().getFeesEstimationCreateToken(
          originPrivateKey,
          seed!,
          collectionNameController!.text,
          collectionSymbolController!.text,
          'non-fungible',
          0,
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

  Widget _balanceNetwork(BuildContext context, bool primary) {
    return Container(
      child: RichText(
        textAlign: TextAlign.start,
        text: TextSpan(
          text: '',
          children: <InlineSpan>[
            if (primary == false)
              TextSpan(
                text: '(',
                style: primary
                    ? AppStyles.textStyleSize16W100Primary(context)
                    : AppStyles.textStyleSize14W100Primary(context),
              ),
            TextSpan(
              text:
                  '${StateContainer.of(context).appWallet!.appKeychain!.getAccountSelected()!.balance!.nativeTokenValueToString()} ${StateContainer.of(context).appWallet!.appKeychain!.getAccountSelected()!.balance!.nativeTokenName!}',
              style: primary
                  ? AppStyles.textStyleSize16W700Primary(context)
                  : AppStyles.textStyleSize14W700Primary(context),
            ),
            if (primary == false)
              TextSpan(
                text: ')',
                style: primary
                    ? AppStyles.textStyleSize16W100Primary(context)
                    : AppStyles.textStyleSize14W100Primary(context),
              ),
          ],
        ),
      ),
    );
  }

  Widget _balanceSelected(BuildContext context, bool primary) {
    return Container(
      child: RichText(
        textAlign: TextAlign.start,
        text: TextSpan(
          text: '',
          children: <InlineSpan>[
            if (primary == false)
              TextSpan(
                text: '(',
                style: primary
                    ? AppStyles.textStyleSize16W100Primary(context)
                    : AppStyles.textStyleSize14W100Primary(context),
              ),
            TextSpan(
              text: CurrencyUtil.getConvertedAmount(
                  StateContainer.of(context).curCurrency.currency.name,
                  StateContainer.of(context)
                      .appWallet!
                      .appKeychain!
                      .getAccountSelected()!
                      .balance!
                      .fiatCurrencyValue!),
              style: primary
                  ? AppStyles.textStyleSize16W700Primary(context)
                  : AppStyles.textStyleSize14W700Primary(context),
            ),
            if (primary == false)
              TextSpan(
                text: ')',
                style: primary
                    ? AppStyles.textStyleSize16W100Primary(context)
                    : AppStyles.textStyleSize14W100Primary(context),
              ),
          ],
        ),
      ),
    );
  }
}

class ExpandablePageView extends StatefulWidget {
  final List<Widget>? children;

  const ExpandablePageView({
    super.key,
    @required this.children,
  });

  @override
  State<ExpandablePageView> createState() => _ExpandablePageViewState();
}

class _ExpandablePageViewState extends State<ExpandablePageView>
    with TickerProviderStateMixin {
  PageController? _pageController;
  List<double>? _heights;
  int _currentPage = 0;

  double get _currentHeight => _heights![_currentPage];

  final pageNotifier = ValueNotifier<int>(0);

  @override
  void initState() {
    _heights = widget.children!.map((e) => 0.0).toList();

    super.initState();
    _pageController = PageController() //
      ..addListener(() {
        final newPage = _pageController!.page!.round();
        if (_currentPage != newPage) {
          setState(() => _currentPage = newPage);
        }
      });
  }

  @override
  void dispose() {
    _pageController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TweenAnimationBuilder<double>(
            curve: Curves.easeInOutCubic,
            duration: const Duration(milliseconds: 100),
            tween: Tween<double>(begin: _heights![0], end: _currentHeight),
            builder: (context, value, child) =>
                SizedBox(height: value, child: child),
            child: PageView(
              physics: const AlwaysScrollableScrollPhysics(),
              scrollBehavior: ScrollConfiguration.of(context).copyWith(
                dragDevices: {
                  PointerDeviceKind.touch,
                  PointerDeviceKind.mouse,
                },
              ),
              onPageChanged: (int index) {
                pageNotifier.value = index;
              },
              scrollDirection: Axis.horizontal,
              controller: _pageController,
              children: _sizeReportingChildren
                  .asMap() //
                  .map((index, child) => MapEntry(index, child))
                  .values
                  .toList(),
            )),
        Center(
          child: CirclePageIndicator(
            currentPageNotifier: pageNotifier,
            itemCount: _heights!.length,
            dotColor: StateContainer.of(context).curTheme.background,
            selectedDotColor:
                StateContainer.of(context).curTheme.backgroundDarkest,
          ),
        ),
      ],
    );
  }

  List<Widget> get _sizeReportingChildren => widget.children!
      .asMap() //
      .map(
        (index, child) => MapEntry(
          index,
          OverflowBox(
            minHeight: 0,
            maxHeight: double.infinity,
            alignment: Alignment.topCenter,
            child: SizeReportingWidget(
              onSizeChange: (size) =>
                  setState(() => _heights![index] = size.height),
              child: Align(child: child),
            ),
          ),
        ),
      )
      .values
      .toList();
}

class SizeReportingWidget extends StatefulWidget {
  final Widget child;
  final ValueChanged<Size> onSizeChange;

  const SizeReportingWidget({
    key,
    required this.child,
    required this.onSizeChange,
  }) : super(key: key);

  @override
  State<SizeReportingWidget> createState() => _SizeReportingWidgetState();
}

class _SizeReportingWidgetState extends State<SizeReportingWidget> {
  final _widgetKey = GlobalKey();
  Size? _oldSize;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => _notifySize());
    return NotificationListener<SizeChangedLayoutNotification>(
      onNotification: (_) {
        WidgetsBinding.instance.addPostFrameCallback((_) => _notifySize());
        return true;
      },
      child: SizeChangedLayoutNotifier(
        child: Container(
          key: _widgetKey,
          child: widget.child,
        ),
      ),
    );
  }

  void _notifySize() {
    final context = _widgetKey.currentContext;
    if (context == null) return;
    final size = context.size;
    if (_oldSize != size) {
      _oldSize = size;
      widget.onSizeChange(size!);
    }
  }
}

class NftForm {
  FocusNode? nftNameFocusNode;
  FocusNode? nftSymbolFocusNode;
  TextEditingController? nftNameController;
  TextEditingController? nftSymbolController;

  NftForm(
      {required this.nftNameFocusNode,
      required this.nftSymbolFocusNode,
      required this.nftNameController,
      required this.nftSymbolController});
}
