// @dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:uniris_mobile_wallet/appstate_container.dart';
import 'package:uniris_mobile_wallet/styles.dart';

class QRcodeDisplay {
  static Widget buildQRCodeDisplay(
      BuildContext context, Animation<double> _opacityAnimation) {
    return StateContainer.of(context).selectedAccount == null ||
            StateContainer.of(context).selectedAccount.address == null
        ? SizedBox()
        : Stack(
            children: <Widget>[
              AspectRatio(
                aspectRatio: 1.70,
                child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width - 185,
                  decoration: BoxDecoration(
                    color: StateContainer.of(context).curTheme.background,
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    boxShadow: [
                      BoxShadow(
                        color: StateContainer.of(context)
                            .curTheme
                            .backgroundDarkest,
                        blurRadius: 5.0,
                        spreadRadius: 0.0,
                        offset:
                            Offset(5.0, 5.0), // shadow direction: bottom right
                      )
                    ],
                  ),
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            QrImage(
                              data: StateContainer.of(context)
                                  .selectedAccount
                                  .address,
                              version: QrVersions.auto,
                              size: 100.0,
                            ),
                            
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                child: Padding(
                  padding: const EdgeInsets.only(left: 5.0, top: 5.0),
                  child: Text(
                    'Address informations',
                    style: AppStyles.textStyleTransactionUnit(context),
                  ),
                ),
              ),
              
            ],
          );
  }

static Widget buildAddressDisplay(
      BuildContext context, Animation<double> _opacityAnimation) {
    return StateContainer.of(context).selectedAccount == null ||
            StateContainer.of(context).selectedAccount.address == null
        ? SizedBox()
        : Stack(
            children: <Widget>[
              AspectRatio(
                aspectRatio: 1.70,
                child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width - 185,
                  decoration: BoxDecoration(
                    color: StateContainer.of(context).curTheme.background,
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    boxShadow: [
                      BoxShadow(
                        color: StateContainer.of(context)
                            .curTheme
                            .backgroundDarkest,
                        blurRadius: 5.0,
                        spreadRadius: 0.0,
                        offset:
                            Offset(5.0, 5.0), // shadow direction: bottom right
                      )
                    ],
                  ),
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                Text(
                                    StateContainer.of(context)
                                        .selectedAccount
                                        .address
                                        .substring(0, 16),
                                    style: AppStyles.textStyleAddressText90(context)),
                                Text(
                                    StateContainer.of(context)
                                        .selectedAccount
                                        .address
                                        .substring(16, 32),
                                    style: AppStyles.textStyleAddressText90(context)),
                                Text(
                                    StateContainer.of(context)
                                        .selectedAccount
                                        .address
                                        .substring(32, 48),
                                    style: AppStyles.textStyleAddressText90(context)),
                                Text(
                                    StateContainer.of(context)
                                        .selectedAccount
                                        .address
                                        .substring(48, 64),
                                    style: AppStyles.textStyleAddressText90(context)),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                child: Padding(
                  padding: const EdgeInsets.only(left: 5.0, top: 5.0),
                  child: Text(
                    'Address informations',
                    style: AppStyles.textStyleTransactionUnit(context),
                  ),
                ),
              ),
              SizedBox(
                child: Padding(
                  padding: const EdgeInsets.only(left: 165.0, top: 90.0),
                  child: Container(
                    height: 36,
                    width: 36,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: TextButton(
                      onPressed: () {
                        Clipboard.setData(new ClipboardData(
                            text: StateContainer.of(context).wallet.address));
                      },
                      child: Icon(Icons.content_copy,
                          color: StateContainer.of(context).curTheme.primary),
                    ),
                  ),
                ),
              ),
            ],
          );
  }
}
