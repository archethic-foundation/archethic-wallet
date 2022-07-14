/// SPDX-License-Identifier: AGPL-3.0-or-later
// ignore_for_file: avoid_unnecessary_containers

// Dart imports:
import 'dart:io';

// Flutter imports:
import 'package:aeuniverse/ui/widgets/dialogs/contacts_dialog.dart';
import 'package:core/model/data/contact.dart';
import 'package:core/model/primary_currency.dart';
import 'package:core/util/currency_util.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:aeuniverse/appstate_container.dart';
import 'package:aeuniverse/ui/util/styles.dart';
import 'package:aeuniverse/ui/util/ui_util.dart';
import 'package:aeuniverse/ui/widgets/components/app_text_field.dart';
import 'package:aeuniverse/ui/widgets/components/buttons.dart';
import 'package:aeuniverse/ui/widgets/components/icon_widget.dart';
import 'package:aeuniverse/ui/widgets/components/sheet_util.dart';
import 'package:aeuniverse/ui/widgets/components/tap_outside_unfocus.dart';
import 'package:aeuniverse/util/user_data_util.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:core/localization.dart';
import 'package:core/model/address.dart';
import 'package:core/model/available_currency.dart';
import 'package:core/model/data/appdb.dart';
import 'package:core/service/app_service.dart';
import 'package:core/util/get_it_instance.dart';
import 'package:core/util/haptic_util.dart';
import 'package:core/util/number_util.dart';
import 'package:core_ui/ui/util/dimens.dart';
import 'package:core_ui/ui/util/formatters.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

// Project imports:
import 'package:aewallet/model/uco_transfer_wallet.dart';
import 'package:aewallet/ui/views/uco/transfer_confirm_sheet.dart';

// Package imports:
import 'package:archethic_lib_dart/archethic_lib_dart.dart'
    show AddressService, isHex, ApiService;

class TransferUCOSheet extends StatefulWidget {
  const TransferUCOSheet(
      {@required this.localCurrency,
      this.contact,
      this.address,
      this.quickSendAmount,
      this.title,
      this.actionButtonTitle,
      this.primaryCurrency,
      super.key});

  final AvailableCurrency? localCurrency;
  final Contact? contact;
  final String? address;
  final String? quickSendAmount;
  final String? title;
  final String? actionButtonTitle;
  final PrimaryCurrencySetting? primaryCurrency;

  @override
  State<TransferUCOSheet> createState() => _TransferUCOSheetState();
}

enum AddressStyle { text60, text90, primary }

enum PrimaryCurrency { network, selected }

class _TransferUCOSheetState extends State<TransferUCOSheet> {
  FocusNode? _sendAddressFocusNode;
  TextEditingController? _sendAddressController;
  FocusNode? _sendAmountFocusNode;
  TextEditingController? _sendAmountController;
  FocusNode? _messageFocusNode;
  TextEditingController? _messageController;

  AddressStyle? _sendAddressStyle;
  String? _amountValidationText = '';
  String? _addressValidationText = '';
  String? _messageValidationText = '';
  String? _globalValidationText = '';
  String? quickSendAmount;
  bool _addressValidAndUnfocused = false;
  bool _isContact = false;
  bool _qrCodeButtonVisible = true;
  NumberFormat? _localCurrencyFormat;
  String? _rawAmount;
  bool validRequest = true;
  double feeEstimation = 0.0;
  bool? _isPressed;
  PrimaryCurrency primaryCurrency = PrimaryCurrency.network;
  double priceConverted = 0.0;

  List<UCOTransferWallet> ucoTransferList =
      List<UCOTransferWallet>.empty(growable: true);

  @override
  void initState() {
    super.initState();
    if (widget.primaryCurrency!.primaryCurrency.name ==
        PrimaryCurrencySetting(AvailablePrimaryCurrency.NATIVE)
            .primaryCurrency
            .name) {
      primaryCurrency = PrimaryCurrency.network;
    } else {
      primaryCurrency = PrimaryCurrency.selected;
    }
    _isPressed = false;
    _sendAmountFocusNode = FocusNode();
    _sendAddressFocusNode = FocusNode();
    _messageFocusNode = FocusNode();
    _sendAmountController = TextEditingController();
    _sendAddressController = TextEditingController();
    _messageController = TextEditingController();
    _sendAddressStyle = AddressStyle.text60;
    quickSendAmount = widget.quickSendAmount;
    if (widget.contact != null) {
      // Setup initial state for contact pre-filled
      _sendAddressController!.text = widget.contact!.name!;
      _isContact = true;
      _qrCodeButtonVisible = false;
      _sendAddressStyle = AddressStyle.primary;
    } else if (widget.address != null) {
      // Setup initial state with prefilled address
      _sendAddressController!.text = widget.address!;
      _qrCodeButtonVisible = false;
      _sendAddressStyle = AddressStyle.text90;
      _addressValidAndUnfocused = true;
    }
    // On amount focus change
    _sendAmountFocusNode!.addListener(() {
      if (_sendAmountFocusNode!.hasFocus) {
        if (_rawAmount != null) {
          setState(() {
            _sendAmountController!.text =
                NumberUtil.getRawAsUsableString(_rawAmount!)
                    .replaceAll(',', '');
            _rawAmount = null;
          });
        }
        if (quickSendAmount != null) {
          _sendAmountController!.text = '';
          setState(() {
            quickSendAmount = null;
          });
        }
      }
    });
    // On address focus change
    _sendAddressFocusNode!.addListener(() {
      if (_sendAddressFocusNode!.hasFocus) {
        _sendAddressController!.selection = TextSelection.fromPosition(
            TextPosition(offset: _sendAddressController!.text.length));
        if (_sendAddressController!.text.startsWith('@')) {
          sl
              .get<DBHelper>()
              .getContactsWithNameLike(_sendAddressController!.text)
              .then((List<Contact> contactList) {});
        }
      } else {
        if (_sendAddressController!.text.trim() == '@') {
          _sendAddressController!.text = '';
        }
      }
    });

    // Set initial currency format
    _localCurrencyFormat = NumberFormat.currency(
        locale:
            CurrencyUtil.getLocale(widget.localCurrency!.toString()).toString(),
        symbol:
            CurrencyUtil.getCurrencySymbol(widget.localCurrency!.toString()));
    // Set quick send amount
    if (quickSendAmount != null) {
      _sendAmountController!.text =
          NumberUtil.getRawAsUsableString(quickSendAmount!).replaceAll(',', '');
    }
  }

