import 'dart:convert';
import 'package:hive/hive.dart';
import 'cache_service.dart';

class CacheServiceImpl implements CacheService {
  static const String _boxName = 'service_cache';
  static const int _maxSize = 100;

  final Map<String, _CacheEntry> _memoryCache = {};

  Box get _box => Hive.box(_boxName);

  @override
  Future<T?> get<T>(String key) async {
    if (_memoryCache.containsKey(key)) {
      final entry = _memoryCache[key]!;
      if (!entry.isExpired) {
        return entry.value as T;
      }
      _memoryCache.remove(key);
    }

    final data = _box.get(key);
    if (data == null) return null;

    try {
      final entry = _CacheEntry.fromJson(jsonDecode(data as String));
      if (entry.isExpired) {
        await _box.delete(key);
        return null;
      }
      _memoryCache[key] = entry;
      return entry.value as T;
    } catch (_) {
      return null;
    }
  }

  @override
  Future<void> put<T>(String key, T value, {Duration? expiration}) async {
    final entry = _CacheEntry(
      value: value,
      expiration: expiration ?? const Duration(hours: 24),
    );

    _memoryCache[key] = entry;
    await _box.put(key, jsonEncode(entry.toJson()));

    if (_memoryCache.length > _maxSize) {
      _evictOldest();
    }
  }

  @override
  Future<void> remove(String key) async {
    _memoryCache.remove(key);
    await _box.delete(key);
  }

  @override
  Future<void> clear() async {
    _memoryCache.clear();
    await _box.clear();
  }

  @override
  Future<int> getSize() async {
    return _box.length;
  }

  void _evictOldest() {
    if (_memoryCache.isEmpty) return;
    final oldestKey = _memoryCache.keys.first;
    _memoryCache.remove(oldestKey);
    _box.delete(oldestKey);
  }
}

class _CacheEntry {
  final dynamic value;
  final Duration expiration;
  final DateTime createdAt;

  _CacheEntry({
    required this.value,
    required this.expiration,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  bool get isExpired =>
      DateTime.now().difference(createdAt) > expiration;

  Map<String, dynamic> toJson() => {
        'value': value,
        'expiration': expiration.inMilliseconds,
        'createdAt': createdAt.toIso8601String(),
      };

  factory _CacheEntry.fromJson(Map<String, dynamic> json) {
    return _CacheEntry(
      value: json['value'],
      expiration: Duration(milliseconds: json['expiration'] as int),
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }
}
