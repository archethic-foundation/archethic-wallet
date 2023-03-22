/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ImageNetwork extends ConsumerWidget {
  const ImageNetwork({
    required this.url,
    required this.error,
    required this.loading,
    super.key,
  });

  final String url;
  final Widget error;
  final Widget loading;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Image.network(
      url,
      width: MediaQuery.of(context).size.width,
      fit: BoxFit.fitWidth,
      errorBuilder: (
        BuildContext context,
        Object exception,
        StackTrace? stackTrace,
      ) {
        return error;
      },
      loadingBuilder: (
        BuildContext context,
        Widget child,
        ImageChunkEvent? loadingProgress,
      ) {
        if (loadingProgress == null) {
          return child;
        }
        return loading;
      },
    );
  }
}
