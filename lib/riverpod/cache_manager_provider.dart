import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gameshop_deals/riverpod/repository_provider.dart';
import 'package:gameshop_deals/service/cached_network.dart';

final cacheManagerFamilyProvider = Provider.autoDispose.family<CacheManager, String>((ref, key) {
  final dioInstance = ref.watch(dioProvider);
  return CacheManager(
    Config(
      key,
      stalePeriod: const Duration(days: 7),
      maxNrOfCacheObjects: 600,
      fileService: DioFileService(dioClient: dioInstance)
      // fileService: HttpFileService(),
    ),
  );
}, name: 'Cache Manager');