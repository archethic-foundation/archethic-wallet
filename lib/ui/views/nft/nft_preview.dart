/// SPDX-License-Identifier: AGPL-3.0-or-later

// Flutter imports:
import 'dart:typed_data';

import 'package:aewallet/appstate_container.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:filesize/filesize.dart';
import 'package:flutter/material.dart';

class NFTPreviewWidget extends StatefulWidget {
  const NFTPreviewWidget(
      {super.key,
      this.nftName,
      this.nftDescription,
      this.nftFile,
      this.nftProperties});

  final String? nftName;
  final String? nftDescription;
  final Uint8List? nftFile;
  final List<TokenProperty>? nftProperties;

  @override
  State<NFTPreviewWidget> createState() => _NFTPreviewWidgetState();
}

class _NFTPreviewWidgetState extends State<NFTPreviewWidget> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            widget.nftName!,
            style: AppStyles.textStyleSize12W600Primary(context),
          ),
          const SizedBox(
            height: 10,
          ),
          if (widget.nftFile != null)
            Container(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Image.memory(widget.nftFile!, fit: BoxFit.cover),
            ),
          if (widget.nftFile != null)
            Text(
              '${AppLocalization.of(context)!.nftAddFileSize} ${filesize(widget.nftFile!.length)}',
              style: AppStyles.textStyleSize12W400Primary(context),
            ),
          if (widget.nftFile != null) const SizedBox(height: 10),
          Text(
            widget.nftDescription!,
            style: AppStyles.textStyleSize12W600Primary(context),
          ),
          const SizedBox(
            height: 10,
          ),
          Wrap(
              alignment: WrapAlignment.center,
              children: widget.nftProperties!
                  .asMap()
                  .entries
                  .map((MapEntry<dynamic, TokenProperty> entry) {
                return entry.value.name != 'file' &&
                        entry.value.name != 'description' &&
                        entry.value.name != 'name' &&
                        entry.value.name != 'type/mime'
                    ? Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Chip(
                          label: Text(
                              '${entry.value.name!}: ${entry.value.value!}',
                              style: AppStyles.textStyleSize12W400Primary(
                                  context)),
                          onDeleted: () {
                            setState(() {
                              widget.nftProperties!.removeAt(entry.key);
                            });
                          },
                          deleteIconColor:
                              StateContainer.of(context).curTheme.text,
                        ))
                    : const SizedBox();
              }).toList()),
        ],
      ),
    );
  }
}
