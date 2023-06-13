import 'package:aewallet/application/contact.dart';
import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/application/settings/theme.dart';
import 'package:aewallet/model/data/messenger/message.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/util/ui_util.dart';
import 'package:aewallet/ui/views/main/messenger_tab/bloc/providers.dart';
import 'package:aewallet/ui/widgets/fees/fee_infos.dart';
import 'package:aewallet/util/date_util.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/haptic_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';

class MessengerTalkPage extends ConsumerWidget {
  const MessengerTalkPage({
    super.key,
    required this.talkAddress,
  });

  final String talkAddress;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(ThemeProviders.selectedTheme);

    final talk = ref.watch(MessengerProviders.talk(talkAddress));
    final localizations = AppLocalizations.of(context)!;
    final preferences = ref.watch(SettingsProviders.settings);
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
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: talk.maybeMap(
            data: (data) {
              return InkWell(
                onTap: () {
                  sl.get<HapticUtil>().feedback(
                        FeedbackType.light,
                        preferences.activeVibrations,
                      );
                  Clipboard.setData(
                    ClipboardData(
                      text: data.value.address.toUpperCase(),
                    ),
                  );
                  UIUtil.showSnackbar(
                    localizations.addressCopied,
                    context,
                    ref,
                    theme.text!,
                    theme.snackBarShadow!,
                  );
                },
                child: Text(data.value.name),
              );
            },
            orElse: () => const Text('           ')
                .animate(
                  onComplete: (controller) =>
                      controller.repeat(period: 1.seconds),
                )
                .shimmer(),
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: _MessagesList(
                talkAddress: talkAddress,
              ),
            ),
            _MessageSendForm(
              talkAddress: talkAddress,
            ),
          ],
        ),
      ),
    );
  }
}

class _MessageSendForm extends ConsumerStatefulWidget {
  const _MessageSendForm({
    required this.talkAddress,
  });

  final String talkAddress;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      __MessageSendFormState();
}

class __MessageSendFormState extends ConsumerState<_MessageSendForm> {
  late TextEditingController textEditingController;

  @override
  void initState() {
    textEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final isCreating = ref.watch(
      MessengerProviders.messageCreationForm(widget.talkAddress)
          .select((value) => value.isCreating),
    );

    return Padding(
      padding: const EdgeInsets.only(left: 16, bottom: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: textEditingController,
                  onChanged: (value) => ref
                      .read(
                        MessengerProviders.messageCreationForm(
                          widget.talkAddress,
                        ).notifier,
                      )
                      .setText(value),
                ),
              ),
              if (isCreating)
                SizedBox(
                  width: 55,
                  height: 20,
                  child: Center(
                    child: SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        color: theme.text,
                      ),
                    ),
                  ),
                )
              else
                TextButton.icon(
                  onPressed: () async {
                    await ref
                        .read(
                          MessengerProviders.messageCreationForm(
                            widget.talkAddress,
                          ).notifier,
                        )
                        .createMessage();

                    textEditingController.text = ref
                        .read(
                          MessengerProviders.messageCreationForm(
                            widget.talkAddress,
                          ),
                        )
                        .text;
                  },
                  icon: Icon(
                    Icons.send,
                    color: theme.text,
                  ),
                  label: Container(),
                ),
            ],
          ),
          const SizedBox(height: 6),
          _MessageCreationFormFees(talkAddress: widget.talkAddress),
        ],
      ),
    );
  }
}

class _MessageCreationFormFees extends ConsumerWidget {
  const _MessageCreationFormFees({
    required this.talkAddress,
  });

  final String talkAddress;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    final text =
        ref.watch(MessengerProviders.messageCreationForm(talkAddress)).text;
    return FeeInfos(
      asyncFeeEstimation: ref.watch(
        MessengerProviders.messageCreationFees(
          talkAddress,
          text,
        ),
      ),
      estimatedFeesNote: localizations.estimatedFeesNote,
    );
  }
}

class _MessagesList extends ConsumerWidget {
  const _MessagesList({
    required this.talkAddress,
  });

  final String talkAddress;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final me = ref.watch(ContactProviders.getSelectedContact).valueOrNull;

    if (me == null) return Container();

    final talkMessages = ref
        .watch(
          MessengerProviders.messages(talkAddress),
        )
        .valueOrNull;

    if (talkMessages == null) return Container();
    talkMessages.sort(
      (a, b) => a.date.compareTo(b.date),
    );
    return ListView.builder(
      shrinkWrap: true,
      itemCount: talkMessages.length,
      reverse: true,
      itemBuilder: (context, index) {
        final message = talkMessages.reversed.elementAt(index);
        final isSentByMe = message.senderGenesisPublicKey == me.publicKey;

        if (isSentByMe) {
          return Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.only(left: 42, right: 8, bottom: 8),
              child: _MessageItem(
                key: Key(message.address),
                color: theme.background!,
                message: message,
                showSender: false,
              ),
            ),
          );
        }
        return Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 8, right: 42, bottom: 8),
            child: _MessageItem(
              key: Key(message.address),
              color: theme.iconDataWidgetIconBackground!,
              message: message,
              showSender: true,
            ),
          ),
        );
      },
    );
  }
}

class _MessageItem extends ConsumerWidget {
  const _MessageItem({
    required this.message,
    required this.color,
    required this.showSender,
    super.key,
  });

  final TalkMessage message;
  final Color color;
  final bool showSender;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(ThemeProviders.selectedTheme);

    final _contact = ref.watch(
      ContactProviders.getContactWithGenesisPublicKey(
        message.senderGenesisPublicKey,
      ),
    );

    return Card(
      shape: showSender
          ? const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            )
          : const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
            ),
      color: color,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (showSender)
              _contact.maybeWhen(
                data: (data) {
                  return Text(
                    data.name.substring(1),
                    style: theme.textStyleSize12W600Primary,
                  );
                },
                loading: () => const SizedBox(),
                orElse: () => const SizedBox(),
              ),
            const SizedBox(height: 3),
            SelectableText(
              message.content,
              style: theme.textStyleSize12W400Primary,
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Text(
                message.date.format(context),
                style: theme.textStyleSize10W100Primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
