import 'package:aewallet/application/wallet/wallet.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/ui/util/dimens.dart';
import 'package:aewallet/ui/views/add_account/layouts/add_account_sheet.dart';
import 'package:aewallet/ui/widgets/components/app_button_tiny.dart';
import 'package:aewallet/ui/widgets/components/sheet_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddAccountButton extends ConsumerStatefulWidget {
  const AddAccountButton({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AddAccountButtonState();
}

class _AddAccountButtonState extends ConsumerState<AddAccountButton> {
  final GlobalKey expandedKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalization.of(context)!;
    final session = ref.watch(SessionProviders.session).loggedIn;

    return AppButtonTinyConnectivity(
      localizations.addAccount,
      Dimens.buttonBottomDimens,
      key: const Key('addAccount'),
      icon: Icons.add,
      onPressed: () async {
        Sheets.showAppHeightNineSheet(
          context: context,
          ref: ref,
          widget: AddAccountSheet(
            seed: session!.wallet.seed,
          ),
        );
      },
    );
  }
}
