/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'provider.g.dart';

@riverpod
bool _isUrlValid(
  _IsUrlValidRef ref, {
  required String uri,
}) {
  // Uri seem to accept whitespace. So I need to remove bad formated Uri.
  final textCleaned = uri.replaceAll(' ', '');

  final uriInput = Uri.parse(textCleaned);

  return uriInput.isAbsolute;
}

abstract class UrlProvider {
  static final isUrlValid = _isUrlValidProvider;
}
