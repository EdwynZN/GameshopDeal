import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:gameshop_deals/service/cached_network.dart';
import 'package:dio/dio.dart';
import 'package:gameshop_deals/repository/cache_hive_provider.dart';
import 'package:gameshop_deals/provider/dispose_extension.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'cache_manager_provider.g.dart';

@riverpod
Dio _dio(_DioRef ref) {
  final Dio dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 10),
      responseType: ResponseType.json,
    ),
  );
  ref.onDispose(dio.close);
  return dio;
}

@Riverpod(dependencies: [_dio])
CacheManager cacheManager(CacheManagerRef ref, {required String cacheKey}) {
  final dioInstance = ref.watch(_dioProvider);
  final cacheManager = CacheManager(
    Config(
      cacheKey,
      stalePeriod: const Duration(days: 7),
      repo: CacheHiveProvider(cacheKey),
      maxNrOfCacheObjects: 300,
      fileService: DioFileService(dioClient: dioInstance),
    ),
  );

  ref
    ..disposeDelay(const Duration(seconds: 30))
    ..onDispose(() async {
      await cacheManager.dispose();
    });

  return cacheManager;
}
