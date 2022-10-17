// Project imports:
import 'package:aewallet/application/account.dart';
import 'package:aewallet/application/currency.dart';
import 'package:aewallet/application/device_abilities.dart';
import 'package:aewallet/application/primary_currency.dart';
import 'package:aewallet/application/settings.dart';
import 'package:aewallet/application/theme.dart';
import 'package:aewallet/appstate_container.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/model/address.dart';
import 'package:aewallet/model/data/account_token.dart';
import 'package:aewallet/model/data/appdb.dart';
import 'package:aewallet/model/data/contact.dart';
import 'package:aewallet/model/primary_currency.dart';
import 'package:aewallet/ui/util/amount_formatters.dart';
import 'package:aewallet/ui/util/dimens.dart';
import 'package:aewallet/ui/util/formatters.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/util/ui_util.dart';
import 'package:aewallet/ui/views/transfer/bloc/model.dart';
import 'package:aewallet/ui/views/transfer/bloc/provider.dart';
import 'package:aewallet/ui/views/transfer/layout/transfer_confirm_sheet.dart';
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

class TransferSheet extends ConsumerStatefulWidget {
  const TransferSheet({
    required this.seed,
    required this.transferType,
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
  final TransferType transferType;
  final String seed;

  @override
  ConsumerState<TransferSheet> createState() => _TransferSheetState();
}

class _TransferSheetState extends ConsumerState<TransferSheet> {
  @override
  Widget build(BuildContext context) {
    const _isPressed = false;
    final localizations = AppLocalization.of(context)!;
    final bottom = MediaQuery.of(context).viewInsets.bottom;
    final accountSelected = StateContainer.of(context)
        .appWallet!
        .appKeychain!
        .getAccountSelected()!;
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final currency = ref.watch(CurrencyProviders.selectedCurrency);
    final transfer = ref.watch(TransferProvider.transfer);
    final transferNotifier = ref.watch(TransferProvider.transfer.notifier);

    // TODO(Chralu): How to init transfer ?
    // transferNotifier.setTransferType(widget.transferType);

    // The main column that holds everything
    return TapOutsideUnfocus(
      child: SafeArea(
        minimum:
            EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.035),
        child: Column(
          children: <Widget>[
            SheetHeader(
              title: widget.title ?? localizations.send,
              widgetBeforeTitle: const NetworkIndicator(),
              widgetAfterTitle: const BalanceIndicatorWidget(),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(bottom: 10),
                child: Stack(
                  children: <Widget>[
                    SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.only(bottom: bottom + 80),
                        child: Column(
                          children: <Widget>[
                            const SizedBox(height: 25),
                            if (widget.accountToken == null ||
                                (widget.accountToken != null &&
                                    widget.accountToken!.tokenInformations !=
                                        null &&
                                    widget.accountToken!.tokenInformations!
                                            .type ==
                                        'fungible'))
                              TransferTextFieldAmount(
                                seed: widget.seed,
                              ),
                            Container(
                              padding: const EdgeInsets.only(
                                top: 20,
                                bottom: 20,
                              ),
                              alignment: Alignment.topCenter,
                              child: TransferTextFieldAddress(
                                seed: widget.seed,
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 30,
                              ),
                              child: transfer.feeEstimation > 0
                                  ? Text(
                                      '+ ${localizations.estimatedFees}: ${AmountFormatters.standardSmallValue(transfer.feeEstimation, StateContainer.of(context).curNetwork.getNetworkCryptoCurrencyLabel())}',
                                      style: theme.textStyleSize14W100Primary,
                                    )
                                  : Text(
                                      localizations.estimatedFeesNote,
                                      style: theme.textStyleSize14W100Primary,
                                    ),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 30,
                              ),
                              child: transfer.feeEstimation > 0
                                  ? Text(
                                      '(${CurrencyUtil.convertAmountFormatedWithNumberOfDigits(currency.currency.name, accountSelected.balance!.tokenPrice!.amount!, transfer.feeEstimation, 8)})',
                                      style: theme.textStyleSize14W100Primary,
                                    )
                                  : const SizedBox(),
                            ),
                            const SizedBox(height: 10),
                            TransferTextFieldMessage(
                              seed: widget.seed,
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
                        widget.actionButtonTitle ?? localizations.send,
                        Dimens.buttonTopDimens,
                        key: const Key('send'),
                        onPressed: () {},
                      )
                    else
                      AppButton(
                        AppButtonType.primary,
                        widget.actionButtonTitle ?? localizations.send,
                        Dimens.buttonTopDimens,
                        key: const Key('send'),
                        onPressed: () async {
                          final isAddressOk =
                              await transferNotifier.controlAddress(
                            context,
                            accountSelected,
                          );
                          final isAmountOk = transferNotifier.controlAmount(
                            context,
                            accountSelected,
                          );

                          if (isAddressOk == true && isAmountOk == true) {
                            Sheets.showAppHeightNineSheet(
                              onDisposed: () {},
                              context: context,
                              ref: ref,
                              widget: TransferConfirmSheet(
                                title: widget.title,
                              ),
                            );
                          } else {
                            // TODO(Chralu): How to display first time ?
                            UIUtil.showSnackbar(
                              transfer.errorAmountText +
                                  transfer.errorAddressText +
                                  transfer.errorMessageText,
                              context,
                              ref,
                              theme.text!,
                              theme.snackBarShadow!,
                              duration: const Duration(seconds: 5),
                            );
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
}
