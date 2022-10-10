// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blog.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// ignore_for_file: avoid_private_typedef_functions, non_constant_identifier_names, subtype_of_sealed_class, invalid_use_of_internal_member, unused_element, constant_identifier_names, unnecessary_raw_strings, library_private_types_in_public_api

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

String $_blogRepositoryHash() => r'489a3e6f726a3cab2476b8ea878f6d7c2dfd1c77';

/// See also [_blogRepository].
final _blogRepositoryProvider = AutoDisposeProvider<BlogRepository>(
  _blogRepository,
  name: r'_blogRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : $_blogRepositoryHash,
);
typedef _BlogRepositoryRef = AutoDisposeProviderRef<BlogRepository>;
String $_fetchArticlesHash() => r'e356594c7d452ce3a34f404240a4e7b4b4192fc5';

/// See also [_fetchArticles].
final _fetchArticlesProvider = AutoDisposeFutureProvider<List<GhostPost>>(
  _fetchArticles,
  name: r'_fetchArticlesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : $_fetchArticlesHash,
);
typedef _FetchArticlesRef = AutoDisposeFutureProviderRef<List<GhostPost>>;
