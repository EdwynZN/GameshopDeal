import 'package:hive/hive.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:gameshop_deals/model/deal.dart';
import 'package:gameshop_deals/model/cheapest_price.dart';

part 'game_lookup.freezed.dart';
part 'game_lookup.g.dart';

@freezed
abstract class GameLookup with _$GameLookup {
  @HiveType(typeId: 1, adapterName: 'GameLookupAdapter')
  const factory GameLookup({
    @HiveField(0) Info info,
    @JsonKey(name: 'cheapestPriceEver')
    @HiveField(1) CheapestPrice cheapestPrice,
    @HiveField(2) List<Deal> deals,
  }) = _GameLookup;

  factory GameLookup._fromJsonWithFallback(Map<String, dynamic> json) {
    if (json['info'] == false) json.remove('info');
    return _$GameLookupFromJson(json);
  }

  factory GameLookup.fromJson(Map<String, dynamic> json) =>
    GameLookup._fromJsonWithFallback(json);
}

@freezed
abstract class Info with _$Info {
  @HiveType(typeId: 2, adapterName: 'InfoAdapter')
  const factory Info({
    @HiveField(0) String title,
    @JsonKey(name: 'steamAppID') @HiveField(1) String steamAppId,
    @HiveField(2) String thumb,
  }) = _Info;

  factory Info.fromJson(Map<String, dynamic> json) => _$InfoFromJson(json);
}