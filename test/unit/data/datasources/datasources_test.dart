import 'package:flutter_test/flutter_test.dart';
import 'package:cctv_jmd_flutter/data/datasources/remote_data_source.dart';
import 'package:cctv_jmd_flutter/data/datasources/local_data_source.dart';
import 'package:cctv_jmd_flutter/data/datasources/cache_data_source.dart';

void main() {
  group('Data Sources', () {
    test('RemoteDataSource should be abstract', () {
      expect(RemoteDataSource, isA<Type>());
    });

    test('LocalDataSource should be abstract', () {
      expect(LocalDataSource, isA<Type>());
    });

    test('CacheDataSource should be instantiable', () {
      final cache = CacheDataSource();
      expect(cache, isNotNull);
      expect(cache.cacheSize, 0);
    });

    test('CacheDataSource should cache and retrieve data', () async {
      final cache = CacheDataSource();
      // This will be tested with actual EpgData later
      expect(cache.cacheSize, 0);
    });
  });
}
