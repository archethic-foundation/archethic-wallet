import 'dart:convert';
import 'dart:typed_data';

import 'package:aewallet/appstate_container.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:flutter/material.dart';

class NFTCard2 extends StatefulWidget {
  const NFTCard2({
    Key? key,
    required this.imageBase64,
    required this.name,
    required this.description,
    required this.onTap,
    this.heroTag = 'no-hero',
  }) : super(key: key);

  final String imageBase64;
  final String name;
  final String heroTag;
  final String description;

  final VoidCallback onTap;

  @override
  State<NFTCard2> createState() => _NFTCard2State();
}

class _NFTCard2State extends State<NFTCard2> {
  Image? imageToDisplay;

  @override
  void initState() {
    Uint8List imageDecrypted = base64Decode(widget.imageBase64);
    imageToDisplay = Image.memory(
      imageDecrypted,
      height: 150,
      fit: BoxFit.fitHeight,
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: widget.heroTag,
      child: GestureDetector(
        onTap: widget.onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Card(
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
                  ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: imageToDisplay!),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 12.0, left: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      widget.name,
                      style: AppStyles.textStyleSize14W600Primary(context),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      widget.description,
                      overflow: TextOverflow.ellipsis,
                      style: AppStyles.textStyleSize12W400Primary(context),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
