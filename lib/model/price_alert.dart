import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'price_alert.freezed.dart';
part 'price_alert.g.dart';

@freezed
abstract class PriceAlert with _$PriceAlert {

  @HiveType(typeId: 12, adapterName: 'PriceAlertAdapter')
  const factory PriceAlert({
    @HiveField(0) @Default(0.0) double price,
    @HiveField(1) @Default(const <String>{}) Set<String> storeId,
  }) = _PriceAlert;
	
}