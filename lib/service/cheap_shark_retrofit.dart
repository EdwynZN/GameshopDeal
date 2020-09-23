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
  Future<List<Deal>> getDeals();

  @GET('/deals?id={id}')
  Future<List<Deal>> getDealsById(@Path('id') String id);

  @GET('/deals')
  Future<List<Deal>> getDealsFromFilter(@Queries() Map<String, dynamic> parameters);

  @GET('/games')
  Future<List<Game>> getGames();

  @GET('/games?id={id}')
  Future<Game> getGamesById(@Path('id') int id);

  @GET('/games?ids={id}')
  Future<List<Game>> getGamesByMultipleId(@Path('id') List<int> id);

  @GET('/stores')
  Future<List<Store>> getStores(@DioOptions() options);
}
