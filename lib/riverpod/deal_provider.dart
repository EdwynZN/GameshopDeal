import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gameshop_deals/model/deal.dart';
/* import 'package:gameshop_deals/service/cheap_shark_retrofit.dart';
import 'package:gameshop_deals/model/store.dart';
import 'package:dio/dio.dart';
import 'package:gameshop_deals/riverpod/filter_provider.dart';
import 'package:gameshop_deals/riverpod/repository_provider.dart';
import 'package:gameshop_deals/model/game_lookup.dart';
import 'package:gameshop_deals/model/filter.dart';
import 'package:gameshop_deals/model/pagination_model.dart';
import 'package:collection/collection.dart'; */

final singleDeal = Provider<Deal>((_) => throw UnimplementedError());
/* 
final storesProvider = FutureProvider.autoDispose<List<Store>>((ref) async {
  final cancelToken = CancelToken();
  final DioCacheManager dioCacheManager =
      DioCacheManager(CacheConfig(defaultRequestMethod: 'GET'));
  final dio = Dio()..interceptors.add(dioCacheManager.interceptor);
  final Options _cacheOptions = buildCacheOptions(const Duration(days: 3),
      maxStale: const Duration(days: 365), forceRefresh: true);

  ref.onDispose(() {
    cancelToken.cancel();
    dio..interceptors.remove(dioCacheManager.interceptor);
    dio.close();
  });

  final stores = await DiscountApi(dio).getStores(_cacheOptions, cancelToken);

  ref.maintainState = true;

  return stores.where((element) => element.isActive).toList();
}, name: 'StoresProvider');

final singleStoreProvider =
    Provider.autoDispose.family<Store?, String>((ref, id) {
  final asyncStores = ref.watch(storesProvider).asData;
  final store =
      asyncStores?.value.firstWhereOrNull((element) => element.storeId == id);

  ref.maintainState = store != null;

  return store;
}, name: 'SingleStore');

final dealPageProvider = StateNotifierProvider.autoDispose
    .family<DealListPagination, AsyncValue<List<Deal>>, String>((ref, title) {
  final CancelToken cancelToken = CancelToken();
  final Filter filter = ref.watch(filterProvider(title));
  ref.onDispose(cancelToken.cancel);

  final DiscountApi api = ref.watch(cheapSharkProvider);
  return DealListPagination(filter, api, cancelToken);
}, name: 'dealList');

final dealsProvider =
    Provider.autoDispose.family<List<Deal>, String>((ref, title) {
  final notifier = const <Deal>[];

  final dealList = ref.watch(dealPageProvider(title).notifier);
  final pageListener = dealList.addListener((value) {
    if (value.asData != null)
      ref.state = List<Deal>.from(ref.state)..addAll(value.asData!.value);
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
  final Options _cacheOptions = buildServiceCacheOptions();

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

class DealListPagination extends StateNotifier<AsyncValue<List<Deal>>>
    implements Pagination<List<Deal>> {
  final Filter filter;
  final Map<String, dynamic> _parameters;
  final DiscountApi _api;
  final CancelToken cancelToken;
  DealListPagination(this.filter, this._api, this.cancelToken)
      : _parameters = Map<String, dynamic>.of(filter.parameters),
        super(AsyncValue.loading()) {
    _parameters.putIfAbsent('pageNumber', () => 0);
    _fetch();
  }

  bool _lastPage = false;

  @override
  Future<void> retrieveNextPage() async {
    if (state is AsyncLoading || isLastPage)
      return;
    else if (state is AsyncData)
      _parameters.update('pageNumber', (value) => ++value, ifAbsent: () => 0);
    state = AsyncValue.loading();
    await _fetch();
  }

  @override
  Future<List<Deal>> fetchPage() => _api.getDeals(_parameters, cancelToken);

  Future<void> _fetch() async {
    final fetch = await AsyncValue.guard(() => fetchPage());
    if (mounted) state = fetch;
  }

  @override
  bool get isLastPage {
    if (_lastPage) return _lastPage;
    if (state is AsyncData &&
        (state.asData?.value.length ?? filter.pageSize) < filter.pageSize) {
      _lastPage = true;
    }
    return _lastPage;
  }
}
 */