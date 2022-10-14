/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:io';

import 'package:aewallet/application/theme.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/views/nft_creation/bloc/model.dart';
import 'package:aewallet/ui/views/nft_creation/bloc/provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

class NFTCreationProcessImportTabCamera extends ConsumerWidget {
  const NFTCreationProcessImportTabCamera({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (kIsWeb == true ||
        (Platform.isAndroid == false && Platform.isIOS == false)) {
      return const SizedBox();
    }

    final localizations = AppLocalization.of(context)!;
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final nftCreation = ref.watch(NftCreationProvider.nftCreation);
    final nftCreationNotifier =
        ref.watch(NftCreationProvider.nftCreation.notifier);
    return Column(
      children: [
        SizedBox(
          height: 40,
          child: InkWell(
            onTap: () async {
              final pickedFile = await ImagePicker().pickImage(
                source: ImageSource.camera,
                maxWidth: 1800,
                maxHeight: 1800,
              );
              if (pickedFile != null) {
                nftCreationNotifier.setFileProperties(
                  File(pickedFile.path),
                  FileImportTypeEnum.camera,
                );
              }
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: <Widget>[
                    SizedBox(
                      width: 30,
                      child: FaIcon(
                        FontAwesomeIcons.cameraRetro,
                        size: 18,
                        color: theme.text,
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      localizations.nftAddImportCamera,
                      style: theme.textStyleSize12W400Primary,
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    if (nftCreation.fileImportType == FileImportTypeEnum.camera)
                      const Icon(
                        Icons.check_circle,
                        size: 16,
                        color: Colors.green,
                      )
                  ],
                ),
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
