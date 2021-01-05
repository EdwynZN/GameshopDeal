import 'package:gameshop_deals/model/cheapest_price.dart';
import 'package:gameshop_deals/model/deal.dart';
import 'package:hive/hive.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'deal_lookup.freezed.dart';
part 'deal_lookup.g.dart';

@freezed
abstract class DealLookup with _$DealLookup{
  @HiveType(typeId: 5, adapterName: 'DealLookupAdapter')
  const factory DealLookup({
    @JsonKey(name: 'gameInfo') @HiveField(0) Deal deal,
    @HiveField(1) List<CheaperStore> cheaperStores,
    @HiveField(2) CheapestPrice cheapestPrice,
  }) = _DealLookup;

  factory DealLookup.fromJson(Map<String, dynamic> json) => _$DealLookupFromJson(json);
}

@freezed
abstract class CheaperStore with _$CheaperStore{
  @HiveType(typeId: 6, adapterName: 'CheaperStoreAdapter')
  const factory CheaperStore({
    @JsonKey(name: 'dealID') @HiveField(0) String dealId,
    @JsonKey(name: 'storeID') @HiveField(1) String storeId,
    @HiveField(2) String salePrice,
    @HiveField(3) String retailPrice,
  }) = _CheaperStore;

  factory CheaperStore.fromJson(Map<String, dynamic> json) => _$CheaperStoreFromJson(json);
}
/* 
class DealLookup extends Equatable {
  final Deal deal;
  final List<CheaperStore> cheaperStores;
  final CheapestPrice cheapestPrice;

  DealLookup({
    this.deal,
    this.cheaperStores,
    this.cheapestPrice,
  });

  factory DealLookup.fromJson(Map<String, dynamic> json) => DealLookup(
    deal: Deal.fromJson(json["gameInfo"]),
    cheaperStores: List<CheaperStore>.from(json["cheaperStores"].map((x) => CheaperStore.fromJson(x))),
    cheapestPrice: CheapestPrice.fromJson(json["cheapestPrice"]),
  );

  Map<String, dynamic> toJson() => {
    "gameInfo": deal.toJson(),
    "cheaperStores": List<dynamic>.from(cheaperStores.map((x) => x.toJson())),
    "cheapestPrice": cheapestPrice.toJson(),
  };

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [
    deal,
    cheaperStores,
    cheapestPrice
  ];
}

class CheaperStore extends Equatable{
  final String dealId;
  final String storeId;
  final String salePrice;
  final String retailPrice;

  CheaperStore({
    this.dealId,
    this.storeId,
    this.salePrice,
    this.retailPrice,
  });

  factory CheaperStore.fromJson(Map<String, dynamic> json) => CheaperStore(
    dealId: json["dealID"],
    storeId: json["storeID"],
    salePrice: json["salePrice"],
    retailPrice: json["retailPrice"],
  );

  Map<String, dynamic> toJson() => {
    "dealID": dealId,
    "storeID": storeId,
    "salePrice": salePrice,
    "retailPrice": retailPrice,
  };

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [
    dealId,
    storeId,
    salePrice,
    retailPrice
  ];
}

class GameInfo extends Equatable{
  final String storeId;
  final String gameId;
  final String name;
  final String steamAppId;
  final String salePrice;
  final String retailPrice;
  final String steamRatingText;
  final String steamRatingPercent;
  final String steamRatingCount;
  final String metacriticScore;
  final String metacriticLink;
  final int releaseDate;
  final String publisher;
  final String steamworks;
  final String thumb;

  GameInfo({
    this.storeId,
    this.gameId,
    this.name,
    this.steamAppId,
    this.salePrice,
    this.retailPrice,
    this.steamRatingText,
    this.steamRatingPercent,
    this.steamRatingCount,
    this.metacriticScore,
    this.metacriticLink,
    this.releaseDate,
    this.publisher,
    this.steamworks,
    this.thumb,
  });

  factory GameInfo.fromJson(Map<String, dynamic> json) => GameInfo(
    storeId: json["storeID"],
    gameId: json["gameID"],
    name: json["name"]?.trim(),
    steamAppId: json["steamAppID"],
    salePrice: json["salePrice"],
    retailPrice: json["retailPrice"],
    steamRatingText: json["steamRatingText"],
    steamRatingPercent: json["steamRatingPercent"],
    steamRatingCount: json["steamRatingCount"],
    metacriticScore: json["metacriticScore"],
    metacriticLink: json["metacriticLink"],
    releaseDate: json["releaseDate"],
    publisher: json["publisher"],
    steamworks: json["steamworks"],
    thumb: json["thumb"],
  );

  Map<String, dynamic> toJson() => {
    "storeID": storeId,
    "gameID": gameId,
    "name": name,
    "steamAppID": steamAppId,
    "salePrice": salePrice,
    "retailPrice": retailPrice,
    "steamRatingText": steamRatingText,
    "steamRatingPercent": steamRatingPercent,
    "steamRatingCount": steamRatingCount,
    "metacriticScore": metacriticScore,
    "metacriticLink": metacriticLink,
    "releaseDate": releaseDate,
    "publisher": publisher,
    "steamworks": steamworks,
    "thumb": thumb,
  };

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [
    storeId,
    gameId,
    name,
    steamAppId,
    salePrice,
    retailPrice,
    steamRatingText,
    steamRatingPercent,
    steamRatingCount,
    metacriticScore,
    metacriticLink,
    releaseDate,
    publisher,
    steamworks,
    thumb,
  ];
}
 */