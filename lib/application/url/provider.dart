/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
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

@riverpod
bool _isUrlAEWeb(
  _IsUrlAEWebRef ref, {
  required String uri,
}) {
  final splitedUrl = uri.split('/');

  if (splitedUrl.length < 2) return false;

  final address = splitedUrl[0];

  if (address.isEmpty) return false;

  if (!Address(address: address).isValid()) {
    return false;
  }

  final allowedExtensions = ['.jpg', '.jpeg', '.png', '.gif'];

  for (final extension in allowedExtensions) {
    if (splitedUrl.last.toLowerCase().endsWith(extension)) {
      return true;
    }
  }

  return false;
}

abstract class UrlProvider {
  static final isUrlValid = _isUrlValidProvider;
  static final isUrlIPFS = _isUrlIPFSProvider;
  static final isUrlAEWeb = _isUrlAEWebProvider;
  static final cleanUri = _cleanUriProvider;
  static final urlIPFSForWeb = _urlIPFSForWebProvider;
}
