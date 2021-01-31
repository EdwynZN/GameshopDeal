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
    @HiveField(19) String publisher,
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
}