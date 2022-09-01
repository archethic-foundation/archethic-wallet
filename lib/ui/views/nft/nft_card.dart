import 'dart:typed_data';

import 'package:aewallet/ui/util/styles.dart';
import 'package:flutter/material.dart';

class NFTCard extends StatelessWidget {
  const NFTCard({
    Key? key,
    required this.image,
    required this.name,
    required this.description,
    required this.onTap,
    this.heroTag = 'no-hero',
  }) : super(key: key);

  final Uint8List image;
  final String name;
  final String heroTag;
  final String description;

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Image.memory(
            image,
            fit: BoxFit.fill,
          ),
          const SizedBox(height: 2),
          Text(
            name,
            style: AppStyles.textStyleSize14W600Primary(context),
          ),
          Text(
            description,
            style: AppStyles.textStyleSize14W200Primary(context),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
