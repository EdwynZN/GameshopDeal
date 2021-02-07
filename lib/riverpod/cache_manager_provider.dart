import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gameshop_deals/service/cached_network.dart';
import 'package:dio/dio.dart';

final cacheManagerFamilyProvider =
    Provider.autoDispose.family<CacheManager, String>((ref, key) {
  final dioInstance = Dio();

  ref.onDispose(() => dioInstance..clear()..close());

  return CacheManager(
    Config(key,
        stalePeriod: const Duration(days: 7),
        maxNrOfCacheObjects: 600,
        fileService: DioFileService(dioClient: dioInstance)
        ),
  );
}, name: 'Cache Manager');
