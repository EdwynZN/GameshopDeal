import 'package:hive/hive.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'game.freezed.dart';
part 'game.g.dart';

@freezed
class Game with _$Game{
  @HiveType(typeId: 0, adapterName: 'GameAdapter')
  const factory Game({
    @JsonKey(
      name: 'gameID',
      disallowNullValue: true,
      required: true,
    ) @HiveField(0) required String gameId,
    @JsonKey(
      name: 'steamAppID',
      disallowNullValue: true,
      required: true,
    ) @HiveField(1) required String steamAppId,
    @JsonKey(
      disallowNullValue: true,
      required: true,
    ) @HiveField(2) required String cheapest,
    @JsonKey(
      name: 'cheapestDealID',
      disallowNullValue: true,
      required: true,
    ) @HiveField(3) required String cheapestDealId,
    @JsonKey(
      name: 'external',
      disallowNullValue: true,
      required: true,
    ) @HiveField(4) required String externalName,
    @JsonKey(
      name: 'internalName',
      disallowNullValue: true,
      required: true,
    ) @HiveField(5) required String internalName,
    @JsonKey(
      name: 'thumb',
      disallowNullValue: true,
      required: true,
    ) @HiveField(6) required String thumb,
  }) = _Game;

  factory Game.fromJson(Map<String, dynamic> json) => _$GameFromJson(json);
}