import 'package:aewallet/application/settings/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UpdateDiscussionPage extends ConsumerWidget {
  const UpdateDiscussionPage({
    required this.discussionAddress,
    super.key,
  });

  final String discussionAddress;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final localizations = AppLocalizations.of(context)!;

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
      ),
    );
  }
}
