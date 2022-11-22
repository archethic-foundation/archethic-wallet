/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/application/settings/theme.dart';
import 'package:aewallet/infrastructure/datasources/hive_vault.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/model/authentication_method.dart';
import 'package:aewallet/ui/util/dimens.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/views/authenticate/auth_factory.dart';
import 'package:aewallet/ui/widgets/components/app_button_tiny.dart';
import 'package:aewallet/ui/widgets/components/app_text_field.dart';
import 'package:aewallet/ui/widgets/components/icon_widget.dart';
import 'package:aewallet/ui/widgets/components/icons.dart';
import 'package:aewallet/ui/widgets/components/tap_outside_unfocus.dart';
// Package imports:
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

class SetYubikey extends ConsumerStatefulWidget {
  const SetYubikey({
    super.key,
    this.header,
    this.description,
    this.apiKey,
    this.clientID,
  });
  final String? header;
  final String? description;
  final String? apiKey;
  final String? clientID;

  @override
  ConsumerState<SetYubikey> createState() => _SetYubikeyState();
}

class _SetYubikeyState extends ConsumerState<SetYubikey> {
  FocusNode? _clientIDFocusNode;
  TextEditingController? _clientIDController;
  FocusNode? _clientAPIKeyFocusNode;
  TextEditingController? _clientAPIKeyController;
  bool? animationOpen;
  String _clientIDValidationText = '';
  String _clientAPIKeyValidationText = '';

