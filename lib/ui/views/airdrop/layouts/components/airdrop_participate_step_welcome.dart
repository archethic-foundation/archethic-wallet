import 'dart:math';

import 'package:aewallet/ui/figma_components/buttons/btn_primary.dart';
import 'package:aewallet/ui/figma_components/buttons/btn_textfield.dart';
import 'package:aewallet/ui/figma_components/custom_styles.dart';
import 'package:aewallet/ui/views/airdrop/bloc/provider.dart';
import 'package:aewallet/ui/views/airdrop/bloc/state.dart';
import 'package:aewallet/ui/widgets/components/scrollbar.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:url_launcher/url_launcher.dart';

class AirdropParticipateStepWelcomeSheet extends ConsumerStatefulWidget {
  const AirdropParticipateStepWelcomeSheet({super.key});

  @override
  ConsumerState<AirdropParticipateStepWelcomeSheet> createState() =>
      _AirdropParticipateStepWelcomeSheetState();
}

class _AirdropParticipateStepWelcomeSheetState
    extends ConsumerState<AirdropParticipateStepWelcomeSheet> {
  TextEditingController controller = TextEditingController(text: '');
  final FocusNode _focusNode = FocusNode();
  bool _hasFocus = false;

  @override
  void initState() {
    super.initState();

    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    controller.dispose();
    _focusNode
      ..removeListener(_onFocusChange)
      ..dispose();
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {
      _hasFocus = _focusNode.hasFocus;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ArchethicScrollbar(
        child: Padding(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top + 10,
            bottom: 120,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _header(context),
              _howToParticipate(
                context,
                ref,
              ),
              _help(
                context,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _header(
    BuildContext context,
  ) {
    final localizations = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Text(
            localizations.airdropParticipateStepWelcomeDesc1,
            style: Theme.of(context).textTheme.bodyMediumWithOpacity,
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _howToParticipate(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    return ColoredBox(
      color: Colors.white.withValues(alpha: 0.1),
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              localizations.airdropParticipateStepWelcomeHowParticipateTitle,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontSize: 20,
                    fontWeight: FontWeightTelegraf.fontWeightBold,
                  ),
            ),
            const SizedBox(height: 20),
            Text(
              localizations.airdropParticipateStepWelcomeHowParticipateDesc1,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeightTelegraf.fontWeightSemibold,
                  ),
            ),
            Text(
              localizations.airdropParticipateStepWelcomeHowParticipateDesc2,
              style: Theme.of(context).textTheme.bodyMediumWithOpacity,
            ),
            const SizedBox(height: 30),
            Text(
              localizations
                  .airdropParticipateStepWelcomeHowParticipateTextfieldTitle,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeightTelegraf.fontWeightSemibold,
                  ),
            ),
            const SizedBox(height: 10),
            Stack(
              alignment: Alignment.centerRight,
              children: [
                Stack(
                  alignment: Alignment.bottomLeft,
                  children: [
                    TextField(
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: _hasFocus ? Colors.black : null,
                            letterSpacing: 7,
                          ),
                      autocorrect: false,
                      controller: controller,
                      focusNode: _focusNode,
                      textAlign: TextAlign.left,
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        aedappfm.UpperCaseTextFormatter(),
                        LengthLimitingTextInputFormatter(
                          6,
                        ),
                      ],
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: _hasFocus
                            ? Colors.white
                            : Colors.white.withValues(alpha: 0.15),
                        border: const OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        focusColor: Colors.white,
                        contentPadding: const EdgeInsets.only(left: 10),
                      ),
                    ),
                    Positioned(
                      left: 13,
                      bottom: 8,
                      child: Text(
                        '_ _ _ _ _ _',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: _hasFocus ? Colors.black : Colors.white,
                              letterSpacing: 3,
                            ),
                      ),
                    ),
                  ],
                ),
                Positioned(
                  right: 10,
                  child: BtnTextField(
                    buttonText: const Icon(
                      Icons.paste,
                      color: Colors.white,
                      size: 16,
                    ),
                    onTap: () async {
                      final data = await Clipboard.getData(
                        'text/plain',
                      );
                      if (data != null && data.text != null) {
                        controller.text = data.text!
                            .substring(0, min(6, data.text!.length))
                            .toUpperCase();
                      }
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            BtnPrimary(
              buttonText:
                  localizations.airdropParticipateStepWelcomeHowParticipateBtn,
              onTap: () {
                ref
                    .read(airdropFormNotifierProvider.notifier)
                    .setAirdropProcessStep(
                      AirdropProcessStep.joinWaitlist,
                    );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _help(
    BuildContext context,
  ) {
    final localizations = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 40),
          Text(
            localizations.airdropParticipateStepWelcomeHelpTitle,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeightTelegraf.fontWeightSemibold,
                ),
          ),
          const SizedBox(height: 10),
          Text(
            localizations.airdropParticipateStepWelcomeHelpDesc,
            style: Theme.of(context).textTheme.bodyMediumWithOpacity,
          ),
          const SizedBox(height: 10),
          InkWell(
            onTap: () async {
              await launchUrl(
                Uri.parse(
                  'https://t.me/ArchEthic_ENG',
                ),
                mode: LaunchMode.externalApplication,
              );
            },
            child: Row(
              children: [
                Text(
                  localizations.airdropParticipateStepWelcomeHelpTGLink,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        decoration: TextDecoration.underline,
                      ),
                ),
                const SizedBox(
                  width: 8,
                ),
                const Icon(
                  Symbols.open_in_new,
                  size: 16,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
