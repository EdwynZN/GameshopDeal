import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gameshop_deals/service/cheap_shark_retrofit.dart';
import 'package:gameshop_deals/model/deal.dart';
import 'package:gameshop_deals/model/store.dart';
import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:gameshop_deals/riverpod/filter_provider.dart';
import 'package:gameshop_deals/riverpod/repository_provider.dart';
import 'package:gameshop_deals/model/game_lookup.dart';

final singleDeal = ScopedProvider<Deal>(null);

final storesProvider = FutureProvider.autoDispose<List<Store>>((ref) {
  final cancelToken = CancelToken();
  final DioCacheManager dioCacheManager = DioCacheManager(CacheConfig());
  final dio = ref.watch(dioProvider)
    ..interceptors.add(dioCacheManager.interceptor);
  final Options _cacheOptions =
      buildCacheOptions(Duration(days: 3), maxStale: const Duration(days: 30));
  ref.onDispose(() {
    cancelToken.cancel();
    dio..interceptors.remove(dioCacheManager.interceptor);
  });
  ref.maintainState = true;

  return ref.watch(cheapSharkProvider).getStores(_cacheOptions, cancelToken);
}, name: 'StoresProvider');

final singleStoreProvider =
    Provider.autoDispose.family<Store, String>((ref, id) {
  return ref.watch(storesProvider).maybeWhen(
    orElse: () => null,
    data: (s) =>
      s.firstWhere((element) => element.storeId == id, orElse: () => null),
  );
}, name: 'SingleStore');

final dealPageProvider =
    StateNotifierProvider.autoDispose<_DealListPagination>((ref) {
  final CancelToken cancelToken = CancelToken();
  final Map<String, dynamic> param =
    Map<String, dynamic>.of(ref.watch(filterProvider).state.parameters);
  ref.onDispose(cancelToken.cancel);

  final DiscountApi api = ref.watch(cheapSharkProvider);
  return _DealListPagination(param, api, cancelToken)..retrievePage();
}, name: 'dealList');

final dealsProvider =
    StateNotifierProvider.autoDispose<StateController<List<Deal>>>((ref) {
  final notifier = StateController<List<Deal>>(const <Deal>[]);

  final dealList = ref.watch(dealPageProvider);
  final pageListener = dealList.addListener((value) {
    if (value.data != null)
      notifier.state = List<Deal>.from(notifier.state)
        ..addAll(value.data.value);
  });
  ref.onDispose(pageListener);

  return notifier;
});

final gameDealLookupProvider =
    FutureProvider.autoDispose.family<GameLookup, String>((ref, id) async {
  final cancelToken = CancelToken();
  ref.onDispose(cancelToken.cancel);

  return ref.watch(cheapSharkProvider).getGamesById(id, cancelToken);
}, name: 'Game Deal Lookup');

final dealsOfGameProvider =
    Provider.autoDispose.family<AsyncValue<List<Deal>>, String>((ref, id) {
  return ref.watch(gameDealLookupProvider(id)).whenData((value) => value.deals);
}, name: 'Deals of Game Lookup');


class _DealListPagination extends StateNotifier<AsyncValue<List<Deal>>> {
  final Map<String, dynamic> parameters;
  final DiscountApi _api;
  final CancelToken cancelToken;
  _DealListPagination(this.parameters, this._api, this.cancelToken)
      : super(AsyncValue.loading());

  Future<void> retrievePage() async {
    // if(!(state is AsyncError)) parameters.update('pageNumber', (value) => ++value, ifAbsent: () => 0);
    state.maybeMap(
      error: (_) => null,
      orElse: () => parameters.update('pageNumber', (value) => ++value,
        ifAbsent: () => 0),
    );
    //if (!(state is AsyncLoading)) state = AsyncValue.loading();
    if (state is! AsyncLoading) state = AsyncValue.loading();
    // state = await AsyncValue.guard(() => Future.delayed(const Duration(seconds: 3), () => discountApi
    //   .getDealsFromFilter(parameters, cancelToken)));
    state = await AsyncValue.guard(() => _api.getDeals(parameters, cancelToken));
  }
}