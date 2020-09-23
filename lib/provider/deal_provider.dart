import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gameshop_deals/model/deal_filter.dart';
import 'package:gameshop_deals/provider/filter_provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:gameshop_deals/model/deal.dart';
import 'package:gameshop_deals/model/store.dart';
import 'package:gameshop_deals/service/cheap_shark_retrofit.dart';
import 'package:dio_http_cache/dio_http_cache.dart';

const List<String> dealSortBy = [
  'Deal Rating',
  'Title',
  'Savings',
  'Price',
  'Metacritic',
  'Reviews',
  'Release',
  'Store',
  'Recent',
];

const String _host = 'https://www.cheapshark.com/api/1.0/';

mixin _DealParameters {
  final Map<String, dynamic> _parameters = {
    'storeID' : <int>[],
    'pageNumber' : 0,
    'pageSize' : 120,
    'sortBy' : dealSortBy[0],
    'desc' : 0,
    'lowerPrice' : 0,
    'upperPrice' : 50,
    'metacritic' : 0,
    'steamRating' : 0,
    'steamAppID' : 0,
    'title' : null,
    'exact' : 0, //Flag to allow only exact string match for title parameter
    'AAA' : 0, //Flag to include only deals with retail price > $29
    'steamworks' : 0, //Flag to include only deals that redeem on Steam (best guess, depends on store support)
    'onSale' : 0 //Flag to include only games that are currently on sale
  };

  Map<String, dynamic> get parameters => Map<String, dynamic>.from(_parameters);

  set stores(List<int> storeID) => _parameters['storeID'] = storeID;
  set pageNumber(int page) => _parameters['pageNumber'] = page;
  set sort(String sortBy) => _parameters['sortBy'] = sortBy;
  set order(int desc) => _parameters['desc'] = desc;
  set lowerPrice(int lower) => _parameters['lowerPrice'] = lower;
  set upperPrice(int upper) => _parameters['upperPrice'] = upper;
  set metacritic(int score) => _parameters['metacritic'] = score;
  set steamRating(int score) => _parameters['steamRating'] = score;
  set retail(int retail) => _parameters['AAA'] = retail;
  set steamWorks(int flag) => _parameters['steamworks'] = flag;
  set onSale(int sale) => _parameters['onSale'] = sale;
}

class StoreProvider{
  final Options _cacheOptions = buildCacheOptions(Duration(days: 7), forceRefresh: true);
  final DiscountApi _discountApi;
  List<Store> _stores;

  StoreProvider(this._discountApi);

  Future<List<Store>> get requestListOfStores async => _stores ??= await _discountApi.getStores(_cacheOptions);
}

class RangePrice extends ChangeNotifier{
  int _start;
  int _end;

  RangePrice(this._start, this._end);

  int get start => _start;
  int get end => _end;
  RangeValues get rangeValues => RangeValues(_start.toDouble(), _end.toDouble());

  set range(RangeValues range){
    if(_start != range.start || _end != range.end){
      _start = range.start.toInt();
      end = range.end.toInt();
      notifyListeners();
    }
  }

  set start(int newValue){
    if (_start == newValue) return;
    _start = newValue;
    notifyListeners();
  }

  set end(int newValue){
    if (_end == newValue) return;
    _end = newValue;
    notifyListeners();
  }
}

class DealProvider with _DealParameters{
  FilterProvider filter = FilterProvider();
  DiscountApi discountApi;
  //StoreProvider storeProvider;
  final _streamListOfDeals = BehaviorSubject<List<Deal>>();
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
  Stream<List<Deal>> get collectionList => _streamListOfDeals.stream;
  
  DealProvider() {
    dio = Dio(_options)..interceptors.add(_dioCacheManager.interceptor);
    discountApi = DiscountApi(dio);
    //storeProvider = StoreProvider(discountApi);
    _initParameters();
  }

  _initParameters() async{
    await requestListOfDeals;
    //await storeProvider.requestListOfStores;
  }

  Future<List<Store>> get requestListOfStores async => _stores ??= await discountApi.getStores(_cacheOptions);

  Future<void> get requestListOfDeals async {
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
  }

  void dispose() {
    _streamListOfDeals.close();
    dio..interceptors.remove(_dioCacheManager.interceptor);
    dio.close();
  }

}