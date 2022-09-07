/// SPDX-License-Identifier: AGPL-3.0-or-later

// Flutter imports:
import 'dart:typed_data';

import 'package:aewallet/appstate_container.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/util/mime_util.dart';
import 'package:aewallet/util/nft_util.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:filesize/filesize.dart';
import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';

class NFTPreviewWidget extends StatefulWidget {
  const NFTPreviewWidget(
      {super.key,
      this.nftName,
      this.nftAddress,
      this.nftDescription,
      this.nftFile,
      this.nftTypeMime,
      this.nftProperties,
      this.context,
      this.nftPropertiesDeleteAction = true});

  final String? nftName;
  final String? nftAddress;
  final String? nftDescription;
  final Uint8List? nftFile;
  final String? nftTypeMime;
  final List<TokenProperty>? nftProperties;
  final BuildContext? context;
  final bool nftPropertiesDeleteAction;

  @override
  State<NFTPreviewWidget> createState() => _NFTPreviewWidgetState();
}

class _NFTPreviewWidgetState extends State<NFTPreviewWidget> {
  Image? imageToDisplay;

  @override
  void initState() {
    /* if (MimeUtil.isImage(widget.nftTypeMime) == true) {
      imageToDisplay = Image.memory(
        widget.nftFile!,
        width: MediaQuery.of(widget.context!).size.width,
        fit: BoxFit.fitWidth,
      );
    } else {
      if (MimeUtil.isPdf(widget.nftTypeMime) == true) {
        PdfDocument.openData(
          widget.nftFile!,
        ).then((PdfDocument pdfDocument) {
          pdfDocument.getPage(1).then((PdfPage pdfPage) {
            pdfPage
                .render(width: pdfPage.width, height: pdfPage.height)
                .then((PdfPageImage? pdfPageImage) {
              imageToDisplay = Image.memory(
                pdfPageImage!.bytes,
                height: 150,
                fit: BoxFit.fitHeight,
              );
            });
          });
        });
      }
    }*/

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: widget.nftName!,
      child: Padding(
        padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
        child: Align(
          alignment: Alignment.topCenter,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                widget.nftName!,
                style: AppStyles.textStyleSize18W600Primary(context),
              ),
              const SizedBox(
                height: 10,
              ),
              if (widget.nftFile != null)
                if (MimeUtil.isImage(widget.nftTypeMime) == true ||
                    MimeUtil.isPdf(widget.nftTypeMime) == true)
                  FutureBuilder<Uint8List?>(
                      future:
                          NFTUtil.getImageFromTokenAddress(widget.nftAddress!),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Container(
                              decoration: BoxDecoration(
                                color: StateContainer.of(context).curTheme.text,
                                border: Border.all(
                                  width: 1,
                                ),
                              ),
                              child: imageToDisplay = Image.memory(
                                snapshot.data!,
                                width:
                                    MediaQuery.of(widget.context!).size.width,
                                fit: BoxFit.fitWidth,
                              ));
                        } else {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                      }),
              if (widget.nftFile != null)
                Text(
                  '${AppLocalization.of(context)!.nftAddFileSize} ${filesize(widget.nftFile!.length)}',
                  style: AppStyles.textStyleSize12W400Primary(context),
                ),
              if (widget.nftFile != null) const SizedBox(height: 10),
              Text(
                widget.nftDescription!,
                style: AppStyles.textStyleSize14W600Primary(context),
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
                            child: widget.nftPropertiesDeleteAction == true
                                ? Chip(
                                    label: Text(
                                        '${entry.value.name!}: ${entry.value.value!}',
                                        style: AppStyles
                                            .textStyleSize12W400Primary(
                                                context)),
                                    onDeleted: () {
                                      setState(() {
                                        widget.nftProperties!
                                            .removeAt(entry.key);
                                      });
                                    },
                                    deleteIconColor: StateContainer.of(context)
                                        .curTheme
                                        .text,
                                  )
                                : Chip(
                                    label: Text(
                                        '${entry.value.name!}: ${entry.value.value!}',
                                        style: AppStyles
                                            .textStyleSize12W400Primary(
                                                context)),
                                  ),
                          )
                        : const SizedBox();
                  }).toList()),
            ],
          ),
        ),
      ),
    );
  }
}
