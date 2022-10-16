// Project imports:
import 'dart:io';

import 'package:aewallet/application/currency.dart';
import 'package:aewallet/application/primary_currency.dart';
import 'package:aewallet/application/settings.dart';
import 'package:aewallet/application/theme.dart';
import 'package:aewallet/appstate_container.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/model/address.dart';
import 'package:aewallet/model/data/account.dart';
import 'package:aewallet/model/data/account_token.dart';
import 'package:aewallet/model/data/appdb.dart';
import 'package:aewallet/model/data/contact.dart';
import 'package:aewallet/model/primary_currency.dart';
import 'package:aewallet/model/token_transfer_wallet.dart';
import 'package:aewallet/model/uco_transfer_wallet.dart';
import 'package:aewallet/ui/util/dimens.dart';
import 'package:aewallet/ui/util/formatters.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/util/ui_util.dart';
import 'package:aewallet/ui/views/uco_transfer/bloc/provider.dart';
import 'package:aewallet/ui/views/uco_transfer/layout/transfer_confirm_sheet.dart';
import 'package:aewallet/ui/widgets/balance/balance_indicator.dart';
import 'package:aewallet/ui/widgets/components/app_button.dart';
import 'package:aewallet/ui/widgets/components/app_text_field.dart';
import 'package:aewallet/ui/widgets/components/network_indicator.dart';
import 'package:aewallet/ui/widgets/components/sheet_header.dart';
import 'package:aewallet/ui/widgets/components/sheet_util.dart';
import 'package:aewallet/ui/widgets/components/tap_outside_unfocus.dart';
import 'package:aewallet/ui/widgets/dialogs/contacts_dialog.dart';
import 'package:aewallet/util/currency_util.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/haptic_util.dart';
import 'package:aewallet/util/number_util.dart';
import 'package:aewallet/util/user_data_util.dart';
// Package imports:
// Package imports:
import 'package:auto_size_text/auto_size_text.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/foundation.dart';
// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

part 'components/transfer_textfield_address.dart';
part 'components/transfer_textfield_amount.dart';
part 'components/transfer_textfield_message.dart';

enum AddressStyle { text60, text90, primary }

class TransferSheet extends ConsumerWidget {
  const TransferSheet({
    required this.seed,
    this.contact,
    this.address,
    this.title,
    this.actionButtonTitle,
    this.accountToken,
    super.key,
  });

  final Contact? contact;
  final String? address;
  final String? title;
  final String? actionButtonTitle;
  final AccountToken? accountToken;
  final String seed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const _amountValidationText = '';
    const _addressValidationText = '';
    const _messageValidationText = '';
    const validRequest = true;
    bool? _isPressed;

    final ucoTransferList = List<UCOTransferWallet>.empty(growable: true);

    final tokenTransferList = List<TokenTransferWallet>.empty(growable: true);

