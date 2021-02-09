import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gameshop_deals/service/cheap_shark_retrofit.dart';
import 'package:gameshop_deals/model/deal.dart';
import 'package:gameshop_deals/model/store.dart';
import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:gameshop_deals/riverpod/filter_provider.dart';
import 'package:gameshop_deals/riverpod/repository_provider.dart';
import 'package:gameshop_deals/model/game_lookup.dart';
import 'package:gameshop_deals/model/filter.dart';

final singleDeal = ScopedProvider<Deal>(null);

final storesProvider = FutureProvider.autoDispose<List<Store>>((ref) {
  final cancelToken = CancelToken();
  final DioCacheManager dioCacheManager =
      DioCacheManager(CacheConfig(defaultRequestMethod: 'GET'));
  final dio = Dio()..interceptors.add(dioCacheManager.interceptor);
  final Options _cacheOptions = buildCacheOptions(const Duration(days: 3),
      maxStale: const Duration(days: 30), forceRefresh: true);

  ref.onDispose(() {
    cancelToken.cancel();
    dio..interceptors.remove(dioCacheManager.interceptor);
    dio.close();
  });

  ref.maintainState = true;

  return DiscountApi(dio).getStores(_cacheOptions, cancelToken);
}, name: 'StoresProvider');

final singleStoreProvider =
    Provider.autoDispose.family<Store, String>((ref, id) {
  return ref
      .watch(storesProvider)
      .data
      ?.value
      ?.firstWhere((element) => element.storeId == id, orElse: () => null);
}, name: 'SingleStore');

final dealPageProvider = StateNotifierProvider.autoDispose
    .family<_DealListPagination, String>((ref, title) {
  final CancelToken cancelToken = CancelToken();
  final Filter filter = ref.watch(filterProvider(title)).state;
  ref.onDispose(cancelToken.cancel);

  final DiscountApi api = ref.watch(cheapSharkProvider);
  return _DealListPagination(filter, api, cancelToken);
}, name: 'dealList');

final dealsProvider = StateNotifierProvider.autoDispose
    .family<StateController<List<Deal>>, String>((ref, title) {
  final notifier = StateController<List<Deal>>(const <Deal>[]);

  final dealList = ref.watch(dealPageProvider(title));
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
  final DioCacheManager dioCacheManager =
      DioCacheManager(CacheConfig(defaultRequestMethod: 'GET'));
  final dio = ref.watch(dioProvider)
    ..interceptors.add(dioCacheManager.interceptor);
  final Options _cacheOptions = buildCacheOptions(null);

  ref.onDispose(() {
    cancelToken.cancel();
    dio..interceptors.remove(dioCacheManager.interceptor);
  });

  return ref
    .watch(cheapSharkProvider)
    .getGamesById(id, _cacheOptions, cancelToken);
}, name: 'Game Deal Lookup');

final dealsOfGameProvider =
    Provider.autoDispose.family<AsyncValue<List<Deal>>, String>((ref, id) {
  return ref.watch(gameDealLookupProvider(id)).whenData((value) => value.deals);
}, name: 'Deals of Game Lookup');

class _DealListPagination extends StateNotifier<AsyncValue<List<Deal>>> {
  final Filter filter;
  final Map<String, dynamic> _parameters;
  final DiscountApi _api;
  final CancelToken cancelToken;
  _DealListPagination(this.filter, this._api, this.cancelToken)
    : _parameters = Map<String, dynamic>.of(filter.parameters),
      super(AsyncValue.loading()) {
    _parameters.putIfAbsent('pageNumber', () => 0);
    _fetch();
  }

  bool _lastPage = false;

  Future<void> retrievePage() async {
    if (state is AsyncLoading || _lastPage)
      return;
    else if (state is AsyncData)
      _parameters.update('pageNumber', (value) => ++value, ifAbsent: () => 0);
    state = AsyncValue.loading();
    await _fetch();
  }

  Future<void> _fetch() async {
    final fetch =
        await AsyncValue.guard(() => _api.getDeals(_parameters, cancelToken));
    if (mounted) state = fetch;
  }

  bool get isLastPage {
    if (_lastPage) return _lastPage;
    if (state is AsyncData &&
        (state.data.value?.length ?? filter.pageSize) < filter.pageSize) {
      _lastPage = true;
    }
    return _lastPage;
  }
}
