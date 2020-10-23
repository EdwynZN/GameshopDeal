import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gameshop_deals/service/cheap_shark_retrofit.dart';
import 'package:gameshop_deals/model/deal.dart';
import 'package:gameshop_deals/model/store.dart';
import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:gameshop_deals/riverpod/filter_provider.dart';
import 'package:gameshop_deals/riverpod/repository_provider.dart';

/*final _dioProvider = Provider.autoDispose<Dio>((ref) {
  final Dio dio = Dio(
    BaseOptions(
      connectTimeout: 5000,
      receiveTimeout: 3000,
      responseType: ResponseType.json
    )
  );
  ref.onDispose(dio.close);
  return dio;
}, name: 'Dio');

final _cheapSharkProvider = Provider.autoDispose<DiscountApi>((ref) => DiscountApi(ref.watch(_dioProvider)), name: 'CheapShark API');*/

/*final dealList = StateNotifierProvider.autoDispose<DealList>((ref) {
  final CancelToken cancelToken = CancelToken();
  ref.onDispose(cancelToken.cancel);
  final Map<String, dynamic> param = ref.watch(filterProvider).state.parameters;
  final DiscountApi api = ref.watch(cheapSharkProvider);
  return DealList(param, api, cancelToken)..nextPage();
}, name: 'dealList');

class DealList extends StateNotifier<List<Deal>>{
  final Map<String, dynamic> parameters;
  final DiscountApi discountApi;
  final CancelToken _cancelToken;
  DealList(this.parameters, this.discountApi, this._cancelToken) : super(const <Deal>[]);

  AsyncValue<List<Deal>> _deals = AsyncValue.loading();
  AsyncValue<List<Deal>> get status => _deals;

  Future<void> nextPage() async{
    parameters.update('pageNumber', (value) => ++value, ifAbsent: () => 0);
    _deals = AsyncValue.loading();
    _deals = await AsyncValue.guard(() => discountApi
        .getDealsFromFilter(parameters, _cancelToken));
    // _deals.whenData((data) => state = List<Deal>.from(state)..addAll(data));
    if(_deals.data != null) state = List<Deal>.from(state)..addAll(_deals.data.value);
  }

}*/

final storesProvider = FutureProvider.autoDispose<List<Store>>((ref) {
  final cancelToken = CancelToken();
  final DioCacheManager dioCacheManager = DioCacheManager(CacheConfig());
  final dio = ref.watch(dioProvider)..interceptors.add(dioCacheManager.interceptor);
  final Options _cacheOptions = buildCacheOptions(Duration(days: 7), forceRefresh: true);
  ref.onDispose(() {
    cancelToken.cancel();
    dio..interceptors.remove(dioCacheManager.interceptor);
  });
  ref.maintainState = true;

  return ref.watch(cheapSharkProvider).getStores(_cacheOptions, cancelToken);
});

final dealPageProvider = StateNotifierProvider.autoDispose<_DealListPagination>((ref) {
  final CancelToken cancelToken = CancelToken();
  ref.onDispose(cancelToken.cancel);
  final Map<String, dynamic> param = ref.watch(filterProvider).state.parameters;
  final DiscountApi api = ref.watch(cheapSharkProvider);
  return _DealListPagination(param, api, cancelToken)..retrievePage();
}, name: 'dealList');

final dealsProvider = StateNotifierProvider.autoDispose<StateController<List<Deal>>>((ref) {
  final notifier = StateController<List<Deal>>(const <Deal>[]);

  final dealList = ref.watch(dealPageProvider);
  final pageListener = dealList.addListener((value) {
    if(value.data != null) notifier.state = List<Deal>.from(notifier.state)..addAll(value.data.value);
  });
  ref.onDispose(pageListener);

  return notifier;
});

// TODO delete the delayed Future
class _DealListPagination extends StateNotifier<AsyncValue<List<Deal>>>{
  final Map<String, dynamic> parameters;
  final DiscountApi discountApi;
  final CancelToken cancelToken;
  _DealListPagination(this.parameters, this.discountApi, this.cancelToken) : super(AsyncValue.loading());

  Future<void> retrievePage() async {
    state.maybeMap(
      error: null,
      orElse: () => parameters.update('pageNumber', (value) => ++value, ifAbsent: () => 0)
    );
    state = AsyncValue.loading();
    state = await AsyncValue.guard(() => Future.delayed(const Duration(seconds: 3), () => discountApi
      .getDealsFromFilter(parameters, cancelToken)));
  }

}