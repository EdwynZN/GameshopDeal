import 'package:dio/dio.dart';
import 'package:gameshop_deals/provider/filter_provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:gameshop_deals/model/deal.dart';
import 'package:gameshop_deals/model/store.dart';
import 'package:gameshop_deals/service/cheap_shark_retrofit.dart';
import 'package:dio_http_cache/dio_http_cache.dart';

const String _host = 'https://www.cheapshark.com/api/1.0/';

class DealProvider{
  FilterProvider filter = FilterProvider();
  DiscountApi discountApi;
  final _streamListOfDeals = BehaviorSubject<FilterProvider>();
  List<Store> _stores;

  final Options _cacheOptions = buildCacheOptions(Duration(days: 7), forceRefresh: true);
  final BaseOptions _options = BaseOptions(
    baseUrl: _host,
    connectTimeout: 5000,
    receiveTimeout: 3000,
    responseType: ResponseType.json
  );
  final DioCacheManager _dioCacheManager = DioCacheManager(CacheConfig());
  Dio dio;

  //Stream<List<Deal>> get collectionList => _streamListOfDeals.map(dealFromJson);
  Stream<List<Deal>> get collectionList => _streamListOfDeals
    .map<Map<String, dynamic>>((filter) => filter.parameters)
    .switchMap<List<Deal>>((param) => Stream.fromFuture(discountApi.getDealsFromFilter(param)));
  
  DealProvider() {
    dio = Dio(_options)..interceptors.add(_dioCacheManager.interceptor);
    discountApi = DiscountApi(dio);
    //storeProvider = StoreProvider(discountApi);
    _streamListOfDeals.sink.add(filter);
  }

  Future<List<Store>> get requestListOfStores async => _stores ??= await discountApi.getStores(_cacheOptions);

  Future<void> get requestListOfDeals async => _streamListOfDeals.sink.add(filter);

  /*Future<void> get requestListOfDeals async {
    // TODO: Catch error when no internet connection
//    final String data = await getHttp('deals', parameters);
//    _streamListOfDeals.sink.add(data);
    try {
      final data = await discountApi.getDealsFromFilter(filter.parameters);
      _streamListOfDeals.sink.add(data);
    } on DioError catch(e){
      _streamListOfDeals.sink.addError(e.type);
    } catch (error) {
      _streamListOfDeals.sink.addError(error);
    }
  }*/

  void dispose() {
    _streamListOfDeals.close();
    dio..interceptors.remove(_dioCacheManager.interceptor);
    dio.close();
  }

}