import 'dart:convert';
import 'package:equatable/equatable.dart';

List<Deal> dealFromJson(String str) => List<Deal>.from(json.decode(str).map((x) => Deal.fromJson(x)));

String dealToJson(List<Deal> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DealResponse{
  List<Deal> deals;
  String error;

  DealResponse({this.deals, this.error});

  factory DealResponse.withJsonResponse(List<dynamic> json) =>
    DealResponse(
      deals: List<Deal>.from(json.map((x) => Deal.fromJson(x)))
    );

  factory DealResponse.withError(String error) => DealResponse(error: error);

  bool get hasData => deals != null;

  bool get hasError => error != null;

}

class Deal extends Equatable{
  final String internalName;
  final String title;
  final String metacriticLink;
  final String dealId;
  final String storeId;
  final String gameId;
  final String salePrice;
  final String normalPrice;
  final String isOnSale;
  final int savings;
  final String metacriticScore;
  final String steamRatingText;
  final String steamRatingPercent;
  final String steamRatingCount;
  final String steamAppId;
  final int releaseDate;
  final int lastChange;
  final String dealRating;
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
    title: json["title"]?.trim(),
    metacriticLink: json["metacriticLink"],
    dealId: json["dealID"],
    storeId: json["storeID"],
    gameId: json["gameID"],
    salePrice: json["salePrice"],
    normalPrice: json["normalPrice"],
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
