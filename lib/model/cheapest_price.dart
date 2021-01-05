import 'package:hive/hive.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'cheapest_price.freezed.dart';
part 'cheapest_price.g.dart';

@freezed
abstract class CheapestPrice with _$CheapestPrice{
  @HiveType(typeId: 3, adapterName: 'CheapestPriceAdapter')
  const factory CheapestPrice({
    @HiveField(0) String price,
    @HiveField(1) int date,
  }) = _CheapestPrice;

  factory CheapestPrice.fromJson(Map<String, dynamic> json) => _$CheapestPriceFromJson(json);
}

/* 
@HiveType(typeId: 3, adapterName: 'CheapestPrice')
class CheapestPrice extends Equatable {
  @HiveField(0)
  final String price;
  @HiveField(1)
  final int date;

  CheapestPrice({
    this.price,
    this.date,
  });

  factory CheapestPrice.fromJson(Map<String, dynamic> json) => CheapestPrice(
    price: json["price"],
    date: json["date"],
  );

  Map<String, dynamic> toJson() => {
    "price": price,
    "date": date,
  };

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [
        price,
        date,
      ];
}
 */