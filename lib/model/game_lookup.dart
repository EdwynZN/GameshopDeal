import 'package:hive/hive.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:gameshop_deals/model/deal.dart';
import 'package:gameshop_deals/model/cheapest_price.dart';

part 'game_lookup.freezed.dart';
part 'game_lookup.g.dart';

@freezed
class GameLookup with _$GameLookup {
  @HiveType(typeId: 1, adapterName: 'GameLookupAdapter')
  const factory GameLookup({
    @HiveField(0) required Info info,
    @JsonKey(name: 'cheapestPriceEver')
    @HiveField(1) required CheapestPrice cheapestPrice,
    @HiveField(2) required List<Deal> deals,
  }) = _GameLookup;

  factory GameLookup._fromJsonWithFallback(Map<String, dynamic> json) {
    if (json['info'] == false) json.remove('info');
    return _$GameLookupFromJson(json);
  }

  factory GameLookup.fromJson(Map<String, dynamic> json) =>
    GameLookup._fromJsonWithFallback(json);
}

@freezed
class Info with _$Info {
  @HiveType(typeId: 2, adapterName: 'InfoAdapter')
  const factory Info({
    @HiveField(0) required String title,
    @JsonKey(name: 'steamAppID') @HiveField(1) required String steamAppId,
    @HiveField(2) required String thumb,
  }) = _Info;

  factory Info.fromJson(Map<String, dynamic> json) => _$InfoFromJson(json);
}