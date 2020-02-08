import 'package:dio/dio.dart';
import 'package:gameshop_deals/model/deal.dart';
import 'package:gameshop_deals/model/game.dart';
import 'package:gameshop_deals/model/store.dart';

const String _host = 'https://www.cheapshark.com/api/1.0/';

BaseOptions _options = BaseOptions(
  baseUrl: _host,
  connectTimeout: 5000,
  receiveTimeout: 3000,
  responseType: ResponseType.plain
);
Dio dio = Dio(_options);

Future<String> getHttp(String path, Map<String, dynamic> parameters) async {
  try {
    Response response = await dio.get<String>(path, queryParameters: parameters);
    return response.data;
  } catch (error, stacktrace) {
    //print("Exception occured: $error stackTrace: $stacktrace");
    return null;
  }
}

Future<List<Deal>> get listOfDeals async {
  Map<String, dynamic> parameters = {
    'storeID' : [],
    'pageNumber' : 0,
    'pageSize' : 15,
    'sortBy' : 'Deal Rating',
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
  try {
    Response response = await dio.get('deals', queryParameters: parameters);
    return dealFromJson(response.data);
  } catch (error, stacktrace) {
    //print("Exception occured: $error stackTrace: $stacktrace");
    return null;
  }
}

Future<Deal> get dealById async {
  Map<String, dynamic> parameters = {
    'id' : 'X8sebHhbc1Ga0dTkgg59WgyM506af9oNZZJLU9uSrX8%3D',
  };
  try {
    Response response = await dio.get('deals', queryParameters: parameters);
    return Deal.fromJson(response.data);
  } catch (error, stacktrace) {
    print("Exception occured: $error stackTrace: $stacktrace");
    return null;
  }
}

Future<List<Game>> get listOfGames async {
  Map<String, dynamic> parameters = {
    'title' : 'batman',
    'steamAppID' : null,
    'limit' : 60,
    'exact' : 0,
  };
  try {
    Response response = await dio.get('games', queryParameters: parameters);
    return gameFromJson(response.data);
  } catch (error, stacktrace) {
    print("Exception occured: $error stackTrace: $stacktrace");
    return null;
  }
}

Future<Game> get gamesById async {
  Map<String, dynamic> parameters = {
    'id' : '14',
  };
  try {
    Response response = await dio.get('games', queryParameters: parameters);
    return Game.fromJson(response.data);
  } catch (error, stacktrace) {
    print("Exception occured: $error stackTrace: $stacktrace");
    return null;
  }
}

Future<List<Game>> get gamesByMultipleId async {
  Map<String, dynamic> parameters = {
    'id' : ['14', '12'],
  };
  try {
    Response response = await dio.get('games', queryParameters: parameters);
    return gameFromJson(response.data);
  } catch (error, stacktrace) {
    print("Exception occured: $error stackTrace: $stacktrace");
    return null;
  }
}

Future<List<Store>> get listOfStores async {
  try {
    Response response = await dio.get('stores');
    return storeFromJson(response.data);
  } catch (error, stacktrace) {
    //print("Exception occured: $error stackTrace: $stacktrace");
    return null;
  }
}