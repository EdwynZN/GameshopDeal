import 'package:shared_preferences/shared_preferences.dart';
import 'package:rxdart/rxdart.dart';
import 'package:gameshop_deals/model/deal.dart';
import 'package:gameshop_deals/service/cheap_shark.dart';
import 'package:gameshop_deals/model/store.dart';

const List<String> dealSortBy = [
  'Deal Rating',
  'Title',
  'Savings',
  'Price',
  'Metacritic',
  'Reviews',
  'Release',
  'Store',
  'recent',
];

mixin _DealParameters {
  final Map<String, dynamic> _parameters = {
    'storeID' : <int>[],
    'pageNumber' : 0,
    'pageSize' : 60,
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

  set stores(List<String> storeID) => _parameters['storeID'] = storeID;
  set pageNumber(int page) => _parameters['pageNumber'] = page;
  set sort(String sort) => _parameters['sortBy'] = sort;
  set order(int desc) => _parameters['desc'] = desc;
  set lowerPrice(int lower) => _parameters['lowerPrice'] = lower;
  set upperPrice(int upper) => _parameters['upperPrice'] = upper;
  set retail(int retail) => _parameters['AAA'] = retail;
  set onSale(int sale) => _parameters['onSale'] = sale;
}

class StoreProvider{
  List<Store> _stores;

  Future<List<Store>> get requestListOfStores async => _stores ??= await listOfStores;
}

class DealProvider with _DealParameters{
  final _streamListOfDeals = BehaviorSubject<String>();
  final StoreProvider storeProvider = StoreProvider();

  Stream<List<Deal>> get collectionList => _streamListOfDeals.map(dealFromJson);

  DealProvider() {
    _initParameters();
  }

  _initParameters() async{
    //final SharedPreferences preferences = await SharedPreferences.getInstance();
    await requestListOfDeals;
    await storeProvider.requestListOfStores;
    //final List<Store> storeList = await listOfStores;
  }

  Future<void> get requestListOfDeals async {
    // TODO: Catch error when no internet connection
    final String data = await getHttp('deals', parameters);
    _streamListOfDeals.sink.add(data);
  }

  void dispose() {
    _streamListOfDeals.close();
  }

}