  @override
  Widget build(BuildContext context) {
    final double bottom = MediaQuery.of(context).viewInsets.bottom;
    // The main column that holds everything
    return TapOutsideUnfocus(
      child: SafeArea(
        minimum:
            EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.035),
        child: Column(
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
                          ), // Header
                          AutoSizeText(
                            widget.title ?? AppLocalization.of(context)!.send,
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
                                        _sendAmountController!.text = '';
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
                if (kIsWeb || Platform.isMacOS || Platform.isWindows)
                  Stack(
                    children: <Widget>[
                      const SizedBox(
                        width: 60,
                        height: 40,
                      ),
                      Container(
                          padding: const EdgeInsets.only(top: 10),
                          child: InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Column(
                                children: <Widget>[
                                  buildIconDataWidget(
                                      context, Icons.close_outlined, 30, 30),
                                ],
                              ))),
                    ],
                  )
                else
                  const SizedBox(
                    width: 60,
                    height: 40,
                  ),
              ],
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(bottom: 10),
                child: Stack(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        _sendAddressFocusNode!.unfocus();
                        _sendAmountFocusNode!.unfocus();
                      },
                      child: Container(
                        color: Colors.transparent,
                        constraints: const BoxConstraints.expand(),
                        child: const SizedBox.expand(),
                      ),
                    ),
                    SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.only(bottom: bottom + 80),
                        child: Column(
                          children: <Widget>[
                            const SizedBox(height: 25),
                            Column(
                              children: <Widget>[
                                getEnterAmountContainer(),
                                Container(
                                  alignment: const AlignmentDirectional(0, 0),
                                  margin: const EdgeInsets.only(top: 3),
                                  child: Text(_amountValidationText!,
                                      style:
                                          AppStyles.textStyleSize14W600Primary(
                                              context)),
                                ),
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                Container(
                                  alignment: Alignment.topCenter,
                                  child: getEnterAddressContainer(),
                                ),
                                Container(
                                  alignment: const AlignmentDirectional(0, 0),
                                  margin: const EdgeInsets.only(
                                      left: 50, right: 40, top: 3),
                                  child: Text(_addressValidationText!,
                                      style:
                                          AppStyles.textStyleSize14W600Primary(
                                              context)),
                                ),
                                const SizedBox(height: 10),
                                getEnterMessage(),
                                Container(
                                  alignment: const AlignmentDirectional(0, 0),
                                  margin: const EdgeInsets.only(
                                      left: 50, right: 40, top: 3),
                                  child: Text(_messageValidationText!,
                                      style:
                                          AppStyles.textStyleSize14W600Primary(
                                              context)),
                                ),
                                const SizedBox(height: 10),
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 30),
                                  child: feeEstimation > 0
                                      ? Text(
                                          '+ ${AppLocalization.of(context)!.estimatedFees}: $feeEstimation ${StateContainer.of(context).curNetwork.getNetworkCryptoCurrencyLabel()}',
                                          style: AppStyles
                                              .textStyleSize14W100Primary(
                                                  context),
                                        )
                                      : Text(
                                          AppLocalization.of(context)!
                                              .estimatedFeesNote,
                                          style: AppStyles
                                              .textStyleSize14W100Primary(
                                                  context)),
                                ),
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 30),
                                  child: feeEstimation > 0
                                      ? Text(
                                          '(${CurrencyUtil.convertAmountFormatedWithNumberOfDigits(StateContainer.of(context).curCurrency.currency.name, StateContainer.of(context).appWallet!.appKeychain!.getAccountSelected()!.balance!.tokenPrice!.amount!, feeEstimation, 8)})',
                                          style: AppStyles
                                              .textStyleSize14W100Primary(
                                                  context),
                                        )
                                      : const SizedBox(),
                                ),
                                Container(
                                  alignment: const AlignmentDirectional(0, 0),
                                  margin: const EdgeInsets.only(top: 3),
                                  child: Text(_globalValidationText!,
                                      style:
                                          AppStyles.textStyleSize14W600Primary(
                                              context)),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
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
                              const Key('send'),
                              context,
                              AppButtonType.primaryOutline,
                              widget.actionButtonTitle ??
                                  AppLocalization.of(context)!.send,
                              Dimens.buttonTopDimens,
                              onPressed: () {},
                            )
                          : AppButton.buildAppButton(
                              const Key('send'),
                              context,
                              AppButtonType.primary,
                              widget.actionButtonTitle ??
                                  AppLocalization.of(context)!.send,
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
                                    widget: TransferConfirmSheet(
                                      lastAddress: StateContainer.of(context)
                                          .appWallet!
                                          .appKeychain!
                                          .getAccountSelected()!
                                          .lastAddress!,
                                      ucoTransferList: ucoTransferList,
                                      title: widget.title,
                                      typeTransfer: 'UCO',
                                      feeEstimation: feeEstimation,
                                      message: _messageController!.text.trim(),
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

  // Determine if this is a max send or not by comparing balances
  bool _isMaxSend() {
    if (_sendAmountController!.text.isEmpty) {
      return false;
    }
    try {
      final String amount = _rawAmount == null
          ? _sendAmountController!.text
          : NumberUtil.getRawAsUsableString(_rawAmount!);
      final double balanceRaw = StateContainer.of(context)
          .appWallet!
          .appKeychain!
          .getAccountSelected()!
          .balance!
          .nativeTokenValue!;
      if (primaryCurrency == PrimaryCurrency.network) {
        if (double.tryParse(amount)! + feeEstimation == balanceRaw) {
          return true;
        } else {
          return false;
        }
      } else {
        if (priceConverted + feeEstimation ==
            StateContainer.of(context)
                .appWallet!
                .appKeychain!
                .getAccountSelected()!
                .balance!
                .fiatCurrencyValue) {
          return true;
        } else {
          return false;
        }
      }
    } catch (e) {
      return false;
    }
  }

  Widget _balanceNetwork(BuildContext context, bool primary) {
    return Container(
      child: RichText(
        textAlign: TextAlign.start,
        text: TextSpan(
          text: '',
          children: <InlineSpan>[
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

  /// Validate form data to see if valid
  /// @returns true if valid, false otherwise
  Future<bool> _validateRequest() async {
    bool isValid = true;
    UCOTransferWallet ucoTransfer = UCOTransferWallet();
    setState(() {
      _sendAmountFocusNode!.unfocus();
      _sendAddressFocusNode!.unfocus();
      _addressValidationText = '';
      _messageValidationText = '';
      _amountValidationText = '';
      _globalValidationText = '';
    });
    // Validate amount
    if (_sendAmountController!.text.trim().isEmpty) {
      isValid = false;
      setState(() {
        _amountValidationText = AppLocalization.of(context)!.amountMissing;
      });
    } else {
      // Estimation of fees
      feeEstimation = await getFee();

      final String amount = _rawAmount == null
          ? _sendAmountController!.text
          : NumberUtil.getRawAsUsableString(_rawAmount!);
      final double balanceRaw = StateContainer.of(context)
          .appWallet!
          .appKeychain!
          .getAccountSelected()!
          .balance!
          .nativeTokenValue!;
      double sendAmount = 0;
      if (primaryCurrency == PrimaryCurrency.network) {
        sendAmount = double.tryParse(amount)!;
      } else {
        sendAmount = priceConverted;
      }
      if (sendAmount + feeEstimation > balanceRaw) {
        isValid = false;
        setState(() {
          _globalValidationText = AppLocalization.of(context)!
              .insufficientBalance
              .replaceAll(
                  '%1',
                  StateContainer.of(context)
                      .curNetwork
                      .getNetworkCryptoCurrencyLabel());
        });
      } else {
        ucoTransfer.amount = BigInt.from(sendAmount * 100000000);
      }
    }
    // Validate address
    final bool isContact = _sendAddressController!.text.startsWith('@');
    Contact? contact;
    if (_sendAddressController!.text.trim().isEmpty) {
      isValid = false;
      setState(() {
        _addressValidationText = AppLocalization.of(context)!.addressMissing;
        _qrCodeButtonVisible = true;
      });
    } else if (!isContact && !Address(_sendAddressController!.text).isValid()) {
      isValid = false;
      setState(() {
        _addressValidationText = AppLocalization.of(context)!.invalidAddress;
        _qrCodeButtonVisible = true;
      });
    } else if (!isContact) {
      try {
        contact = await sl
            .get<DBHelper>()
            .getContactWithAddress(_sendAddressController!.text);
        // ignore: empty_catches
      } catch (e) {}

      setState(() {
        _addressValidationText = '';
        _qrCodeButtonVisible = false;
      });
      _sendAddressFocusNode!.unfocus();
    } else {
      // Get contact info
      try {
        contact = await sl
            .get<DBHelper>()
            .getContactWithName(_sendAddressController!.text);
      } catch (e) {
        isValid = false;
        setState(() {
          _addressValidationText = AppLocalization.of(context)!.contactInvalid;
          _qrCodeButtonVisible = true;
        });
      }
    }

    final regex = RegExp(
        '(\u{D83C}\u{DFF4}\u{DB40}\u{DC67}\u{DB40}\u{DC62}(?:\u{DB40}\u{DC77}\u{DB40}\u{DC6C}\u{DB40}\u{DC73}|\u{DB40}\u{DC73}\u{DB40}\u{DC63}\u{DB40}\u{DC74}|\u{DB40}\u{DC65}\u{DB40}\u{DC6E}\u{DB40}\u{DC67})\u{DB40}\u{DC7F}|\u{D83D}\u{DC69}\u{200D}\u{D83D}\u{DC69}\u{200D}(?:\u{D83D}\u{DC66}\u{200D}\u{D83D}\u{DC66}|\u{D83D}\u{DC67}\u{200D}(?:\u{D83D}[\u{DC66}\u{DC67}]))|\u{D83D}\u{DC68}(?:\u{D83C}\u{DFFF}\u{200D}(?:\u{D83E}\u{DD1D}\u{200D}\u{D83D}\u{DC68}(?:\u{D83C}[\u{DFFB}-\u{DFFE}])|\u{D83C}[\u{DF3E}\u{DF73}\u{DF7C}\u{DF93}\u{DFA4}\u{DFA8}\u{DFEB}\u{DFED}]|\u{D83D}[\u{DCBB}\u{DCBC}\u{DD27}\u{DD2C}\u{DE80}\u{DE92}]|\u{D83E}[\u{DDAF}-\u{DDB3}\u{DDBC}\u{DDBD}])|\u{D83C}\u{DFFE}\u{200D}(?:\u{D83E}\u{DD1D}\u{200D}\u{D83D}\u{DC68}(?:\u{D83C}[\u{DFFB}-\u{DFFD}\u{DFFF}])|\u{D83C}[\u{DF3E}\u{DF73}\u{DF7C}\u{DF93}\u{DFA4}\u{DFA8}\u{DFEB}\u{DFED}]|\u{D83D}[\u{DCBB}\u{DCBC}\u{DD27}\u{DD2C}\u{DE80}\u{DE92}]|\u{D83E}[\u{DDAF}-\u{DDB3}\u{DDBC}\u{DDBD}])|\u{D83C}\u{DFFD}\u{200D}(?:\u{D83E}\u{DD1D}\u{200D}\u{D83D}\u{DC68}(?:\u{D83C}[\u{DFFB}\u{DFFC}\u{DFFE}\u{DFFF}])|\u{D83C}[\u{DF3E}\u{DF73}\u{DF7C}\u{DF93}\u{DFA4}\u{DFA8}\u{DFEB}\u{DFED}]|\u{D83D}[\u{DCBB}\u{DCBC}\u{DD27}\u{DD2C}\u{DE80}\u{DE92}]|\u{D83E}[\u{DDAF}-\u{DDB3}\u{DDBC}\u{DDBD}])|\u{D83C}\u{DFFC}\u{200D}(?:\u{D83E}\u{DD1D}\u{200D}\u{D83D}\u{DC68}(?:\u{D83C}[\u{DFFB}\u{DFFD}-\u{DFFF}])|\u{D83C}[\u{DF3E}\u{DF73}\u{DF7C}\u{DF93}\u{DFA4}\u{DFA8}\u{DFEB}\u{DFED}]|\u{D83D}[\u{DCBB}\u{DCBC}\u{DD27}\u{DD2C}\u{DE80}\u{DE92}]|\u{D83E}[\u{DDAF}-\u{DDB3}\u{DDBC}\u{DDBD}])|\u{D83C}\u{DFFB}\u{200D}(?:\u{D83E}\u{DD1D}\u{200D}\u{D83D}\u{DC68}(?:\u{D83C}[\u{DFFC}-\u{DFFF}])|\u{D83C}[\u{DF3E}\u{DF73}\u{DF7C}\u{DF93}\u{DFA4}\u{DFA8}\u{DFEB}\u{DFED}]|\u{D83D}[\u{DCBB}\u{DCBC}\u{DD27}\u{DD2C}\u{DE80}\u{DE92}]|\u{D83E}[\u{DDAF}-\u{DDB3}\u{DDBC}\u{DDBD}])|\u{200D}(?:\u{2764}\u{FE0F}\u{200D}(?:\u{D83D}\u{DC8B}\u{200D})?\u{D83D}\u{DC68}|(?:\u{D83D}[\u{DC68}\u{DC69}])\u{200D}(?:\u{D83D}\u{DC66}\u{200D}\u{D83D}\u{DC66}|\u{D83D}\u{DC67}\u{200D}(?:\u{D83D}[\u{DC66}\u{DC67}]))|\u{D83D}\u{DC66}\u{200D}\u{D83D}\u{DC66}|\u{D83D}\u{DC67}\u{200D}(?:\u{D83D}[\u{DC66}\u{DC67}])|(?:\u{D83D}[\u{DC68}\u{DC69}])\u{200D}(?:\u{D83D}[\u{DC66}\u{DC67}])|[\u{2695}\u{2696}\u{2708}]\u{FE0F}|\u{D83D}[\u{DC66}\u{DC67}]|\u{D83C}[\u{DF3E}\u{DF73}\u{DF7C}\u{DF93}\u{DFA4}\u{DFA8}\u{DFEB}\u{DFED}]|\u{D83D}[\u{DCBB}\u{DCBC}\u{DD27}\u{DD2C}\u{DE80}\u{DE92}]|\u{D83E}[\u{DDAF}-\u{DDB3}\u{DDBC}\u{DDBD}])|(?:\u{D83C}\u{DFFF}\u{200D}[\u{2695}\u{2696}\u{2708}]|\u{D83C}\u{DFFE}\u{200D}[\u{2695}\u{2696}\u{2708}]|\u{D83C}\u{DFFD}\u{200D}[\u{2695}\u{2696}\u{2708}]|\u{D83C}\u{DFFC}\u{200D}[\u{2695}\u{2696}\u{2708}]|\u{D83C}\u{DFFB}\u{200D}[\u{2695}\u{2696}\u{2708}])\u{FE0F}|\u{D83C}[\u{DFFB}-\u{DFFF}])|\u{D83E}\u{DDD1}(?:(?:\u{D83C}[\u{DFFB}-\u{DFFF}])\u{200D}(?:\u{D83E}\u{DD1D}\u{200D}\u{D83E}\u{DDD1}(?:\u{D83C}[\u{DFFB}-\u{DFFF}])|\u{D83C}[\u{DF3E}\u{DF73}\u{DF7C}\u{DF84}\u{DF93}\u{DFA4}\u{DFA8}\u{DFEB}\u{DFED}]|\u{D83D}[\u{DCBB}\u{DCBC}\u{DD27}\u{DD2C}\u{DE80}\u{DE92}]|\u{D83E}[\u{DDAF}-\u{DDB3}\u{DDBC}\u{DDBD}])|\u{200D}(?:\u{D83E}\u{DD1D}\u{200D}\u{D83E}\u{DDD1}|\u{D83C}[\u{DF3E}\u{DF73}\u{DF7C}\u{DF84}\u{DF93}\u{DFA4}\u{DFA8}\u{DFEB}\u{DFED}]|\u{D83D}[\u{DCBB}\u{DCBC}\u{DD27}\u{DD2C}\u{DE80}\u{DE92}]|\u{D83E}[\u{DDAF}-\u{DDB3}\u{DDBC}\u{DDBD}]))|\u{D83D}\u{DC69}(?:\u{200D}(?:\u{2764}\u{FE0F}\u{200D}(?:\u{D83D}\u{DC8B}\u{200D}(?:\u{D83D}[\u{DC68}\u{DC69}])|\u{D83D}[\u{DC68}\u{DC69}])|\u{D83C}[\u{DF3E}\u{DF73}\u{DF7C}\u{DF93}\u{DFA4}\u{DFA8}\u{DFEB}\u{DFED}]|\u{D83D}[\u{DCBB}\u{DCBC}\u{DD27}\u{DD2C}\u{DE80}\u{DE92}]|\u{D83E}[\u{DDAF}-\u{DDB3}\u{DDBC}\u{DDBD}])|\u{D83C}\u{DFFF}\u{200D}(?:\u{D83C}[\u{DF3E}\u{DF73}\u{DF7C}\u{DF93}\u{DFA4}\u{DFA8}\u{DFEB}\u{DFED}]|\u{D83D}[\u{DCBB}\u{DCBC}\u{DD27}\u{DD2C}\u{DE80}\u{DE92}]|\u{D83E}[\u{DDAF}-\u{DDB3}\u{DDBC}\u{DDBD}])|\u{D83C}\u{DFFE}\u{200D}(?:\u{D83C}[\u{DF3E}\u{DF73}\u{DF7C}\u{DF93}\u{DFA4}\u{DFA8}\u{DFEB}\u{DFED}]|\u{D83D}[\u{DCBB}\u{DCBC}\u{DD27}\u{DD2C}\u{DE80}\u{DE92}]|\u{D83E}[\u{DDAF}-\u{DDB3}\u{DDBC}\u{DDBD}])|\u{D83C}\u{DFFD}\u{200D}(?:\u{D83C}[\u{DF3E}\u{DF73}\u{DF7C}\u{DF93}\u{DFA4}\u{DFA8}\u{DFEB}\u{DFED}]|\u{D83D}[\u{DCBB}\u{DCBC}\u{DD27}\u{DD2C}\u{DE80}\u{DE92}]|\u{D83E}[\u{DDAF}-\u{DDB3}\u{DDBC}\u{DDBD}])|\u{D83C}\u{DFFC}\u{200D}(?:\u{D83C}[\u{DF3E}\u{DF73}\u{DF7C}\u{DF93}\u{DFA4}\u{DFA8}\u{DFEB}\u{DFED}]|\u{D83D}[\u{DCBB}\u{DCBC}\u{DD27}\u{DD2C}\u{DE80}\u{DE92}]|\u{D83E}[\u{DDAF}-\u{DDB3}\u{DDBC}\u{DDBD}])|\u{D83C}\u{DFFB}\u{200D}(?:\u{D83C}[\u{DF3E}\u{DF73}\u{DF7C}\u{DF93}\u{DFA4}\u{DFA8}\u{DFEB}\u{DFED}]|\u{D83D}[\u{DCBB}\u{DCBC}\u{DD27}\u{DD2C}\u{DE80}\u{DE92}]|\u{D83E}[\u{DDAF}-\u{DDB3}\u{DDBC}\u{DDBD}]))|\u{D83D}\u{DC69}\u{D83C}\u{DFFF}\u{200D}\u{D83E}\u{DD1D}\u{200D}(?:\u{D83D}[\u{DC68}\u{DC69}])(?:\u{D83C}[\u{DFFB}-\u{DFFE}])|\u{D83D}\u{DC69}\u{D83C}\u{DFFE}\u{200D}\u{D83E}\u{DD1D}\u{200D}(?:\u{D83D}[\u{DC68}\u{DC69}])(?:\u{D83C}[\u{DFFB}-\u{DFFD}\u{DFFF}])|\u{D83D}\u{DC69}\u{D83C}\u{DFFD}\u{200D}\u{D83E}\u{DD1D}\u{200D}(?:\u{D83D}[\u{DC68}\u{DC69}])(?:\u{D83C}[\u{DFFB}\u{DFFC}\u{DFFE}\u{DFFF}])|\u{D83D}\u{DC69}\u{D83C}\u{DFFC}\u{200D}\u{D83E}\u{DD1D}\u{200D}(?:\u{D83D}[\u{DC68}\u{DC69}])(?:\u{D83C}[\u{DFFB}\u{DFFD}-\u{DFFF}])|\u{D83D}\u{DC69}\u{D83C}\u{DFFB}\u{200D}\u{D83E}\u{DD1D}\u{200D}(?:\u{D83D}[\u{DC68}\u{DC69}])(?:\u{D83C}[\u{DFFC}-\u{DFFF}])|\u{D83D}\u{DC69}\u{200D}\u{D83D}\u{DC66}\u{200D}\u{D83D}\u{DC66}|\u{D83D}\u{DC69}\u{200D}\u{D83D}\u{DC69}\u{200D}(?:\u{D83D}[\u{DC66}\u{DC67}])|(?:\u{D83D}\u{DC41}\u{FE0F}\u{200D}\u{D83D}\u{DDE8}|\u{D83D}\u{DC69}(?:\u{D83C}\u{DFFF}\u{200D}[\u{2695}\u{2696}\u{2708}]|\u{D83C}\u{DFFE}\u{200D}[\u{2695}\u{2696}\u{2708}]|\u{D83C}\u{DFFD}\u{200D}[\u{2695}\u{2696}\u{2708}]|\u{D83C}\u{DFFC}\u{200D}[\u{2695}\u{2696}\u{2708}]|\u{D83C}\u{DFFB}\u{200D}[\u{2695}\u{2696}\u{2708}]|\u{200D}[\u{2695}\u{2696}\u{2708}])|\u{D83C}\u{DFF3}\u{FE0F}\u{200D}\u{26A7}|\u{D83E}\u{DDD1}(?:(?:\u{D83C}[\u{DFFB}-\u{DFFF}])\u{200D}[\u{2695}\u{2696}\u{2708}]|\u{200D}[\u{2695}\u{2696}\u{2708}])|\u{D83D}\u{DC3B}\u{200D}\u{2744}|(?:\u{D83C}[\u{DFC3}\u{DFC4}\u{DFCA}]|\u{D83D}[\u{DC6E}\u{DC70}\u{DC71}\u{DC73}\u{DC77}\u{DC81}\u{DC82}\u{DC86}\u{DC87}\u{DE45}-\u{DE47}\u{DE4B}\u{DE4D}\u{DE4E}\u{DEA3}\u{DEB4}-\u{DEB6}]|\u{D83E}[\u{DD26}\u{DD35}\u{DD37}-\u{DD39}\u{DD3D}\u{DD3E}\u{DDB8}\u{DDB9}\u{DDCD}-\u{DDCF}\u{DDD6}-\u{DDDD}])(?:\u{D83C}[\u{DFFB}-\u{DFFF}])\u{200D}[\u{2640}\u{2642}]|(?:\u{26F9}|\u{D83C}[\u{DFCB}\u{DFCC}]|\u{D83D}\u{DD75})(?:\u{FE0F}\u{200D}[\u{2640}\u{2642}]|(?:\u{D83C}[\u{DFFB}-\u{DFFF}])\u{200D}[\u{2640}\u{2642}])|\u{D83C}\u{DFF4}\u{200D}\u{2620}|(?:\u{D83C}[\u{DFC3}\u{DFC4}\u{DFCA}]|\u{D83D}[\u{DC6E}-\u{DC71}\u{DC73}\u{DC77}\u{DC81}\u{DC82}\u{DC86}\u{DC87}\u{DE45}-\u{DE47}\u{DE4B}\u{DE4D}\u{DE4E}\u{DEA3}\u{DEB4}-\u{DEB6}]|\u{D83E}[\u{DD26}\u{DD35}\u{DD37}-\u{DD39}\u{DD3C}-\u{DD3E}\u{DDB8}\u{DDB9}\u{DDCD}-\u{DDCF}\u{DDD6}-\u{DDDF}])\u{200D}[\u{2640}\u{2642}])\u{FE0F}|\u{D83D}\u{DC69}\u{200D}\u{D83D}\u{DC67}\u{200D}(?:\u{D83D}[\u{DC66}\u{DC67}])|\u{D83C}\u{DFF3}\u{FE0F}\u{200D}\u{D83C}\u{DF08}|\u{D83D}\u{DC69}\u{200D}\u{D83D}\u{DC67}|\u{D83D}\u{DC69}\u{200D}\u{D83D}\u{DC66}|\u{D83D}\u{DC15}\u{200D}\u{D83E}\u{DDBA}|\u{D83C}\u{DDFD}\u{D83C}\u{DDF0}|\u{D83C}\u{DDF6}\u{D83C}\u{DDE6}|\u{D83C}\u{DDF4}\u{D83C}\u{DDF2}|\u{D83D}\u{DC08}\u{200D}\u{2B1B}|\u{D83E}\u{DDD1}(?:\u{D83C}[\u{DFFB}-\u{DFFF}])|\u{D83D}\u{DC69}(?:\u{D83C}[\u{DFFB}-\u{DFFF}])|\u{D83C}\u{DDFF}(?:\u{D83C}[\u{DDE6}\u{DDF2}\u{DDFC}])|\u{D83C}\u{DDFE}(?:\u{D83C}[\u{DDEA}\u{DDF9}])|\u{D83C}\u{DDFC}(?:\u{D83C}[\u{DDEB}\u{DDF8}])|\u{D83C}\u{DDFB}(?:\u{D83C}[\u{DDE6}\u{DDE8}\u{DDEA}\u{DDEC}\u{DDEE}\u{DDF3}\u{DDFA}])|\u{D83C}\u{DDFA}(?:\u{D83C}[\u{DDE6}\u{DDEC}\u{DDF2}\u{DDF3}\u{DDF8}\u{DDFE}\u{DDFF}])|\u{D83C}\u{DDF9}(?:\u{D83C}[\u{DDE6}\u{DDE8}\u{DDE9}\u{DDEB}-\u{DDED}\u{DDEF}-\u{DDF4}\u{DDF7}\u{DDF9}\u{DDFB}\u{DDFC}\u{DDFF}])|\u{D83C}\u{DDF8}(?:\u{D83C}[\u{DDE6}-\u{DDEA}\u{DDEC}-\u{DDF4}\u{DDF7}-\u{DDF9}\u{DDFB}\u{DDFD}-\u{DDFF}])|\u{D83C}\u{DDF7}(?:\u{D83C}[\u{DDEA}\u{DDF4}\u{DDF8}\u{DDFA}\u{DDFC}])|\u{D83C}\u{DDF5}(?:\u{D83C}[\u{DDE6}\u{DDEA}-\u{DDED}\u{DDF0}-\u{DDF3}\u{DDF7}-\u{DDF9}\u{DDFC}\u{DDFE}])|\u{D83C}\u{DDF3}(?:\u{D83C}[\u{DDE6}\u{DDE8}\u{DDEA}-\u{DDEC}\u{DDEE}\u{DDF1}\u{DDF4}\u{DDF5}\u{DDF7}\u{DDFA}\u{DDFF}])|\u{D83C}\u{DDF2}(?:\u{D83C}[\u{DDE6}\u{DDE8}-\u{DDED}\u{DDF0}-\u{DDFF}])|\u{D83C}\u{DDF1}(?:\u{D83C}[\u{DDE6}-\u{DDE8}\u{DDEE}\u{DDF0}\u{DDF7}-\u{DDFB}\u{DDFE}])|\u{D83C}\u{DDF0}(?:\u{D83C}[\u{DDEA}\u{DDEC}-\u{DDEE}\u{DDF2}\u{DDF3}\u{DDF5}\u{DDF7}\u{DDFC}\u{DDFE}\u{DDFF}])|\u{D83C}\u{DDEF}(?:\u{D83C}[\u{DDEA}\u{DDF2}\u{DDF4}\u{DDF5}])|\u{D83C}\u{DDEE}(?:\u{D83C}[\u{DDE8}-\u{DDEA}\u{DDF1}-\u{DDF4}\u{DDF6}-\u{DDF9}])|\u{D83C}\u{DDED}(?:\u{D83C}[\u{DDF0}\u{DDF2}\u{DDF3}\u{DDF7}\u{DDF9}\u{DDFA}])|\u{D83C}\u{DDEC}(?:\u{D83C}[\u{DDE6}\u{DDE7}\u{DDE9}-\u{DDEE}\u{DDF1}-\u{DDF3}\u{DDF5}-\u{DDFA}\u{DDFC}\u{DDFE}])|\u{D83C}\u{DDEB}(?:\u{D83C}[\u{DDEE}-\u{DDF0}\u{DDF2}\u{DDF4}\u{DDF7}])|\u{D83C}\u{DDEA}(?:\u{D83C}[\u{DDE6}\u{DDE8}\u{DDEA}\u{DDEC}\u{DDED}\u{DDF7}-\u{DDFA}])|\u{D83C}\u{DDE9}(?:\u{D83C}[\u{DDEA}\u{DDEC}\u{DDEF}\u{DDF0}\u{DDF2}\u{DDF4}\u{DDFF}])|\u{D83C}\u{DDE8}(?:\u{D83C}[\u{DDE6}\u{DDE8}\u{DDE9}\u{DDEB}-\u{DDEE}\u{DDF0}-\u{DDF5}\u{DDF7}\u{DDFA}-\u{DDFF}])|\u{D83C}\u{DDE7}(?:\u{D83C}[\u{DDE6}\u{DDE7}\u{DDE9}-\u{DDEF}\u{DDF1}-\u{DDF4}\u{DDF6}-\u{DDF9}\u{DDFB}\u{DDFC}\u{DDFE}\u{DDFF}])|\u{D83C}\u{DDE6}(?:\u{D83C}[\u{DDE8}-\u{DDEC}\u{DDEE}\u{DDF1}\u{DDF2}\u{DDF4}\u{DDF6}-\u{DDFA}\u{DDFC}\u{DDFD}\u{DDFF}])|[#\\*0-9]\u{FE0F}\u{20E3}|(?:\u{D83C}[\u{DFC3}\u{DFC4}\u{DFCA}]|\u{D83D}[\u{DC6E}\u{DC70}\u{DC71}\u{DC73}\u{DC77}\u{DC81}\u{DC82}\u{DC86}\u{DC87}\u{DE45}-\u{DE47}\u{DE4B}\u{DE4D}\u{DE4E}\u{DEA3}\u{DEB4}-\u{DEB6}]|\u{D83E}[\u{DD26}\u{DD35}\u{DD37}-\u{DD39}\u{DD3D}\u{DD3E}\u{DDB8}\u{DDB9}\u{DDCD}-\u{DDCF}\u{DDD6}-\u{DDDD}])(?:\u{D83C}[\u{DFFB}-\u{DFFF}])|(?:\u{26F9}|\u{D83C}[\u{DFCB}\u{DFCC}]|\u{D83D}\u{DD75})(?:\u{D83C}[\u{DFFB}-\u{DFFF}])|(?:[\u{261D}\u{270A}-\u{270D}]|\u{D83C}[\u{DF85}\u{DFC2}\u{DFC7}]|\u{D83D}[\u{DC42}\u{DC43}\u{DC46}-\u{DC50}\u{DC66}\u{DC67}\u{DC6B}-\u{DC6D}\u{DC72}\u{DC74}-\u{DC76}\u{DC78}\u{DC7C}\u{DC83}\u{DC85}\u{DCAA}\u{DD74}\u{DD7A}\u{DD90}\u{DD95}\u{DD96}\u{DE4C}\u{DE4F}\u{DEC0}\u{DECC}]|\u{D83E}[\u{DD0C}\u{DD0F}\u{DD18}-\u{DD1C}\u{DD1E}\u{DD1F}\u{DD30}-\u{DD34}\u{DD36}\u{DD77}\u{DDB5}\u{DDB6}\u{DDBB}\u{DDD2}-\u{DDD5}])(?:\u{D83C}[\u{DFFB}-\u{DFFF}])|(?:[\u{231A}\u{231B}\u{23E9}-\u{23EC}\u{23F0}\u{23F3}\u{25FD}\u{25FE}\u{2614}\u{2615}\u{2648}-\u{2653}\u{267F}\u{2693}\u{26A1}\u{26AA}\u{26AB}\u{26BD}\u{26BE}\u{26C4}\u{26C5}\u{26CE}\u{26D4}\u{26EA}\u{26F2}\u{26F3}\u{26F5}\u{26FA}\u{26FD}\u{2705}\u{270A}\u{270B}\u{2728}\u{274C}\u{274E}\u{2753}-\u{2755}\u{2757}\u{2795}-\u{2797}\u{27B0}\u{27BF}\u{2B1B}\u{2B1C}\u{2B50}\u{2B55}]|\u{D83C}[\u{DC04}\u{DCCF}\u{DD8E}\u{DD91}-\u{DD9A}\u{DDE6}-\u{DDFF}\u{DE01}\u{DE1A}\u{DE2F}\u{DE32}-\u{DE36}\u{DE38}-\u{DE3A}\u{DE50}\u{DE51}\u{DF00}-\u{DF20}\u{DF2D}-\u{DF35}\u{DF37}-\u{DF7C}\u{DF7E}-\u{DF93}\u{DFA0}-\u{DFCA}\u{DFCF}-\u{DFD3}\u{DFE0}-\u{DFF0}\u{DFF4}\u{DFF8}-\u{DFFF}]|\u{D83D}[\u{DC00}-\u{DC3E}\u{DC40}\u{DC42}-\u{DCFC}\u{DCFF}-\u{DD3D}\u{DD4B}-\u{DD4E}\u{DD50}-\u{DD67}\u{DD7A}\u{DD95}\u{DD96}\u{DDA4}\u{DDFB}-\u{DE4F}\u{DE80}-\u{DEC5}\u{DECC}\u{DED0}-\u{DED2}\u{DED5}-\u{DED7}\u{DEEB}\u{DEEC}\u{DEF4}-\u{DEFC}\u{DFE0}-\u{DFEB}]|\u{D83E}[\u{DD0C}-\u{DD3A}\u{DD3C}-\u{DD45}\u{DD47}-\u{DD78}\u{DD7A}-\u{DDCB}\u{DDCD}-\u{DDFF}\u{DE70}-\u{DE74}\u{DE78}-\u{DE7A}\u{DE80}-\u{DE86}\u{DE90}-\u{DEA8}\u{DEB0}-\u{DEB6}\u{DEC0}-\u{DEC2}\u{DED0}-\u{DED6}])|(?:[#\\*0-9\\xA9\\xAE\u{203C}\u{2049}\u{2122}\u{2139}\u{2194}-\u{2199}\u{21A9}\u{21AA}\u{231A}\u{231B}\u{2328}\u{23CF}\u{23E9}-\u{23F3}\u{23F8}-\u{23FA}\u{24C2}\u{25AA}\u{25AB}\u{25B6}\u{25C0}\u{25FB}-\u{25FE}\u{2600}-\u{2604}\u{260E}\u{2611}\u{2614}\u{2615}\u{2618}\u{261D}\u{2620}\u{2622}\u{2623}\u{2626}\u{262A}\u{262E}\u{262F}\u{2638}-\u{263A}\u{2640}\u{2642}\u{2648}-\u{2653}\u{265F}\u{2660}\u{2663}\u{2665}\u{2666}\u{2668}\u{267B}\u{267E}\u{267F}\u{2692}-\u{2697}\u{2699}\u{269B}\u{269C}\u{26A0}\u{26A1}\u{26A7}\u{26AA}\u{26AB}\u{26B0}\u{26B1}\u{26BD}\u{26BE}\u{26C4}\u{26C5}\u{26C8}\u{26CE}\u{26CF}\u{26D1}\u{26D3}\u{26D4}\u{26E9}\u{26EA}\u{26F0}-\u{26F5}\u{26F7}-\u{26FA}\u{26FD}\u{2702}\u{2705}\u{2708}-\u{270D}\u{270F}\u{2712}\u{2714}\u{2716}\u{271D}\u{2721}\u{2728}\u{2733}\u{2734}\u{2744}\u{2747}\u{274C}\u{274E}\u{2753}-\u{2755}\u{2757}\u{2763}\u{2764}\u{2795}-\u{2797}\u{27A1}\u{27B0}\u{27BF}\u{2934}\u{2935}\u{2B05}-\u{2B07}\u{2B1B}\u{2B1C}\u{2B50}\u{2B55}\u{3030}\u{303D}\u{3297}\u{3299}]|\u{D83C}[\u{DC04}\u{DCCF}\u{DD70}\u{DD71}\u{DD7E}\u{DD7F}\u{DD8E}\u{DD91}-\u{DD9A}\u{DDE6}-\u{DDFF}\u{DE01}\u{DE02}\u{DE1A}\u{DE2F}\u{DE32}-\u{DE3A}\u{DE50}\u{DE51}\u{DF00}-\u{DF21}\u{DF24}-\u{DF93}\u{DF96}\u{DF97}\u{DF99}-\u{DF9B}\u{DF9E}-\u{DFF0}\u{DFF3}-\u{DFF5}\u{DFF7}-\u{DFFF}]|\u{D83D}[\u{DC00}-\u{DCFD}\u{DCFF}-\u{DD3D}\u{DD49}-\u{DD4E}\u{DD50}-\u{DD67}\u{DD6F}\u{DD70}\u{DD73}-\u{DD7A}\u{DD87}\u{DD8A}-\u{DD8D}\u{DD90}\u{DD95}\u{DD96}\u{DDA4}\u{DDA5}\u{DDA8}\u{DDB1}\u{DDB2}\u{DDBC}\u{DDC2}-\u{DDC4}\u{DDD1}-\u{DDD3}\u{DDDC}-\u{DDDE}\u{DDE1}\u{DDE3}\u{DDE8}\u{DDEF}\u{DDF3}\u{DDFA}-\u{DE4F}\u{DE80}-\u{DEC5}\u{DECB}-\u{DED2}\u{DED5}-\u{DED7}\u{DEE0}-\u{DEE5}\u{DEE9}\u{DEEB}\u{DEEC}\u{DEF0}\u{DEF3}-\u{DEFC}\u{DFE0}-\u{DFEB}]|\u{D83E}[\u{DD0C}-\u{DD3A}\u{DD3C}-\u{DD45}\u{DD47}-\u{DD78}\u{DD7A}-\u{DDCB}\u{DDCD}-\u{DDFF}\u{DE70}-\u{DE74}\u{DE78}-\u{DE7A}\u{DE80}-\u{DE86}\u{DE90}-\u{DEA8}\u{DEB0}-\u{DEB6}\u{DEC0}-\u{DEC2}\u{DED0}-\u{DED6}])\u{FE0F}|(?:[\u{261D}\u{26F9}\u{270A}-\u{270D}]|\u{D83C}[\u{DF85}\u{DFC2}-\u{DFC4}\u{DFC7}\u{DFCA}-\u{DFCC}]|\u{D83D}[\u{DC42}\u{DC43}\u{DC46}-\u{DC50}\u{DC66}-\u{DC78}\u{DC7C}\u{DC81}-\u{DC83}\u{DC85}-\u{DC87}\u{DC8F}\u{DC91}\u{DCAA}\u{DD74}\u{DD75}\u{DD7A}\u{DD90}\u{DD95}\u{DD96}\u{DE45}-\u{DE47}\u{DE4B}-\u{DE4F}\u{DEA3}\u{DEB4}-\u{DEB6}\u{DEC0}\u{DECC}]|\u{D83E}[\u{DD0C}\u{DD0F}\u{DD18}-\u{DD1F}\u{DD26}\u{DD30}-\u{DD39}\u{DD3C}-\u{DD3E}\u{DD77}\u{DDB5}\u{DDB6}\u{DDB8}\u{DDB9}\u{DDBB}\u{DDCD}-\u{DDCF}\u{DDD1}-\u{DDDD}]))');
    var matches = regex.allMatches(_messageController!.text);
    if (matches.length > 0) {
      isValid = false;
      setState(() {
        _messageValidationText = AppLocalization.of(context)!.messageInvalid;
        _qrCodeButtonVisible = true;
      });
    }

    if (isValid) {
      ucoTransferList.clear();
      if (contact != null) {
        ucoTransfer.toContactName = contact.name!;
        ucoTransfer.to = contact.address!;
      } else {
        ucoTransfer.to = _sendAddressController!.text.trim();
      }
      //
      String lastAddressRecipient = await sl
          .get<AddressService>()
          .lastAddressFromAddress(ucoTransfer.to!);
      if (lastAddressRecipient == '') {
        lastAddressRecipient = ucoTransfer.to!;
      }
      if (lastAddressRecipient ==
          StateContainer.of(context)
              .appWallet!
              .appKeychain!
              .getAccountSelected()!
              .lastAddress!) {
        isValid = false;
        setState(() {
          _addressValidationText = AppLocalization.of(context)!
              .sendToMeError
              .replaceAll(
                  '%1',
                  StateContainer.of(context)
                      .curNetwork
                      .getNetworkCryptoCurrencyLabel());
          _qrCodeButtonVisible = true;
        });
      } else {
        ucoTransferList.add(ucoTransfer);
      }
    }
    return isValid;
  }

  Widget getEnterAmountContainer() {
    return Column(
      children: [
        AppTextField(
          focusNode: _sendAmountFocusNode,
          controller: _sendAmountController,
          cursorColor: StateContainer.of(context).curTheme.text,
          style: AppStyles.textStyleSize16W700Primary(context),
          inputFormatters: [
            LengthLimitingTextInputFormatter(16),
            CurrencyFormatter(
                maxDecimalDigits: primaryCurrency == PrimaryCurrency.network
                    ? 8
                    : _localCurrencyFormat!.decimalDigits!),
            LocalCurrencyFormatter(
                active: false, currencyFormat: _localCurrencyFormat!),
            FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,8}')),
          ],
          onChanged: (String text) async {
            double fee = await getFee();
            // Always reset the error message to be less annoying
            setState(() {
              feeEstimation = fee;
              _amountValidationText = '';
              // Reset the raw amount
              _rawAmount = null;
            });
          },
          textInputAction: TextInputAction.next,
          maxLines: null,
          autocorrect: false,
          labelText: primaryCurrency == PrimaryCurrency.network
              ? '${AppLocalization.of(context)!.enterAmount} (${StateContainer.of(context).curNetwork.getNetworkCryptoCurrencyLabel()})'
              : '${AppLocalization.of(context)!.enterAmount} (${StateContainer.of(context).curCurrency.currency.name})',
          suffixButton: TextFieldButton(
            icon: FontAwesomeIcons.anglesUp,
            onPressed: () async {
              sl.get<HapticUtil>().feedback(FeedbackType.light,
                  StateContainer.of(context).activeVibrations);
              double fee = await getFee(maxSend: true);

              double sendAmount = 0;
              if (primaryCurrency == PrimaryCurrency.network) {
                sendAmount = StateContainer.of(context)
                        .appWallet!
                        .appKeychain!
                        .getAccountSelected()!
                        .balance!
                        .nativeTokenValue! -
                    fee;
                _sendAmountController!.text = sendAmount.toStringAsFixed(8);
              } else {
                double selectedCurrencyFee = StateContainer.of(context)
                        .appWallet!
                        .appKeychain!
                        .getAccountSelected()!
                        .balance!
                        .tokenPrice!
                        .amount! *
                    fee;
                sendAmount = StateContainer.of(context)
                        .appWallet!
                        .appKeychain!
                        .getAccountSelected()!
                        .balance!
                        .fiatCurrencyValue! -
                    selectedCurrencyFee;
                _sendAmountController!.text = sendAmount
                    .toStringAsFixed(_localCurrencyFormat!.decimalDigits!);
              }

              setState(() {
                feeEstimation = fee;
                _amountValidationText = '';
                // Reset the raw amount
                _rawAmount = null;
              });
              if (_isMaxSend()) {
                return;
              }

              feeEstimation = await getFee();
              _sendAddressController!.selection = TextSelection.fromPosition(
                  TextPosition(offset: _sendAddressController!.text.length));
            },
          ),
          fadeSuffixOnCondition: true,
          suffixShowFirstCondition: !_isMaxSend(),
          keyboardType: const TextInputType.numberWithOptions(
              signed: true, decimal: true),
          textAlign: TextAlign.center,
          onSubmitted: (String text) {
            FocusScope.of(context).unfocus();
            if (!Address(_sendAddressController!.text).isValid()) {
              FocusScope.of(context).requestFocus(_sendAddressFocusNode);
            }
          },
        ),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Container(
            margin: const EdgeInsets.only(left: 40),
            alignment: Alignment.centerLeft,
            child: AutoSizeText(
              '1 ${StateContainer.of(context).appWallet!.appKeychain!.getAccountSelected()!.balance!.nativeTokenName!} = ${CurrencyUtil.getAmountPlusSymbol(StateContainer.of(context).appWallet!.appKeychain!.getAccountSelected()!.balance!.fiatCurrencyCode!, StateContainer.of(context).appWallet!.appKeychain!.getAccountSelected()!.balance!.tokenPrice!.amount!)}',
              style: AppStyles.textStyleSize14W100Primary(context),
            ),
          ),
          _sendAmountController!.text.isNotEmpty
              ? Container(
                  margin: const EdgeInsets.only(right: 40),
                  alignment: Alignment.centerRight,
                  child: primaryCurrency == PrimaryCurrency.network
                      ? Text('= ${_convertNetworkCurrencyToSelectedCurrency()}',
                          textAlign: TextAlign.right,
                          style: AppStyles.textStyleSize14W100Primary(context))
                      : Text('= ${_convertSelectedCurrencyToNetworkCurrency()}',
                          textAlign: TextAlign.right,
                          style: AppStyles.textStyleSize14W100Primary(context)),
                )
              : const SizedBox(),
        ]),
      ],
    );
  }

  AppTextField getEnterMessage() {
    return AppTextField(
      focusNode: _messageFocusNode,
      controller: _messageController,
      maxLines: 4,
      labelText:
          '${AppLocalization.of(context)!.sendMessageHeader} (${_messageController!.text.length}/200)',
      onChanged: (String text) {
        setState(() {});
      },
      keyboardType: TextInputType.text,
      textAlign: TextAlign.left,
      style: AppStyles.textStyleSize16W600Primary(context),
      inputFormatters: <TextInputFormatter>[
        LengthLimitingTextInputFormatter(200),
      ],
    );
  }

  AppTextField getEnterAddressContainer() {
    return AppTextField(
        padding: _addressValidAndUnfocused
            ? const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0)
            : EdgeInsets.zero,
        textAlign: TextAlign.center,
        focusNode: _sendAddressFocusNode,
        controller: _sendAddressController,
        cursorColor: StateContainer.of(context).curTheme.text,
        inputFormatters: <LengthLimitingTextInputFormatter>[
          if (_isContact)
            LengthLimitingTextInputFormatter(20)
          else
            LengthLimitingTextInputFormatter(68),
        ],
        textInputAction: TextInputAction.done,
        maxLines: null,
        autocorrect: false,
        labelText: AppLocalization.of(context)!.enterAddress,
        prefixButton: TextFieldButton(
          icon: FontAwesomeIcons.at,
          onPressed: () async {
            sl.get<HapticUtil>().feedback(FeedbackType.light,
                StateContainer.of(context).activeVibrations);

            Contact? contact = await ContactsDialog.getDialog(context);
            if (contact != null && contact.name != null) {
              _sendAddressController!.text = contact.name!;
              _sendAddressStyle = AddressStyle.text90;
              double fee = await getFee();
              setState(() {
                feeEstimation = fee;
              });
            }
          },
        ),
        fadePrefixOnCondition: true,
        prefixShowFirstCondition: true,
        suffixButton: TextFieldButton(
          icon: FontAwesomeIcons.qrcode,
          onPressed: () async {
            if (!_qrCodeButtonVisible) {
              return;
            }
            sl.get<HapticUtil>().feedback(FeedbackType.light,
                StateContainer.of(context).activeVibrations);
            UIUtil.cancelLockEvent();
            final String? scanResult =
                await UserDataUtil.getQRData(DataType.address, context);
            QRScanErrs.errorList;
            if (scanResult == null) {
              UIUtil.showSnackbar(
                  AppLocalization.of(context)!.qrInvalidAddress,
                  context,
                  StateContainer.of(context).curTheme.text!,
                  StateContainer.of(context).curTheme.snackBarShadow!);
            } else if (QRScanErrs.errorList.contains(scanResult)) {
              UIUtil.showSnackbar(
                  scanResult,
                  context,
                  StateContainer.of(context).curTheme.text!,
                  StateContainer.of(context).curTheme.snackBarShadow!);
              return;
            } else {
              // Is a URI
              final Address address = Address(scanResult);
              // See if this address belongs to a contact
              final Contact? contact;

              contact = await sl
                  .get<DBHelper>()
                  .getContactWithAddress(address.address);

              if (contact != null) {
                setState(() {
                  _isContact = true;
                  _addressValidationText = '';
                  _sendAddressStyle = AddressStyle.primary;
                  _qrCodeButtonVisible = false;
                });
                if (contact.name != null) {
                  _sendAddressController!.text = contact.name!;
                }
              } else {
                setState(() {
                  _isContact = false;
                  _addressValidationText = '';
                  _sendAddressStyle = AddressStyle.text90;
                  _qrCodeButtonVisible = false;
                });
                _sendAddressController!.text = address.address;
                _sendAddressFocusNode!.unfocus();
                setState(() {
                  _addressValidAndUnfocused = true;
                });
              }
            }
          },
        ),
        fadeSuffixOnCondition: true,
        suffixShowFirstCondition: _qrCodeButtonVisible,
        style: _sendAddressStyle == AddressStyle.text60
            ? AppStyles.textStyleSize14W700Text60(context)
            : _sendAddressStyle == AddressStyle.text90
                ? AppStyles.textStyleSize14W700Primary(context)
                : AppStyles.textStyleSize14W700Primary(context),
        onChanged: (String text) async {
          double fee = await getFee();
          if (text.isNotEmpty) {
            setState(() {
              feeEstimation = fee;
            });
          } else {
            setState(() {
              feeEstimation = fee;
            });
          }
          final bool isContact = text.startsWith('@');
          // Switch to contact mode if starts with @
          if (isContact) {
            setState(() {
              _isContact = true;
            });
            sl
                .get<DBHelper>()
                .getContactsWithNameLike(text)
                .then((List<Contact> matchedList) {});
          } else {
            setState(() {
              _isContact = false;
            });
          }
          // Always reset the error message to be less annoying
          setState(() {
            _addressValidationText = '';
          });
          if (!isContact && Address(text).isValid()) {
            //_sendAddressFocusNode.unfocus();
            setState(() {
              _sendAddressStyle = AddressStyle.text90;
              _addressValidationText = '';
              _qrCodeButtonVisible = true;
            });
          } else if (!isContact) {
            setState(() {
              _sendAddressStyle = AddressStyle.text60;
              _qrCodeButtonVisible = true;
            });
          } else {
            try {
              await sl.get<DBHelper>().getContactWithName(text);
              setState(() {
                _qrCodeButtonVisible = false;
                _addressValidationText = '';
                _sendAddressStyle = AddressStyle.primary;
              });
            } on Exception {
              setState(() {
                _sendAddressStyle = AddressStyle.text60;
              });
            }
          }
        },
        overrideTextFieldWidget: _addressValidAndUnfocused
            ? GestureDetector(
                onTap: () {
                  setState(() {
                    _addressValidAndUnfocused = false;
                    _addressValidationText = '';
                  });
                  Future<void>.delayed(const Duration(milliseconds: 50), () {
                    FocusScope.of(context).requestFocus(_sendAddressFocusNode);
                  });
                },
                child: UIUtil.threeLinetextStyleSmallestW400Text(
                    context, _sendAddressController!.text))
            : null);
  }

  Future<double> getFee({maxSend = false}) async {
    double fee = 0;
    if (double.tryParse(_sendAmountController!.text) == null) {
      return fee;
    }
    final bool isContact = _sendAddressController!.text.startsWith('@');
    String recipientAddress = '';
    if (_sendAddressController!.text.isEmpty ||
        (!isContact && !isHex(_sendAddressController!.text))) {
      return fee;
    } else {
      if (isContact) {
        try {
          Contact? contact = await sl
              .get<DBHelper>()
              .getContactWithName(_sendAddressController!.text);
          if (contact.address != null) {
            recipientAddress = contact.address!;
          } else {
            return fee;
          }
        } catch (e) {
          return fee;
        }
      } else {
        recipientAddress = _sendAddressController!.text.trim();
      }
    }
    try {
      final String? transactionChainSeed =
          await StateContainer.of(context).getSeed();
      List<UCOTransferWallet> ucoTransferListForFee =
          List<UCOTransferWallet>.empty(growable: true);
      ucoTransferListForFee.add(UCOTransferWallet(
          amount: maxSend
              ? BigInt.from(StateContainer.of(context)
                      .appWallet!
                      .appKeychain!
                      .getAccountSelected()!
                      .balance!
                      .nativeTokenValue! *
                  100000000)
              : BigInt.from(
                  double.tryParse(_sendAmountController!.text)! * 100000000),
          to: recipientAddress));
      final String originPrivateKey = sl.get<ApiService>().getOriginKey();
      fee = await sl.get<AppService>().getFeesEstimationUCO(
          originPrivateKey,
          transactionChainSeed!,
          StateContainer.of(context)
              .appWallet!
              .appKeychain!
              .getAccountSelected()!
              .lastAddress!,
          ucoTransferListForFee,
          _messageController!.text);
    } catch (e) {
      fee = 0;
    }
    return fee;
  }

  String _convertSelectedCurrencyToNetworkCurrency() {
    String convertedAmt = _sendAmountController!.text.replaceAll(",", ".");
    convertedAmt = NumberUtil.sanitizeNumber(convertedAmt);
    if (convertedAmt.isEmpty || double.tryParse(convertedAmt) == 0) {
      return '';
    }
    priceConverted = (Decimal.parse(convertedAmt) /
            Decimal.parse(StateContainer.of(context)
                .appWallet!
                .appKeychain!
                .getAccountSelected()!
                .balance!
                .tokenPrice!
                .amount!
                .toString()))
        .toDouble();
    return '${priceConverted.toStringAsFixed(8)} ${StateContainer.of(context).curNetwork.getNetworkCryptoCurrencyLabel()}';
  }

  String _convertNetworkCurrencyToSelectedCurrency() {
    String convertedAmt = NumberUtil.sanitizeNumber(_sendAmountController!.text,
        maxDecimalDigits: _localCurrencyFormat!.decimalDigits!);
    if (convertedAmt.isEmpty) {
      return '';
    }
    priceConverted = (Decimal.parse(StateContainer.of(context)
                .appWallet!
                .appKeychain!
                .getAccountSelected()!
                .balance!
                .tokenPrice!
                .amount!
                .toString()) *
            Decimal.parse(convertedAmt))
        .toDouble();
    return _localCurrencyFormat!.format(priceConverted);
  }
}
