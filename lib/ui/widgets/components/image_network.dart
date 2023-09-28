/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:io';

import 'package:aewallet/application/settings/theme.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ImageNetwork extends ConsumerWidget {
  const ImageNetwork({
    required this.url,
    required this.error,
    required this.loading,
    this.width,
    this.height,
    this.alignment = Alignment.center,
    this.fit = BoxFit.fitWidth,
    super.key,
  });

  final String url;
  final Widget error;
  final Widget loading;
  final double? width;
  final double? height;
  final Alignment alignment;
  final BoxFit fit;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final localizations = AppLocalizations.of(context)!;
    if (!kIsWeb && (Platform.isAndroid || Platform.isIOS || Platform.isMacOS)) {
      return CachedNetworkImage(
        imageUrl: url,
        width: width ?? MediaQuery.of(context).size.width,
        height: height,
        fit: fit,
        errorWidget: (context, url, error) {
          return Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              localizations.imageNotAvailable,
              style: theme.textStyleSize12W400Primary,
              textAlign: TextAlign.center,
            ),
          );
        },
        progressIndicatorBuilder: (context, url, progress) {
          return loading;
        },
      );
    } else {
      return Image.network(
        url,
        width: width ?? MediaQuery.of(context).size.width,
        height: height,
        fit: fit,
        errorBuilder: (
          BuildContext context,
          Object exception,
          StackTrace? stackTrace,
        ) =>
            error,
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
}
