import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:gameshop_deals/model/deal.dart';
import 'package:gameshop_deals/model/game.dart';
import 'package:gameshop_deals/model/store.dart';

part 'cheap_shark_retrofit.g.dart';

@RestApi(baseUrl: "https://www.cheapshark.com/api/1.0/")
abstract class DiscountApi{
  factory DiscountApi(Dio dio, {String baseUrl}) = _DiscountApi;

  @GET('/deals')
  Future<List<Deal>> getDeals([@CancelRequest() CancelToken cancelToken]);

  @GET('/deals?id={id}')
  Future<List<Deal>> getDealsById(
    @Path('id') String id,
    [@CancelRequest() CancelToken cancelToken]
  );

  @GET('/deals')
  Future<List<Deal>> getDealsFromFilter(
    @Queries() Map<String, dynamic> parameters,
    [@CancelRequest() CancelToken cancelToken]
  );

  @GET('/games')
  Future<List<Game>> getGames([@CancelRequest() CancelToken cancelToken]);

  @GET('/games?id={id}')
  Future<Game> getGamesById(
    @Path('id') int id,
    [@CancelRequest() CancelToken cancelToken]
  );

  @GET('/games?ids={id}')
  Future<List<Game>> getGamesByMultipleId(
    @Path('id') List<int> id,
    [@CancelRequest() CancelToken cancelToken]
  );

  @GET('/stores')
  Future<List<Store>> getStores(
    @DioOptions() options,
    [@CancelRequest() CancelToken cancelToken]
  );
}
