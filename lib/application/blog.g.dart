// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blog.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$blogRepositoryHash() => r'489a3e6f726a3cab2476b8ea878f6d7c2dfd1c77';

/// See also [_blogRepository].
@ProviderFor(_blogRepository)
final _blogRepositoryProvider = AutoDisposeProvider<BlogRepository>.internal(
  _blogRepository,
  name: r'_blogRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$blogRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _BlogRepositoryRef = AutoDisposeProviderRef<BlogRepository>;
String _$fetchArticlesHash() => r'e356594c7d452ce3a34f404240a4e7b4b4192fc5';

/// See also [_fetchArticles].
@ProviderFor(_fetchArticles)
final _fetchArticlesProvider =
    AutoDisposeFutureProvider<List<GhostPost>>.internal(
  _fetchArticles,
  name: r'_fetchArticlesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$fetchArticlesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _FetchArticlesRef = AutoDisposeFutureProviderRef<List<GhostPost>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
