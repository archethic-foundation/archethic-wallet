/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/infrastructure/datasources/hive_vault.dart';
import 'package:aewallet/model/authentication_method.dart';
import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/themes/styles.dart';
import 'package:aewallet/ui/util/dimens.dart';
import 'package:aewallet/ui/views/authenticate/auth_factory.dart';
import 'package:aewallet/ui/views/main/components/sheet_appbar.dart';
import 'package:aewallet/ui/widgets/components/app_button_tiny.dart';
import 'package:aewallet/ui/widgets/components/sheet_skeleton.dart';
import 'package:aewallet/ui/widgets/components/sheet_skeleton_interface.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
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

  static const routerPage = '/set_yubikey';

  @override
  ConsumerState<SetYubikey> createState() => _SetYubikeyState();
}

class _SetYubikeyState extends ConsumerState<SetYubikey>
    implements SheetSkeletonInterface {
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
    return SheetSkeleton(
      appBar: getAppBar(context, ref),
      floatingActionButton: getFloatingActionButton(context, ref),
      sheetContent: getSheetContent(context, ref),
    );
  }

  @override
  Widget getFloatingActionButton(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    return Row(
      children: <Widget>[
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
    );
  }

  @override
  PreferredSizeWidget getAppBar(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    return SheetAppBar(
      title: localizations.yubikeyWithYubiCloudMethod,
      widgetLeft: BackButton(
        key: const Key('back'),
        color: ArchethicTheme.text,
        onPressed: () {
          context.pop(false);
        },
      ),
    );
  }

  @override
  Widget getSheetContent(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.description != null)
          Container(
            margin: const EdgeInsetsDirectional.only(
              start: 20,
              end: 20,
              top: 15,
            ),
            child: Linkify(
              text: widget.description!,
              style: ArchethicThemeStyles.textStyleSize12W100Primary,
              textAlign: TextAlign.left,
              options: const LinkifyOptions(
                humanize: false,
              ),
              linkStyle:
                  ArchethicThemeStyles.textStyleSize12W100Primary.copyWith(
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
          padding: const EdgeInsets.only(
            top: 20,
            left: 20,
            right: 20,
          ),
          child: getClientIDContainer(),
        ),
        Container(
          alignment: AlignmentDirectional.center,
          margin: const EdgeInsets.only(top: 3),
          child: Text(
            _clientIDValidationText,
            style: ArchethicThemeStyles.textStyleSize14W600Primary,
          ),
        ),
        Container(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
          ),
          child: getClientAPIKeyContainer(),
        ),
        Container(
          alignment: AlignmentDirectional.center,
          margin: const EdgeInsets.only(top: 3),
          child: Text(
            _clientAPIKeyValidationText,
            style: ArchethicThemeStyles.textStyleSize14W600Primary,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }

  Widget getClientIDContainer() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: Text(
            AppLocalizations.of(context)!.enterYubikeyClientID,
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Row(
            children: [
              Expanded(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              10,
                            ),
                            border: Border.all(
                              color: Theme.of(context)
                                  .colorScheme
                                  .primaryContainer,
                              width: 0.5,
                            ),
                            gradient:
                                ArchethicTheme.gradientInputFormBackground,
                          ),
                          child: TextField(
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                            autocorrect: false,
                            controller: _clientIDController,
                            textInputAction: TextInputAction.next,
                            autofocus: true,
                            onSubmitted: (value) async {
                              FocusScope.of(context).unfocus();
                            },
                            onChanged: (value) async {
                              setState(() {
                                _clientIDValidationText = '';
                              });
                            },
                            focusNode: _clientIDFocusNode,
                            keyboardType: TextInputType.text,
                            inputFormatters: <TextInputFormatter>[
                              LengthLimitingTextInputFormatter(10),
                            ],
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(left: 10),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    )
        .animate()
        .fade(duration: const Duration(milliseconds: 200))
        .scale(duration: const Duration(milliseconds: 200));
  }

  Widget getClientAPIKeyContainer() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: Text(
            AppLocalizations.of(context)!.enterYubikeyClientAPIKey,
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Row(
            children: [
              Expanded(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              10,
                            ),
                            border: Border.all(
                              color: Theme.of(context)
                                  .colorScheme
                                  .primaryContainer,
                              width: 0.5,
                            ),
                            gradient:
                                ArchethicTheme.gradientInputFormBackground,
                          ),
                          child: TextField(
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                            autocorrect: false,
                            controller: _clientAPIKeyController,
                            textInputAction: TextInputAction.next,
                            autofocus: true,
                            onSubmitted: (value) async {
                              FocusScope.of(context).unfocus();
                            },
                            onChanged: (value) async {
                              setState(() {
                                _clientAPIKeyValidationText = '';
                              });
                            },
                            focusNode: _clientAPIKeyFocusNode,
                            keyboardType: TextInputType.text,
                            inputFormatters: <TextInputFormatter>[
                              LengthLimitingTextInputFormatter(40),
                            ],
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(left: 10),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    )
        .animate()
        .fade(duration: const Duration(milliseconds: 200))
        .scale(duration: const Duration(milliseconds: 200));
  }

  Future<void> validate() async {
    final preferences = ref.watch(SettingsProviders.settings);
    if (_clientIDController!.text.isEmpty) {
      if (mounted) {
        setState(() {
          _clientIDValidationText =
              AppLocalizations.of(context)!.enterYubikeyClientIDEmpty;
        });
      }
    } else {
      if (_clientAPIKeyController!.text.isEmpty) {
        if (mounted) {
          setState(() {
            _clientAPIKeyValidationText =
                AppLocalizations.of(context)!.enterYubikeyAPIKeyEmpty;
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
          context.pop(true);
        }
      }
    }
  }
}
