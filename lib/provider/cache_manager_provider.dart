import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gameshop_deals/service/cached_network.dart';
import 'package:dio/dio.dart';
import 'package:gameshop_deals/repository/cache_hive_provider.dart';

final cacheManagerFamilyProvider =
    Provider.autoDispose.family<CacheManager, String>((ref, key) {
  final dioInstance = Dio();
  final cacheManager = CacheManager(
    Config(
      key,
      stalePeriod: const Duration(days: 7),
      repo: CacheHiveProvider(key),
      maxNrOfCacheObjects: 300,
      fileService: DioFileService(dioClient: dioInstance),
    ),
  );

  ref.onDispose(() async {
    dioInstance.close();
    await cacheManager.dispose();
  });

  return cacheManager;
}, name: 'Cache Manager');