    final localizations = AppLocalization.of(context)!;
    final bottom = MediaQuery.of(context).viewInsets.bottom;
    final accountSelected = StateContainer.of(context)
        .appWallet!
        .appKeychain!
        .getAccountSelected()!;
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final currency = ref.watch(CurrencyProviders.selectedCurrency);
    final transfer = ref.watch(TransferProvider.transfer);
    // The main column that holds everything
    return TapOutsideUnfocus(
      child: SafeArea(
        minimum:
            EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.035),
        child: Column(
          children: <Widget>[
            SheetHeader(
              title: title ?? localizations.send,
              widgetBeforeTitle: const NetworkIndicator(),
              widgetAfterTitle: const BalanceIndicatorWidget(),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(bottom: 10),
                child: Stack(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        //  sendAddressFocusNode!.unfocus();
                        //  sendAmountFocusNode!.unfocus();
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
                                if (accountToken == null ||
                                    (accountToken != null &&
                                        accountToken!.tokenInformations !=
                                            null &&
                                        accountToken!.tokenInformations!.type ==
                                            'fungible'))
                                  TransferTextFieldAmount(
                                    accountSelected: accountSelected,
                                  ),
                                Container(
                                  alignment: AlignmentDirectional.center,
                                  margin: const EdgeInsets.only(top: 3),
                                  child: Text(
                                    _amountValidationText,
                                    style: theme.textStyleSize14W600Primary,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                Container(
                                  alignment: Alignment.topCenter,
                                  child: TransferTextFieldAddress(
                                    seed: seed,
                                    accountSelected: accountSelected,
                                  ),
                                ),
                                Container(
                                  alignment: AlignmentDirectional.center,
                                  margin: const EdgeInsets.only(
                                    left: 50,
                                    right: 40,
                                    top: 3,
                                  ),
                                  child: Text(
                                    _addressValidationText,
                                    style: theme.textStyleSize14W600Primary,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 30,
                                  ),
                                  child: transfer.feeEstimation > 0
                                      ? Text(
                                          '+ ${localizations.estimatedFees}: ${transfer.feeEstimation} ${StateContainer.of(context).curNetwork.getNetworkCryptoCurrencyLabel()}',
                                          style:
                                              theme.textStyleSize14W100Primary,
                                        )
                                      : Text(
                                          localizations.estimatedFeesNote,
                                          style:
                                              theme.textStyleSize14W100Primary,
                                        ),
                                ),
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 30,
                                  ),
                                  child: transfer.feeEstimation > 0
                                      ? Text(
                                          '(${CurrencyUtil.convertAmountFormatedWithNumberOfDigits(currency.currency.name, accountSelected.balance!.tokenPrice!.amount!, transfer.feeEstimation, 8)})',
                                          style:
                                              theme.textStyleSize14W100Primary,
                                        )
                                      : const SizedBox(),
                                ),
                                const SizedBox(height: 10),
                                TransferTextFieldMessage(
                                  accountSelected: accountSelected,
                                ),
                                Container(
                                  alignment: AlignmentDirectional.center,
                                  margin: const EdgeInsets.only(
                                    left: 50,
                                    right: 40,
                                    top: 3,
                                  ),
                                  child: Text(
                                    _messageValidationText,
                                    style: theme.textStyleSize14W600Primary,
                                  ),
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
            Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    if (_isPressed == true)
                      AppButton(
                        AppButtonType.primaryOutline,
                        actionButtonTitle ?? localizations.send,
                        Dimens.buttonTopDimens,
                        key: const Key('send'),
                        onPressed: () {},
                      )
                    else
                      AppButton(
                        AppButtonType.primary,
                        actionButtonTitle ?? localizations.send,
                        Dimens.buttonTopDimens,
                        key: const Key('send'),
                        onPressed: () async {
                          //setState(() {
                          //  _isPressed = true;
                          //});
                          //validRequest = await _validateRequest(
                          //  accountSelected,
                          //);
                          if (validRequest) {
                            Sheets.showAppHeightNineSheet(
                              onDisposed: () {
                                //    if (mounted) {
                                //      setState(() {
                                //        _isPressed = false;
                                //      });
                                //    }
                              },
                              context: context,
                              ref: ref,
                              widget: TransferConfirmSheet(
                                lastAddress: accountSelected.lastAddress,
                                ucoTransferList: ucoTransferList,
                                tokenTransferList: tokenTransferList,
                                title: title,
                                typeTransfer:
                                    accountToken == null ? 'UCO' : 'TOKEN',
                                feeEstimation: transfer.feeEstimation,
                                message: transfer.message,
                                symbol: accountToken == null
                                    ? null
                                    : accountToken!.tokenInformations!.symbol!,
                              ),
                            );
                          } else {
                            // setState(() {
                            //   _isPressed = false;
                            //  });
                          }
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
/*
  /// Validate form data to see if valid
  /// @returns true if valid, false otherwise
  Future<bool> _validateRequest(Account accountSelected) async {
    final localizations = AppLocalization.of(context)!;
    var isValid = true;
    final ucoTransfer = UCOTransferWallet();
    final tokenTransfer = TokenTransferWallet();
    setState(() {
      _sendAmountFocusNode!.unfocus();
      _sendAddressFocusNode!.unfocus();
      _addressValidationText = '';
      _messageValidationText = '';
      _amountValidationText = '';
    });
    // Validate amount
    if (_sendAmountController!.text.trim().isEmpty) {
      isValid = false;
      setState(() {
        _amountValidationText = localizations.amountMissing;
      });
    } else {
      if (double.tryParse(_sendAmountController!.text)! <= 0) {
        isValid = false;
        setState(() {
          _amountValidationText = localizations.amountZero;
        });
      } else {
        // Estimation of fees
        feeEstimation = await getFee(accountSelected);

        final amount = _rawAmount == null
            ? _sendAmountController!.text
            : NumberUtil.getRawAsUsableString(_rawAmount!);
        var balanceRaw = 0.0;
        var sendAmount = 0.0;
        if (widget.accountToken == null) {
          balanceRaw = accountSelected.balance!.nativeTokenValue!;

          if (primaryCurrencySelected == PrimaryCurrency.native) {
            sendAmount = double.tryParse(amount)!;
          } else {
            sendAmount = priceConverted;
          }
          if (sendAmount + feeEstimation > balanceRaw) {
            isValid = false;
            setState(() {
              _amountValidationText =
                  localizations.insufficientBalance.replaceAll(
                '%1',
                StateContainer.of(context)
                    .curNetwork
                    .getNetworkCryptoCurrencyLabel(),
              );
            });
          } else {
            ucoTransfer.amount = toBigInt(sendAmount);
          }
        } else {
          balanceRaw = widget.accountToken!.amount!;
          sendAmount = double.tryParse(amount)!;
          if (sendAmount > balanceRaw) {
            isValid = false;
            setState(() {
              _amountValidationText =
                  localizations.insufficientBalance.replaceAll(
                '%1',
                widget.accountToken!.tokenInformations!.symbol!,
              );
            });
          } else {
            if (feeEstimation > accountSelected.balance!.nativeTokenValue!) {
              isValid = false;
              setState(() {
                _amountValidationText =
                    localizations.insufficientBalance.replaceAll(
                  '%1',
                  StateContainer.of(context)
                      .curNetwork
                      .getNetworkCryptoCurrencyLabel(),
                );
              });
            } else {
              tokenTransfer.amount = toBigInt(sendAmount);
            }
          }
        }
      }
    }
    // Validate address
    final isContact = _sendAddressController!.text.startsWith('@');
    Contact? contact;
    if (_sendAddressController!.text.trim().isEmpty) {
      isValid = false;
      setState(() {
        _addressValidationText = localizations.addressMissing;
        _qrCodeButtonVisible = true;
      });
    } else if (!isContact && !Address(_sendAddressController!.text).isValid()) {
      isValid = false;
      setState(() {
        _addressValidationText = localizations.invalidAddress;
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
          _addressValidationText = localizations.contactInvalid;
          _qrCodeButtonVisible = true;
        });
      }
    }

    if (isValid) {
      ucoTransferList.clear();
      tokenTransferList.clear();

      var lastAddressRecipient = '';
      if (widget.accountToken == null) {
        if (contact != null) {
          ucoTransfer.toContactName = contact.name;
          ucoTransfer.to = contact.address;
        } else {
          ucoTransfer.to = _sendAddressController!.text.trim();
        }

        lastAddressRecipient = await sl
            .get<AddressService>()
            .lastAddressFromAddress(ucoTransfer.to!);
        if (lastAddressRecipient == '') {
          lastAddressRecipient = ucoTransfer.to!;
        }
      } else {
        if (contact != null) {
          tokenTransfer.toContactName = contact.name;
          tokenTransfer.to = contact.address;
        } else {
          tokenTransfer.to = _sendAddressController!.text.trim();
        }
        //
        lastAddressRecipient = await sl
            .get<AddressService>()
            .lastAddressFromAddress(tokenTransfer.to!);
        if (lastAddressRecipient == '') {
          lastAddressRecipient = tokenTransfer.to!;
        }
      }

      if (lastAddressRecipient == accountSelected.lastAddress!) {
        isValid = false;
        if (widget.accountToken == null) {
          _addressValidationText = localizations.sendToMeError.replaceAll(
            '%1',
            StateContainer.of(context)
                .curNetwork
                .getNetworkCryptoCurrencyLabel(),
          );
        } else {
          _addressValidationText = localizations.sendToMeError.replaceAll(
            '%1',
            widget.accountToken!.tokenInformations!.symbol!,
          );
        }
        setState(() {
          _qrCodeButtonVisible = true;
        });
      } else {
        if (widget.accountToken == null) {
          ucoTransferList.add(ucoTransfer);
        } else {
          tokenTransfer.tokenAddress =
              widget.accountToken!.tokenInformations!.address;
          // TODO(redDwarf03): Warning about collection
          if (widget.accountToken!.tokenInformations!.type == 'fungible') {
            tokenTransfer.tokenId = 0;
          } else {
            tokenTransfer.tokenId = 1;
          }

          tokenTransferList.add(tokenTransfer);
        }
      }
    }
    return isValid;
  }*/
}
