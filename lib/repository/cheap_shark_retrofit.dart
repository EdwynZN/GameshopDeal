import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:gameshop_deals/model/deal.dart';
import 'package:gameshop_deals/model/game.dart';
import 'package:gameshop_deals/model/store.dart';
import 'package:gameshop_deals/model/game_lookup.dart';
import 'package:gameshop_deals/model/deal_lookup.dart';
import 'package:gameshop_deals/utils/preferences_constants.dart';

part 'cheap_shark_retrofit.g.dart';

@RestApi(baseUrl: "$cheapsharkUrl/api/1.0/")
abstract class DiscountApi{
  factory DiscountApi(Dio dio, {String baseUrl}) = _DiscountApi;

  @GET('/deals')
  Future<List<Deal>> getDeals([
    @Queries() Map<String, dynamic>? parameters,
    @CancelRequest() CancelToken? cancelToken
  ]);

  @GET('/deals?id={id}')
  Future<DealLookup> getDealsById(
    @Path('id') String id,
    [@CancelRequest() CancelToken? cancelToken]
  );

  @GET('/games')
  Future<List<Game>> getGames(
    @Queries() Map<String, dynamic>? parameters,
    [@CancelRequest() CancelToken? cancelToken]
  );

  @GET('/games')
  Future<GameLookup> getGamesById(
    @Query('id') String id, [
      @DioOptions() Options? options,
      @CancelRequest() CancelToken? cancelToken,
    ]
  );

  @GET('/games')
  Future<Map<String, GameLookup>> getGamesByMultipleId(
    @Query('ids') String ids,
    [@CancelRequest() CancelToken? cancelToken]
  );

  @GET('/stores')
  Future<List<Store>> getStores(
    @DioOptions() Options? options,
    [@CancelRequest() CancelToken? cancelToken]
  );
}

// flutter pub run build_runner build --delete-conflicting-outputs