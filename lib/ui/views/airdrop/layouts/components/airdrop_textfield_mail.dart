import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/views/airdrop/bloc/provider.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AirdropTextFieldMail extends ConsumerStatefulWidget {
  const AirdropTextFieldMail({
    super.key,
  });

  @override
  ConsumerState<AirdropTextFieldMail> createState() =>
      _AirdropTextFieldMailState();
}

class _AirdropTextFieldMailState extends ConsumerState<AirdropTextFieldMail> {
  late TextEditingController mailController;
  late FocusNode mailFocusNode;

  @override
  void initState() {
    super.initState();
    final airdropForm = ref.read(airdropFormNotifierProvider);
    mailFocusNode = FocusNode();
    mailController = TextEditingController(text: airdropForm.mailAddress ?? '');
  }

  @override
  void dispose() {
    mailFocusNode.dispose();
    mailController.dispose();
    super.dispose();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final airdropForm = ref.watch(airdropFormNotifierProvider.notifier);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: Text(
            AppLocalizations.of(context)!
                .airdropParticipateStepWaitlistInputField,
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
                            controller: mailController,
                            onChanged: airdropForm.setMailAddress,
                            focusNode: mailFocusNode,
                            textInputAction: TextInputAction.next,
                            inputFormatters: [
                              aedappfm.LowerCaseTextFormatter(),
                            ],
                            keyboardType: TextInputType.text,
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
}
