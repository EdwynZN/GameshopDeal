import 'package:equatable/equatable.dart';

class CheapestPrice extends Equatable{
  final String price;
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