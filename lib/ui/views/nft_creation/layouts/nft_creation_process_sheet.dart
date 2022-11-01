import 'dart:io';

import 'package:aewallet/application/account.dart';
import 'package:aewallet/application/currency.dart';
import 'package:aewallet/application/device_abilities.dart';
import 'package:aewallet/application/nft_category.dart';
import 'package:aewallet/application/settings.dart';
import 'package:aewallet/application/theme.dart';
import 'package:aewallet/appstate_container.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/ui/util/dimens.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/util/ui_util.dart';
import 'package:aewallet/ui/views/nft_creation/bloc/provider.dart';
import 'package:aewallet/ui/views/nft_creation/bloc/state.dart';
import 'package:aewallet/ui/views/nft_creation/layouts/components/category_template_form.dart';
import 'package:aewallet/ui/views/nft_creation/layouts/components/nft_creation_confirm_sheet.dart';
import 'package:aewallet/ui/views/nft_creation/layouts/components/nft_creation_form_sheet.dart';
import 'package:aewallet/ui/views/nft_creation/layouts/components/nft_creation_process_file_access.dart';
import 'package:aewallet/ui/views/nft_creation/layouts/components/nft_creation_process_file_preview.dart';
import 'package:aewallet/ui/views/nft_creation/layouts/components/nft_creation_process_property_access.dart';
import 'package:aewallet/ui/widgets/components/app_button.dart';
import 'package:aewallet/ui/widgets/components/app_button_tiny.dart';
import 'package:aewallet/ui/widgets/components/app_text_field.dart';
import 'package:aewallet/ui/widgets/components/dialog.dart';
import 'package:aewallet/ui/widgets/fees/fee_infos.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/haptic_util.dart';
import 'package:aewallet/util/user_data_util.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

part 'components/nft_creation_process_import_tab.dart';
part 'components/nft_creation_process_import_tab_image.dart';
part 'components/nft_creation_process_import_tab_camera.dart';
part 'components/nft_creation_process_import_tab_file.dart';
part 'components/nft_creation_process_infos_tab.dart';
part 'components/nft_creation_process_infos_tab_textfield_description.dart';
part 'components/nft_creation_process_infos_tab_textfield_name.dart';
part 'components/nft_creation_process_confirmation_tab.dart';
part 'components/nft_creation_process_properties_tab.dart';
part 'components/nft_creation_process_properties_tab_textfield_name.dart';
part 'components/nft_creation_process_properties_tab_textfield_value.dart';
part 'components/nft_creation_process_properties_tab_textfield_search.dart';

class NftCreationProcessSheet extends ConsumerWidget {
  const NftCreationProcessSheet({
    required this.seed,
    super.key,
  });

  final String seed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedAccount = ref.watch(
      AccountProviders.getSelectedAccount(context: context),
    );

    // The main column that holds everything
    return ProviderScope(
      overrides: [
        NftCreationFormProvider.initialNftCreationForm.overrideWithValue(
          NftCreationFormState(
            feeEstimation: const AsyncValue.data(0),
            seed: seed,
            accountBalance: selectedAccount!.balance!,
          ),
        ),
      ],
      child: NftCreationSheetBody(
        seed: seed,
      ),
    );
  }
}

class NftCreationSheetBody extends ConsumerWidget {
  const NftCreationSheetBody({
    required this.seed,
    super.key,
  });

  final String seed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final nftCreation = ref.watch(NftCreationFormProvider.nftCreationForm);

    ref.listen<NftCreationFormState>(
      NftCreationFormProvider.nftCreationForm,
      (_, nftCreation) {
        if (nftCreation.isControlsOk) return;

        final errorMessages = <String>[];
        if (nftCreation.error.isNotEmpty) {
          errorMessages.add(nftCreation.error);
        }

        UIUtil.showSnackbar(
          errorMessages.join('\n'),
          context,
          ref,
          theme.text!,
          theme.snackBarShadow!,
          duration: const Duration(seconds: 5),
        );
      },
    );

    if (nftCreation.nftCreationProcessStep == NftCreationProcessStep.form) {
      return const NftCreationFormSheet();
    } else {
      return const NftCreationConfirmSheet();
    }
  }
}
