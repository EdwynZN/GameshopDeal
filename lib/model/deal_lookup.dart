import 'package:gameshop_deals/model/cheapest_price.dart';
import 'package:gameshop_deals/model/deal.dart';
import 'package:hive/hive.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'deal_lookup.freezed.dart';
part 'deal_lookup.g.dart';

@freezed
abstract class DealLookup with _$DealLookup{
  @HiveType(typeId: 5, adapterName: 'DealLookupAdapter')
  const factory DealLookup({
    @JsonKey(name: 'gameInfo') @HiveField(0) Deal deal,
    @HiveField(1) List<CheaperStore> cheaperStores,
    @HiveField(2) CheapestPrice cheapestPrice,
  }) = _DealLookup;

  factory DealLookup.fromJson(Map<String, dynamic> json) => _$DealLookupFromJson(json);
}

@freezed
abstract class CheaperStore with _$CheaperStore{
  @HiveType(typeId: 6, adapterName: 'CheaperStoreAdapter')
  const factory CheaperStore({
    @JsonKey(name: 'dealID') @HiveField(0) String dealId,
    @JsonKey(name: 'storeID') @HiveField(1) String storeId,
    @HiveField(2) String salePrice,
    @HiveField(3) String retailPrice,
  }) = _CheaperStore;

  factory CheaperStore.fromJson(Map<String, dynamic> json) => _$CheaperStoreFromJson(json);
}