import 'package:gameshop_deals/model/cheapest_price.dart';
import 'package:gameshop_deals/model/deal.dart';
import 'package:hive/hive.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'deal_lookup.freezed.dart';
part 'deal_lookup.g.dart';

@freezed
class DealLookup with _$DealLookup{
  @HiveType(typeId: 5, adapterName: 'DealLookupAdapter')
  const factory DealLookup({
    @JsonKey(name: 'gameInfo') @HiveField(0) required Deal deal,
    @HiveField(1) required List<CheaperStore> cheaperStores,
    @HiveField(2) required CheapestPrice cheapestPrice,
  }) = _DealLookup;

  factory DealLookup.fromJson(Map<String, dynamic> json) => _$DealLookupFromJson(json);
}

@freezed
class CheaperStore with _$CheaperStore{
  @HiveType(typeId: 6, adapterName: 'CheaperStoreAdapter')
  const factory CheaperStore({
    @JsonKey(name: 'dealID') @HiveField(0) required String dealId,
    @JsonKey(name: 'storeID') @HiveField(1) required String storeId,
    @HiveField(2) required String salePrice,
    @HiveField(3) required String retailPrice,
  }) = _CheaperStore;

  factory CheaperStore.fromJson(Map<String, dynamic> json) => _$CheaperStoreFromJson(json);
}