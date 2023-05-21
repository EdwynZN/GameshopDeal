import 'package:dio/dio.dart';
import 'package:gameshop_deals/model/deal.dart';
import 'package:gameshop_deals/model/deal_lookup.dart';
import 'package:gameshop_deals/model/filter.dart';
import 'package:gameshop_deals/model/game.dart';
import 'package:gameshop_deals/model/game_lookup.dart';
import 'package:gameshop_deals/model/store.dart';
import 'package:gameshop_deals/repository/cheap_shark_retrofit.dart';

interface class CheapSharkService {
  final DiscountApi _api;

  const CheapSharkService._(this._api);

  factory CheapSharkService(Dio dio) {
    final api = DiscountApi(dio);
    return CheapSharkService._(api);
  }

  Future<List<Deal>> deals({
    int page = 0,
    Filter? filter,
    CancelToken? cancelToken,
  }) {
    final parameters = {
      'pageNumber': page,
      if (filter != null) ...filter.parameters,
    };
    return _api.getDeals(parameters, cancelToken);
  }

  Future<DealLookup> deal(String id, {CancelToken? cancelToken}) =>
      _api.getDealsById(id, cancelToken);

  Future<List<Game>> games(
    String title, {
    final int? steamAppID,
    final int limit = 60,
    final bool exact = false,
    final CancelToken? cancelToken,
  }) {
    final parameters = {
      'title': title,
      'limit': limit,
      'steamAppID': steamAppID,
      'exact': exact ? 1 : 0,
    };
    return _api.getGames(parameters, cancelToken);
  }

  Future<GameLookup> game(int id, {CancelToken? cancelToken}) =>
      _api.getGamesById(id.toString(), Options(), cancelToken);

  Future<Map<String, GameLookup>> gamesById(
    List<int> ids, {
    CancelToken? cancelToken,
  }) =>
      _api.getGamesByMultipleId(ids.join(','), cancelToken);

  Future<List<Store>> stores({
    CancelToken? cancelToken,
  }) =>
      _api.getStores(Options(), cancelToken);
}
