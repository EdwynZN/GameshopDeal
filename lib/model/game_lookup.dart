import 'package:hive/hive.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:gameshop_deals/model/cheapest_price.dart';

part 'game_lookup.freezed.dart';
part 'game_lookup.g.dart';

@freezed
class GameLookup with _$GameLookup {
  @HiveType(typeId: 1, adapterName: 'GameLookupAdapter')
  const factory GameLookup({
    @JsonKey(
      disallowNullValue: true,
      required: true,
    ) @HiveField(0) required Info info,
    @JsonKey(
      name: 'cheapestPriceEver',
      disallowNullValue: true,
      required: true,
    ) @HiveField(1) required CheapestPrice cheapestPrice,
    @JsonKey(
      disallowNullValue: true,
      required: true,
    ) @HiveField(2) required List<GameDeal> deals,
  }) = _GameLookup;

  factory GameLookup._fromJsonWithFallback(Map<String, dynamic> json) {
    if (json['info'] == false) json.remove('info');
    return _$GameLookupFromJson(json);
  }

  factory GameLookup.fromJson(Map<String, dynamic> json) =>
    GameLookup._fromJsonWithFallback(json);
}

@freezed
class GameDeal with _$GameDeal {
  @HiveType(typeId: 5, adapterName: 'GameDealAdapter')
  const factory GameDeal({
    @JsonKey(
      name: 'dealID',
      disallowNullValue: true,
      required: true,
    ) @HiveField(0) required String dealId,
    @JsonKey(
      name: 'storeID',
      disallowNullValue: true,
      required: true,
    ) @HiveField(1) required String storeId,
    @JsonKey(
      disallowNullValue: true,
      required: true,
    ) @HiveField(2) required String price,
    @JsonKey(
      disallowNullValue: true,
      required: true,
    ) @HiveField(3) required String retailPrice,
    @HiveField(4) String? savings,
  }) = _GameDeal;

  factory GameDeal.fromJson(Map<String, dynamic> json) => _$GameDealFromJson(json);
}

@freezed
class Info with _$Info {
  @HiveType(typeId: 2, adapterName: 'InfoAdapter')
  const factory Info({
    @JsonKey(
      disallowNullValue: true,
      required: true,
    ) @HiveField(0) required String title,
    @JsonKey(
      name: 'steamAppID',
    ) @HiveField(1) String? steamAppId,
    @JsonKey(
      disallowNullValue: true,
      required: true,
    ) @HiveField(2) required String thumb,
  }) = _Info;

  factory Info.fromJson(Map<String, dynamic> json) => _$InfoFromJson(json);
}