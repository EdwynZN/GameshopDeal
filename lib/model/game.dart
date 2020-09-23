import 'dart:convert';
import 'package:equatable/equatable.dart';

List<Game> gameFromJson(String str) => List<Game>.from(json.decode(str).map((x) => Game.fromJson(x)));

String gameToJson(List<Game> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Game extends Equatable{
  final String gameId;
  final String steamAppId;
  final String cheapest;
  final String cheapestDealId;
  final String gameExternal;
  final String internalName;
  final String thumb;

  Game({
    this.gameId,
    this.steamAppId,
    this.cheapest,
    this.cheapestDealId,
    this.gameExternal,
    this.internalName,
    this.thumb,
  });

  factory Game.fromJson(Map<String, dynamic> json) => Game(
    gameId: json["gameID"],
    steamAppId: json["steamAppID"],
    cheapest: json["cheapest"],
    cheapestDealId: json["cheapestDealID"],
    gameExternal: json["external"],
    internalName: json["internalName"],
    thumb: json["thumb"],
  );

  Map<String, dynamic> toJson() => {
    "gameID": gameId,
    "steamAppID": steamAppId,
    "cheapest": cheapest,
    "cheapestDealID": cheapestDealId,
    "external": gameExternal,
    "internalName": internalName,
    "thumb": thumb,
  };

  @override
  List<Object> get props => [
    gameId,
    steamAppId,
    cheapest,
    cheapestDealId,
    gameExternal,
    internalName,
    thumb
  ];
}