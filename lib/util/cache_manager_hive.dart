/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'dart:developer';

import 'package:aewallet/infrastructure/datasources/vault.dart';
import 'package:aewallet/model/data/appdb.dart';
import 'package:hive/hive.dart';

part 'cache_manager_hive.g.dart';

@HiveType(typeId: HiveTypeIds.cacheItem)
class CacheItemHive extends HiveObject {
  CacheItemHive(
    this.value, {
    this.ttl = 2592000,
  }) : createdAt = DateTime.now();

  @HiveField(0)
  dynamic value;

  @HiveField(1)
  DateTime createdAt;

  // TTL (Time to Live) in seconds
  @HiveField(3)
  int ttl;
}

class CacheManagerHive {
  CacheManagerHive(this._cacheBox, {this.maxCacheItems = 100});

  static const String cacheManagerHiveTable = 'cacheManagerHive';
  final Box<CacheItemHive> _cacheBox;
  final int maxCacheItems;

  static CacheManagerHive? _instance;
  static Future<CacheManagerHive> getInstance() async {
    if (_instance?._cacheBox.isOpen == true) return _instance!;
    final encryptedBox = await Vault.instance().openBox<CacheItemHive>(
      cacheManagerHiveTable,
    );
    return _instance = CacheManagerHive(encryptedBox);
  }

  Future<void> put(String key, CacheItemHive cacheItemHive) async {
    if (_cacheBox.length >= maxCacheItems) {
      log('Remove oldest item', name: 'cacheManagerHive');
      _removeOldestItem();
    }
    await _cacheBox.put(key, cacheItemHive);
  }

  dynamic get(String key) {
    final cachedItem = _cacheBox.get(key);
    if (cachedItem != null) {
      if (Duration(seconds: cachedItem.ttl) != Duration.zero) {
        final ttlExpirationTime = cachedItem.createdAt.add(
          Duration(
            seconds: cachedItem.ttl,
          ),
        );
        if (DateTime.now().isBefore(ttlExpirationTime)) {
          return cachedItem.value;
        } else {
          log('Delete expired item $key', name: 'cacheManagerHive');
          _cacheBox.delete(key);
        }
      } else {
        return cachedItem.value;
      }
    }
    return null;
  }

  bool contains(String key) {
    return _cacheBox.containsKey(key);
  }

  void delete(String key) {
    _cacheBox.delete(key);
  }

  void clear() {
    _cacheBox.clear();
  }

  void _removeOldestItem() {
    final oldestKey = _cacheBox.keyAt(0);
    if (oldestKey != null) {
      _cacheBox.delete(oldestKey);
    }
  }
}
