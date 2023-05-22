import 'package:hive/hive.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'cheapest_price.freezed.dart';
part 'cheapest_price.g.dart';

@freezed
class CheapestPrice with _$CheapestPrice{
  @HiveType(typeId: 3, adapterName: 'CheapestPriceAdapter')
  const factory CheapestPrice({
    @JsonKey(
      disallowNullValue: true,
      required: true,
    ) @HiveField(0) required String price,
    @JsonKey(
      disallowNullValue: true,
      required: true,
    ) @HiveField(1) required int date,
  }) = _CheapestPrice;

  factory CheapestPrice.fromJson(Map<String, dynamic> json) => _$CheapestPriceFromJson(json);
}