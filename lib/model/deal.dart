import 'package:hive/hive.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'deal.freezed.dart';
part 'deal.g.dart';

int? _stringToInt(String? value) =>
    value == null ? null : double.tryParse(value)?.round();
String? _intToString(int? value) => value?.toString();

String _trimString(String? value) => value?.trim() ?? '';

@freezed
class Deal with _$Deal {
  @HiveType(typeId: 4, adapterName: 'DealAdapter')
  const factory Deal({
    @JsonKey(
      disallowNullValue: true,
      required: true,
    ) @HiveField(0) required String internalName,
    @JsonKey(
      disallowNullValue: true,
      required: true,
      fromJson: _trimString,
    ) @HiveField(1) required String title,
    @HiveField(2) String? metacriticLink,
    @JsonKey(
      name: 'dealID',
      disallowNullValue: true,
      required: true,
    ) @HiveField(3) required String dealId,
    @JsonKey(
      name: 'storeID',
      disallowNullValue: true,
      required: true,
    ) @HiveField(4) required String storeId,
    @JsonKey(
      name: 'gameID',
      disallowNullValue: true,
      required: true,
    ) @HiveField(5) required String gameId,
    @JsonKey(
      disallowNullValue: true,
      required: true,
    ) @HiveField(6) required String salePrice,
    @JsonKey(
      disallowNullValue: true,
      required: true,
    ) @HiveField(7) required String normalPrice,
    @JsonKey(
      disallowNullValue: true,
      required: true,
    ) @HiveField(8) required String isOnSale,
    @JsonKey(fromJson: _stringToInt, toJson: _intToString)
    @HiveField(9) int? savings,
    @JsonKey(
      disallowNullValue: true,
      required: true,
    ) @HiveField(10) required String metacriticScore,
    @HiveField(11) String? steamRatingText,
    @JsonKey(
      disallowNullValue: true,
      required: true,
    ) @HiveField(12) required String steamRatingPercent,
    @JsonKey(
      disallowNullValue: true,
      required: true,
    ) @HiveField(13) required String steamRatingCount,
    @JsonKey(name: 'steamAppID') @HiveField(14) String? steamAppId,
    @JsonKey(
      disallowNullValue: true,
      required: true,
    ) @HiveField(15) required int releaseDate,
    @JsonKey(
      disallowNullValue: true,
      required: true,
    ) @HiveField(16) required int lastChange,
    @JsonKey(
      disallowNullValue: true,
      required: true,
    ) @HiveField(17) required String dealRating,
    @JsonKey(
      disallowNullValue: true,
      required: true,
    ) @HiveField(18) required String thumb,
    @HiveField(19) String? publisher,
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