  @override
  void initState() {
    super.initState();
    _clientAPIKeyFocusNode = FocusNode();
    _clientIDFocusNode = FocusNode();
    _clientAPIKeyController = TextEditingController();
    _clientIDController = TextEditingController();
    if (widget.apiKey != null) {
      _clientAPIKeyController!.text = widget.apiKey!;
    }
    if (widget.clientID != null) {
      _clientIDController!.text = widget.clientID!;
    }
    animationOpen = false;
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalization.of(context)!;
    final theme = ref.watch(ThemeProviders.selectedTheme);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: DecoratedBox(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              theme.background3Small!,
            ),
            fit: BoxFit.fitHeight,
          ),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: <Color>[theme.backgroundDark!, theme.background!],
          ),
        ),
        child: TapOutsideUnfocus(
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) =>
                SafeArea(
              minimum: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height * 0.035,
                top: MediaQuery.of(context).size.height * 0.075,
              ),
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Container(
                              margin:
                                  const EdgeInsetsDirectional.only(start: 15),
                              height: 50,
                              width: 50,
                              child: BackButton(
                                onPressed: () {
                                  Navigator.pop(context, false);
                                },
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (widget.header != null)
                                  Container(
                                    margin: const EdgeInsetsDirectional.only(
                                      start: 20,
                                      end: 20,
                                      top: 10,
                                    ),
                                    alignment: AlignmentDirectional.centerStart,
                                    child: AutoSizeText(
                                      widget.header!,
                                      style: theme.textStyleSize14W600Primary,
                                    ),
                                  ),
                                if (widget.description != null)
                                  Container(
                                    margin: const EdgeInsetsDirectional.only(
                                      start: 20,
                                      end: 20,
                                      top: 15,
                                    ),
                                    child: Linkify(
                                      text: widget.description!,
                                      style: theme.textStyleSize16W600Primary,
                                      textAlign: TextAlign.left,
                                      options: const LinkifyOptions(
                                        humanize: false,
                                      ),
                                      linkStyle: theme
                                          .textStyleSize16W600Primary
                                          .copyWith(
                                        decoration: TextDecoration.underline,
                                      ),
                                      onOpen: (link) async {
                                        final uri = Uri.parse(link.url);
                                        if (!await canLaunchUrl(uri)) return;

                                        await launchUrl(uri);
                                      },
                                    ),
                                  ),
                                Container(
                                  child: getClientIDContainer(),
                                ),
                                Container(
                                  alignment: AlignmentDirectional.center,
                                  margin: const EdgeInsets.only(top: 3),
                                  child: Text(
                                    _clientIDValidationText,
                                    style: theme.textStyleSize14W600Primary,
                                  ),
                                ),
                                Container(
                                  child: getClientAPIKeyContainer(),
                                ),
                                Container(
                                  alignment: AlignmentDirectional.center,
                                  margin: const EdgeInsets.only(top: 3),
                                  child: Text(
                                    _clientAPIKeyValidationText,
                                    style: theme.textStyleSize14W600Primary,
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                if (widget.description != null)
                                  Container(
                                    margin: const EdgeInsetsDirectional.only(
                                      start: 20,
                                      end: 20,
                                      top: 15,
                                    ),
                                    child: Column(
                                      children: [
                                        Align(
                                          alignment: Alignment.topLeft,
                                          child: Icon(
                                            UiIcons.about,
                                            color: theme.text,
                                            size: 20,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          widget.description!,
                                          style:
                                              theme.textStyleSize12W100Primary,
                                          textAlign: TextAlign.left,
                                        ),
                                      ],
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          // Next Button
                          AppButtonTiny(
                            AppButtonTinyType.primary,
                            localizations.confirm,
                            Dimens.buttonTopDimens,
                            key: const Key('confirm'),
                            onPressed: () async {
                              await validate();
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Column getClientIDContainer() {
    final theme = ref.watch(ThemeProviders.selectedTheme);
    return Column(
      children: <Widget>[
        AppTextField(
          topMargin: 30,
          focusNode: _clientIDFocusNode,
          controller: _clientIDController,
          cursorColor: theme.text,
          style: theme.textStyleSize16W700Primary,
          inputFormatters: <LengthLimitingTextInputFormatter>[
            LengthLimitingTextInputFormatter(10)
          ],
          onChanged: (String text) {
            setState(() {
              _clientIDValidationText = '';
            });
          },
          textInputAction: TextInputAction.next,
          maxLines: null,
          autocorrect: false,
          labelText: AppLocalization.of(context)!.enterYubikeyClientID,
          keyboardType: TextInputType.number,
          textAlign: TextAlign.left,
          onSubmitted: (String text) {
            FocusScope.of(context).unfocus();
          },
        ),
      ],
    );
  }

  Column getClientAPIKeyContainer() {
    final theme = ref.watch(ThemeProviders.selectedTheme);
    return Column(
      children: <Widget>[
        AppTextField(
          topMargin: 10,
          focusNode: _clientAPIKeyFocusNode,
          controller: _clientAPIKeyController,
          cursorColor: theme.text,
          style: theme.textStyleSize16W700Primary,
          inputFormatters: <LengthLimitingTextInputFormatter>[
            LengthLimitingTextInputFormatter(40)
          ],
          onChanged: (String text) {
            setState(() {
              _clientAPIKeyValidationText = '';
            });
          },
          textInputAction: TextInputAction.next,
          maxLines: null,
          autocorrect: false,
          labelText: AppLocalization.of(context)!.enterYubikeyClientAPIKey,
          keyboardType: TextInputType.text,
          textAlign: TextAlign.left,
          onSubmitted: (String text) {
            FocusScope.of(context).unfocus();
          },
        ),
      ],
    );
  }

  Future<void> validate() async {
    final preferences = ref.watch(SettingsProviders.settings);
    if (_clientIDController!.text.isEmpty) {
      if (mounted) {
        setState(() {
          _clientIDValidationText =
              AppLocalization.of(context)!.enterYubikeyClientIDEmpty;
        });
      }
    } else {
      if (_clientAPIKeyController!.text.isEmpty) {
        if (mounted) {
          setState(() {
            _clientAPIKeyValidationText =
                AppLocalization.of(context)!.enterYubikeyAPIKeyEmpty;
          });
        }
      } else {
        final vault = await HiveVaultDatasource.getInstance();
        vault
          ..setYubikeyClientAPIKey(_clientAPIKeyController!.text)
          ..setYubikeyClientID(_clientIDController!.text);

        final auth = await AuthFactory.authenticate(
          context,
          ref,
          authMethod:
              const AuthenticationMethod(AuthMethod.yubikeyWithYubicloud),
          activeVibrations: preferences.activeVibrations,
        );
        if (auth) {
          Navigator.of(context).pop(true);
        }
      }
    }
  }
}
