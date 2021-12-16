// Flutter imports:
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:archethic_mobile_wallet/ui/util/ui_util.dart';
import 'package:archethic_mobile_wallet/ui/widgets/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:nfc_manager/nfc_manager.dart';

// Package imports:
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/services.dart';

// Project imports:
import 'package:archethic_mobile_wallet/appstate_container.dart';
import 'package:archethic_mobile_wallet/localization.dart';
import 'package:archethic_mobile_wallet/service_locator.dart';
import 'package:archethic_mobile_wallet/styles.dart';
import 'package:archethic_mobile_wallet/ui/widgets/icon_widget.dart';
import 'package:archethic_mobile_wallet/util/sharedprefsutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class YubikeyScreen extends StatefulWidget {
  const YubikeyScreen({this.yubikeyScreenBackgroundColor});

  final Color? yubikeyScreenBackgroundColor;

  @override
  _YubikeyScreenState createState() => _YubikeyScreenState();
}

class _YubikeyScreenState extends State<YubikeyScreen>
    with SingleTickerProviderStateMixin {
  static const int MAX_ATTEMPTS = 5;

  double buttonSize = 100.0;

  int _failedAttempts = 0;

  FocusNode? enterOTPFocusNode;
  TextEditingController? enterOTPController;

  ValueNotifier<dynamic> result = ValueNotifier(null);

  @override
  void initState() {
    super.initState();

    this.enterOTPFocusNode = FocusNode();
    this.enterOTPController = TextEditingController();

    // Get adjusted failed attempts
    sl.get<SharedPrefsUtil>().getLockAttempts().then((int attempts) {
      setState(() {
        _failedAttempts = attempts % MAX_ATTEMPTS;
      });
    });

    NfcManager.instance.startSession(
      onDiscovered: (NfcTag tag) async {
        result.value = tag.data;
        enterOTPController!.text = result.value;
        NfcManager.instance.stopSession();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: <Color>[
              StateContainer.of(context).curTheme.backgroundDark!,
              StateContainer.of(context).curTheme.background!
            ],
          ),
        ),
        child: Material(
          color: Colors.transparent,
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.1),
                child: Column(
                  children: <Widget>[
                    buildIconWidget(
                        context, 'assets/icons/key-ring.png', 90, 90),
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 40),
                      child: AutoSizeText(
                        'OTP',
                        style: AppStyles.textStyleSize16W400Primary(context),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        stepGranularity: 0.1,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 10),
                      child: AutoSizeText(
                        'Please, connect your Yubikey',
                        style: AppStyles.textStyleSize16W200Primary(context),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        stepGranularity: 0.1,
                      ),
                    ),
                    AppTextField(
                      topMargin: 30,
                      maxLines: 3,
                      padding: EdgeInsetsDirectional.only(start: 16, end: 16),
                      focusNode: enterOTPFocusNode,
                      controller: enterOTPController,
                      textInputAction: TextInputAction.go,
                      autofocus: true,
                      onSubmitted: (value) async {
                        FocusScope.of(context).unfocus();
                      },
                      onChanged: (value) async {
                        if (value.trim().length == 44) {
                          await send();
                        }
                      },
                      inputFormatters: <LengthLimitingTextInputFormatter>[
                        LengthLimitingTextInputFormatter(45),
                      ],
                      keyboardType: TextInputType.text,
                      obscureText: false,
                      textAlign: TextAlign.center,
                      style: AppStyles.textStyleSize16W600Primary(context),
                      suffixButton: TextFieldButton(
                        icon: FontAwesomeIcons.paste,
                        onPressed: () {
                          Clipboard.getData('text/plain')
                              .then((ClipboardData? data) async {
                            if (data == null || data.text == null) {
                              return;
                            }
                            enterOTPController!.text = data.text!;
                            await send();
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> send() async {
    String responseStatus = await YubicoService().verifyYubiCloudOTP(
        enterOTPController!.text, 'oxz9OVJdNgodAcgWL7QG5BXkqh4=', '70258');
    if (responseStatus != 'OK') {
      await sl.get<SharedPrefsUtil>().incrementLockAttempts();
      _failedAttempts = await sl.get<SharedPrefsUtil>().getLockAttempts();
      if (_failedAttempts >= MAX_ATTEMPTS) {
        await sl.get<SharedPrefsUtil>().updateLockDate();
        Navigator.of(context).pushNamedAndRemoveUntil(
            '/lock_screen_transition', (Route<dynamic> route) => false);
      } else {
        switch (responseStatus) {
          case 'BAD_OTP':
            UIUtil.showSnackbar(
                AppLocalization.of(context)!.yubikeyError_BAD_OTP, context);
            break;
          case 'BACKEND_ERROR':
            UIUtil.showSnackbar(
                AppLocalization.of(context)!.yubikeyError_BACKEND_ERROR,
                context);
            break;
          case 'BAD_SIGNATURE':
            UIUtil.showSnackbar(
                AppLocalization.of(context)!.yubikeyError_BAD_SIGNATURE,
                context);
            break;
          case 'MISSING_PARAMETER':
            UIUtil.showSnackbar(
                AppLocalization.of(context)!.yubikeyError_MISSING_PARAMETER,
                context);
            break;
          case 'NOT_ENOUGH_ANSWERS':
            UIUtil.showSnackbar(
                AppLocalization.of(context)!.yubikeyError_NOT_ENOUGH_ANSWERS,
                context);
            break;
          case 'NO_SUCH_CLIENT':
            UIUtil.showSnackbar(
                AppLocalization.of(context)!.yubikeyError_NO_SUCH_CLIENT,
                context);
            break;
          case 'OPERATION_NOT_ALLOWED':
            UIUtil.showSnackbar(
                AppLocalization.of(context)!.yubikeyError_OPERATION_NOT_ALLOWED,
                context);
            break;
          case 'REPLAYED_OTP':
            UIUtil.showSnackbar(
                AppLocalization.of(context)!.yubikeyError_REPLAYED_OTP,
                context);
            break;
          case 'REPLAYED_REQUEST':
            UIUtil.showSnackbar(
                AppLocalization.of(context)!.yubikeyError_REPLAYED_REQUEST,
                context);
            break;
          case 'RESPONSE_KO':
            UIUtil.showSnackbar(
                AppLocalization.of(context)!.yubikeyError_RESPONSE_KO, context);
            break;
          default:
            UIUtil.showSnackbar(
                AppLocalization.of(context)!.yubikeyError_RESPONSE_KO, context);
            break;
        }
        setState(() {});
      }
    } else {
      await sl.get<SharedPrefsUtil>().resetLockAttempts();
      Navigator.of(context).pop(true);
    }
  }
}
