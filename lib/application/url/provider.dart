/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'provider.g.dart';

@riverpod
Uri _cleanUri(
  _CleanUriRef ref, {
  required String uri,
}) {
  // Uri seem to accept whitespace. So I need to remove bad formated Uri.
  final textCleaned = uri.replaceAll(' ', '');

  final uriInput = Uri.parse(textCleaned);

  return uriInput;
}

@riverpod
bool _isUrlValid(
  _IsUrlValidRef ref, {
  required Uri uri,
}) {
  return uri.isAbsolute == true;
}

@riverpod
bool _isUrlIPFS(
  _IsUrlIPFSRef ref, {
  required Uri uri,
}) {
  return uri.isScheme('ipfs');
}

@riverpod
String _urlIPFSForWeb(
  _UrlIPFSForWebRef ref, {
  required String uri,
}) {
  return uri.replaceAll('ipfs://', 'https://ipfs.io/ipfs/');
}

abstract class UrlProvider {
  static final isUrlValid = _isUrlValidProvider;
  static final isUrlIPFS = _isUrlIPFSProvider;
  static final cleanUri = _cleanUriProvider;
  static final urlIPFSForWeb = _urlIPFSForWebProvider;
}
