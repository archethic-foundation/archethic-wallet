/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:io';

import 'package:aewallet/application/theme.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/views/nft_creation/bloc/model.dart';
import 'package:aewallet/ui/views/nft_creation/bloc/provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NFTCreationProcessImportTabFile extends ConsumerWidget {
  const NFTCreationProcessImportTabFile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalization.of(context)!;
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final nftCreation = ref.watch(NftCreationFormProvider.nftCreationForm);
    final nftCreationNotifier =
        ref.watch(NftCreationFormProvider.nftCreationForm.notifier);

    return Column(
      children: [
        SizedBox(
          height: 40,
          child: InkWell(
            onTap: () async {
              final result = await FilePicker.platform.pickFiles();

              if (result != null) {
                nftCreationNotifier.setFileProperties(
                  File(result.files.single.path!),
                  FileImportType.file,
                );
              } else {
                // User canceled the picker
              }
            },
            child: Row(
              children: <Widget>[
                SizedBox(
                  width: 30,
                  child: FaIcon(
                    FontAwesomeIcons.file,
                    size: 18,
                    color: theme.text,
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Text(
                  localizations.nftAddImportFile,
                  style: theme.textStyleSize12W400Primary,
                ),
                const SizedBox(
                  width: 30,
                ),
                if (nftCreation.fileImportType == FileImportType.file)
                  const Icon(
                    Icons.check_circle,
                    size: 16,
                    color: Colors.green,
                  )
              ],
            ),
          ),
        ),
        Divider(
          height: 2,
          color: theme.text15,
        ),
      ],
    );
  }
}
