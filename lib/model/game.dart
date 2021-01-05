import 'package:hive/hive.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'game.freezed.dart';
part 'game.g.dart';

@freezed
abstract class Game with _$Game{
  @HiveType(typeId: 0, adapterName: 'GameAdapter')
  const factory Game({
    @JsonKey(name: 'gameID') @HiveField(0) String gameId,
    @JsonKey(name: 'steamAppID') @HiveField(1) String steamAppId,
    @HiveField(2) String cheapest,
    @JsonKey(name: 'cheapestDealID') @HiveField(3) String cheapestDealId,
    @JsonKey(name: 'external') @HiveField(4) String externalName,
    @JsonKey(name: 'internalName') @HiveField(5) String internalName,
    @JsonKey(name: 'thumb') @HiveField(6) String thumb,
  }) = _Game;

  factory Game.fromJson(Map<String, dynamic> json) => _$GameFromJson(json);
}

/* 
@HiveType(typeId: 0, adapterName: 'Game')
class Game extends Equatable {
  @HiveField(0)
  final String gameId;
  @HiveField(1)
  final String steamAppId;
  @HiveField(2)
  final String cheapest;
  @HiveField(3)
  final String cheapestDealId;
  @HiveField(4)
  final String externalName;
  @HiveField(5)
  final String internalName;
  @HiveField(6)
  final String thumb;

  Game({
    this.gameId,
    this.steamAppId,
    this.cheapest,
    this.cheapestDealId,
    this.externalName,
    this.internalName,
    this.thumb,
  });

  factory Game.fromJson(Map<String, dynamic> json) => Game(
        gameId: json["gameID"],
        steamAppId: json["steamAppID"],
        cheapest: json["cheapest"],
        cheapestDealId: json["cheapestDealID"],
        externalName: json["external"],
        internalName: json["internalName"],
        thumb: json["thumb"],
      );

  Map<String, dynamic> toJson() => {
        "gameID": gameId,
        "steamAppID": steamAppId,
        "cheapest": cheapest,
        "cheapestDealID": cheapestDealId,
        "external": externalName,
        "internalName": internalName,
        "thumb": thumb,
      };

  @override
  List<Object> get props => [
        gameId,
        steamAppId,
        cheapest,
        cheapestDealId,
        externalName,
        internalName,
        thumb
      ];
}
 */