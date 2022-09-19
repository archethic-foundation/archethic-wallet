/// SPDX-License-Identifier: AGPL-3.0-or-later

// Dart imports:
import 'dart:typed_data';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pdfx/pdfx.dart';

// Project imports:
import 'package:aewallet/appstate_container.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/haptic_util.dart';
import 'package:aewallet/util/mime_util.dart';

class NFTCard2 extends StatelessWidget {
  const NFTCard2({
    Key? key,
    required this.name,
    this.fileDecrypted,
    required this.address,
    required this.description,
    required this.typeMime,
    required this.onTap,
  }) : super(key: key);

  final String name;
  final String address;
  final Uint8List? fileDecrypted;
  final String description;
  final String typeMime;

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    Uint8List? fileDecryptedFinal = fileDecrypted;
    if (MimeUtil.isPdf(typeMime) == true) {
      PdfDocument.openData(
        fileDecrypted!,
      ).then((PdfDocument pdfDocument) {
        pdfDocument.getPage(1).then((PdfPage pdfPage) {
          pdfPage
              .render(width: pdfPage.width, height: pdfPage.height)
              .then((PdfPageImage? pdfPageImage) {
            fileDecryptedFinal = pdfPageImage!.bytes;
          });
        });
      });
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 12.0, left: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  name,
                  style: AppStyles.textStyleSize12W400Primary(context),
                ),
                if (description != '') const SizedBox(height: 5),
                if (description != '')
                  Text(
                    description,
                    overflow: TextOverflow.ellipsis,
                    style: AppStyles.textStyleSize12W400Primary(context),
                  ),
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: onTap,
          child: Card(
            elevation: 5,
            shadowColor: Colors.black,
            margin: const EdgeInsets.only(left: 8, right: 8),
            color: StateContainer.of(context).curTheme.backgroundDark,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
              side: const BorderSide(color: Colors.white10, width: 1),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                if (MimeUtil.isImage(typeMime) == true ||
                    MimeUtil.isPdf(typeMime) == true)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: Container(
                      decoration: BoxDecoration(
                        color: StateContainer.of(context).curTheme.text,
                        border: Border.all(
                          width: 1,
                        ),
                      ),
                      child: fileDecrypted == null
                          ? const SizedBox()
                          : Image.memory(
                              fileDecryptedFinal!,
                              height: 150,
                              fit: BoxFit.fitHeight,
                            ),
                    ),
                  ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 10, top: 5),
          child: Align(
            alignment: Alignment.centerRight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: (() async {
                    sl.get<HapticUtil>().feedback(FeedbackType.light,
                        StateContainer.of(context).activeVibrations);
                    await StateContainer.of(context)
                        .appWallet!
                        .appKeychain!
                        .getAccountSelected()!
                        .updateNftInfosOffChain(
                            tokenAddress: address, like: false);
                  }),
                  child: const Icon(
                    Icons.verified,
                    color: Colors.blue,
                    size: 20,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                InkWell(
                  onTap: (() async {
                    sl.get<HapticUtil>().feedback(FeedbackType.light,
                        StateContainer.of(context).activeVibrations);
                    await StateContainer.of(context)
                        .appWallet!
                        .appKeychain!
                        .getAccountSelected()!
                        .updateNftInfosOffChain(
                            tokenAddress: address, like: false);
                  }),
                  child: const FaIcon(
                    FontAwesomeIcons.star,
                    color: Colors.yellow,
                    size: 18,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
