import 'package:hive/hive.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'deal.freezed.dart';
part 'deal.g.dart';

int _stringToInt(String value) =>
    value == null ? null : double.tryParse(value)?.round();
String _intToString(int value) => value?.toString();

String _trimString(String value) => value?.trim();

@freezed
abstract class Deal with _$Deal {
  @HiveType(typeId: 4, adapterName: 'DealAdapter')
  const factory Deal({
    @HiveField(0) String internalName,
    @JsonKey(fromJson: _trimString) @HiveField(1) String title,
    @HiveField(2) String metacriticLink,
    @JsonKey(name: 'dealID') @HiveField(3) String dealId,
    @JsonKey(name: 'storeID') @HiveField(4) String storeId,
    @JsonKey(name: 'gameID') @HiveField(5) String gameId,
    @HiveField(6) String salePrice,
    @HiveField(7) String normalPrice,
    @HiveField(8) String isOnSale,
    @JsonKey(fromJson: _stringToInt, toJson: _intToString)
    @HiveField(9) int savings,
    @HiveField(10) String metacriticScore,
    @HiveField(11) String steamRatingText,
    @HiveField(12) String steamRatingPercent,
    @HiveField(13) String steamRatingCount,
    @JsonKey(name: 'steamAppID') @HiveField(14) String steamAppId,
    @HiveField(15) int releaseDate,
    @HiveField(16) int lastChange,
    @HiveField(17) String dealRating,
    @HiveField(18) String thumb,
  }) = _Deal;

  factory Deal._fromJsonWithFallback(Map<String, dynamic> json) {
    if (json.containsKey('price')) {
      json['salePrice'] = json.remove('price');
    }
    if (json.containsKey('retailPrice')) {
      json['normalPrice'] = json.remove('retailPrice');
    }
    if (json.containsKey('name')) {
      json['title'] = json.remove('name');
    }
    return _$DealFromJson(json);
  }

  factory Deal.fromJson(Map<String, dynamic> json) => Deal._fromJsonWithFallback(json);

  /* factory Deal.fromJson(Map<String, dynamic> json) 
    => _$DealFromJson(json
    ..putIfAbsent('title', () => json['name'])
    ..putIfAbsent('salePrice', () => json['price'])
    ..putIfAbsent('normalPrice', () => json['retailPrice'])
  ); */
}
/* 
@HiveType(typeId: 4, adapterName: 'Deal')
class Deal extends Equatable{
  @HiveField(0)
  final String internalName;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String metacriticLink;
  @HiveField(3)
  final String dealId;
  @HiveField(4)
  final String storeId;
  @HiveField(5)
  final String gameId;
  @HiveField(6)
  final String salePrice;
  @HiveField(7)
  final String normalPrice;
  @HiveField(8)
  final String isOnSale;
  @HiveField(9)
  final int savings;
  @HiveField(10)
  final String metacriticScore;
  @HiveField(11)
  final String steamRatingText;
  @HiveField(12)
  final String steamRatingPercent;
  @HiveField(13)
  final String steamRatingCount;
  @HiveField(14)
  final String steamAppId;
  @HiveField(15)
  final int releaseDate;
  @HiveField(16)
  final int lastChange;
  @HiveField(17)
  final String dealRating;
  @HiveField(18)
  final String thumb;

  Deal({
    this.internalName,
    this.title,
    this.metacriticLink,
    this.dealId,
    this.storeId,
    this.gameId,
    this.salePrice,
    this.normalPrice,
    this.isOnSale,
    this.savings,
    this.metacriticScore,
    this.steamRatingText,
    this.steamRatingPercent,
    this.steamRatingCount,
    this.steamAppId,
    this.releaseDate,
    this.lastChange,
    this.dealRating,
    this.thumb,
  });

  factory Deal.fromJson(Map<String, dynamic> json) => Deal(
    internalName: json["internalName"],
    title: (json["title"] ?? json['name'])?.trim(),
    metacriticLink: json["metacriticLink"],
    dealId: json["dealID"],
    storeId: json["storeID"],
    gameId: json["gameID"],
    salePrice: json["salePrice"] ?? json['price'],
    normalPrice: json["normalPrice"] ?? json['retailPrice'],
    isOnSale: json["isOnSale"],
    savings: json["savings"] == null ? null : double.tryParse(json["savings"])?.round(),
    metacriticScore: json["metacriticScore"],
    steamRatingText: json["steamRatingText"],
    steamRatingPercent: json["steamRatingPercent"],
    steamRatingCount: json["steamRatingCount"],
    steamAppId: json["steamAppID"],
    releaseDate: json["releaseDate"],
    lastChange: json["lastChange"],
    dealRating: json["dealRating"],
    thumb: json["thumb"],
  );

  Map<String, dynamic> toJson() => {
    "internalName": internalName,
    "title": title,
    "metacriticLink": metacriticLink,
    "dealID": dealId,
    "storeID": storeId,
    "gameID": gameId,
    "salePrice": salePrice,
    "normalPrice": normalPrice,
    "isOnSale": isOnSale,
    "savings": savings,
    "metacriticScore": metacriticScore,
    "steamRatingText": steamRatingText,
    "steamRatingPercent": steamRatingPercent,
    "steamRatingCount": steamRatingCount,
    "steamAppID": steamAppId,
    "releaseDate": releaseDate,
    "lastChange": lastChange,
    "dealRating": dealRating,
    "thumb": thumb,
  };

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [
    internalName,
    title,
    metacriticLink,
    dealId,
    storeId,
    gameId,
    salePrice,
    normalPrice,
    isOnSale,
    savings,
    metacriticScore,
    steamRatingText,
    steamRatingPercent,
    steamRatingCount,
    steamAppId,
    releaseDate,
    lastChange,
    dealRating,
    thumb,
  ];
}
 */
