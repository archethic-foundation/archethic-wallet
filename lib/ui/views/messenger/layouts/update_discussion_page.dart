import 'package:aewallet/application/settings/theme.dart';
import 'package:aewallet/model/data/messenger/discussion.dart';
import 'package:aewallet/ui/util/dimens.dart';
import 'package:aewallet/ui/views/messenger/bloc/providers.dart';
import 'package:aewallet/ui/widgets/components/app_button_tiny.dart';
import 'package:aewallet/ui/widgets/components/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UpdateDiscussionPage extends ConsumerStatefulWidget {
  const UpdateDiscussionPage({required this.discussion, super.key});

  final Discussion discussion;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _UpdateDiscussionPageState();
}

class _UpdateDiscussionPageState extends ConsumerState<UpdateDiscussionPage> {
  late TextEditingController nameController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    nameController.text = widget.discussion.name ?? '';

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .watch(MessengerProviders.updateDiscussionForm.notifier)
          .init(widget.discussion);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final localizations = AppLocalizations.of(context)!;

    final formNotifier =
        ref.watch(MessengerProviders.updateDiscussionForm.notifier);
    final formState = ref.watch(MessengerProviders.updateDiscussionForm);

    return DecoratedBox(
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
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(localizations.discussionModifying),
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, bottom: 30),
          child: Column(
            children: [
              AppTextField(
                labelText: localizations.name,
                onChanged: (text) {
                  formNotifier.setName(text);
                },
                controller: nameController,
              ),
              const Expanded(
                child: SizedBox(),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  AppButtonTinyConnectivity(
                    localizations.modify,
                    Dimens.buttonBottomDimens,
                    key: const Key('modifyDiscussion'),
                    onPressed: formNotifier.updateDiscussion,
                    disabled: formState.canSubmit == false,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
