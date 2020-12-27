import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:gameshop_deals/model/deal.dart';
import 'package:gameshop_deals/model/cheapest_price_model.dart';

Map<String, GameLookup> gameLookupFromJson(String str) => Map.from(json.decode(str)).map((k, v) => MapEntry<String, GameLookup>(k, GameLookup.fromJson(v)));

String gameLookupToJson(Map<String, GameLookup> data) => json.encode(Map.from(data).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())));

class GameLookup extends Equatable{
  final Info info;
  final CheapestPrice cheapestPrice;
  final List<Deal> deals;

  GameLookup({
    this.info,
    this.cheapestPrice,
    this.deals,
  });

  factory GameLookup.fromJson(Map<String, dynamic> json) => GameLookup(
    info: json["info"] == false ? null : Info.fromJson(json["info"]),
    cheapestPrice: CheapestPrice.fromJson(json["cheapestPriceEver"]),
    deals: List<Deal>.from(json["deals"].map((x) => Deal.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "info": info.toJson(),
    "cheapestPriceEver": cheapestPrice.toJson(),
    "deals": List<dynamic>.from(deals.map((x) => x.toJson())),
  };

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [
    info,
    cheapestPrice,
    deals
  ];
}

class Info extends Equatable{
  final String title;
  final String steamAppId;
  final String thumb;

  Info({
    this.title,
    this.steamAppId,
    this.thumb,
  });

  factory Info.fromJson(Map<String, dynamic> json) => Info(
    title: json["title"]?.trim(),
    steamAppId: json["steamAppID"],
    thumb: json["thumb"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "steamAppID": steamAppId,
    "thumb": thumb,
  };

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [
    title,
    steamAppId,
    thumb
  ];
}
