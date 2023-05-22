import 'package:dio/dio.dart';
import 'package:gameshop_deals/model/store.dart';
import 'package:gameshop_deals/service/cheap_shark_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'store_provider.g.dart';

@riverpod
Future<List<Store>> fetchStores(FetchStoresRef ref) async {
  final cancelToken = CancelToken();
  final dio = Dio();
  /* final DioCacheManager dioCacheManager =
      DioCacheManager(CacheConfig(defaultRequestMethod: 'GET'));
  ..interceptors.add(dioCacheManager.interceptor);
  final Options _cacheOptions = buildCacheOptions(const Duration(days: 3),
      maxStale: const Duration(days: 365), forceRefresh: true); */

  ref.onDispose(() {
    cancelToken.cancel();
    //dio..interceptors.remove(dioCacheManager.interceptor);
    dio.close();
  });

  final stores = await CheapSharkService(dio).stores(cancelToken: cancelToken);

  ref.keepAlive();

  return stores.where((element) => element.isActive).toList();
}

@Riverpod(dependencies: [fetchStores])
AsyncValue<Store> singleStore(SingleStoreRef ref, {required int id}) {
  final asyncStore = ref
      .watch(fetchStoresProvider)
      .whenData((data) => data.firstWhere((store) => store.storeId == id));

  if (asyncStore.hasValue) {
    ref.keepAlive();
  }

  return asyncStore;
}
