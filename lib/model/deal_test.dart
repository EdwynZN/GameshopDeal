import 'package:freezed_annotation/freezed_annotation.dart';

part 'deal_test.freezed.dart';
part 'deal_test.g.dart';

int _stringToInt(String value) => value == null ? null : double.tryParse(value)?.round();
String _intToString(int value) => value?.toString();
String _trimString(String value) => value?.trim();

@freezed
abstract class Deal with _$Deal {
  factory Deal({
    String internalName,
    @JsonKey(fromJson: _trimString) String title,
    String metacriticLink,
    String dealId,
    String storeId,
    String gameId,
    String salePrice,
    String normalPrice,
    String isOnSale,
    @JsonKey(fromJson: _stringToInt, toJson: _intToString) int savings,
    String metacriticScore,
    String steamRatingText,
    String steamRatingPercent,
    String steamRatingCount,
    String steamAppId,
    int releaseDate,
    int lastChange,
    String dealRating,
    String thumb
  }) = _Deal;

  factory Deal.fromJson(Map<String, dynamic> json) => _$DealFromJson(json..putIfAbsent('title', () => json['name']));
}