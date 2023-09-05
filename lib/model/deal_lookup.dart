import 'package:gameshop_deals/model/cheapest_price.dart';
import 'package:gameshop_deals/utils/date_epoch_converter.dart';
import 'package:hive/hive.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'deal_lookup.freezed.dart';
part 'deal_lookup.g.dart';

Map<String, dynamic>? _cheapest(Map<dynamic, dynamic> obj, String? key) {
  final Map<String, dynamic> value = obj[key];
  if (value['date'] == 0) return null;
  return value;
}

@freezed
class DealLookup with _$DealLookup {
  @HiveType(typeId: 5, adapterName: 'DealLookupAdapter')
  const factory DealLookup({
    @JsonKey(
      name: 'gameInfo',
      disallowNullValue: true,
      required: true,
    )
    @HiveField(0)
    required DealLookUpInfo info,
    @JsonKey(
      disallowNullValue: true,
      required: true,
    )
    @HiveField(1)
    required List<CheaperStore> cheaperStores,
    @JsonKey(
      disallowNullValue: true,
      required: true,
      readValue: _cheapest,
    )
    @HiveField(2)
    required CheapestPrice? cheapestPrice,
  }) = _DealLookup;

  factory DealLookup.fromJson(Map<String, dynamic> json) =>
      _$DealLookupFromJson(json);
}

@freezed
class CheaperStore with _$CheaperStore {
  @HiveType(typeId: 6, adapterName: 'CheaperStoreAdapter')
  const factory CheaperStore({
    @JsonKey(
      name: 'dealID',
      disallowNullValue: true,
      required: true,
    )
    @HiveField(0)
    required String dealId,
    @JsonKey(
      name: 'storeID',
      disallowNullValue: true,
      required: true,
    )
    @HiveField(1)
    required String storeId,
    @JsonKey(
      disallowNullValue: true,
      required: true,
    )
    @HiveField(2)
    required String salePrice,
    @JsonKey(
      disallowNullValue: true,
      required: true,
    )
    @HiveField(3)
    required String retailPrice,
  }) = _CheaperStore;

  factory CheaperStore.fromJson(Map<String, dynamic> json) =>
      _$CheaperStoreFromJson(json);
}

String _trimString(String? value) => value?.trim() ?? '';

String? _publisherValidator(String? publisher) => 
  publisher == null || publisher.isEmpty || publisher == 'N/A'
  ? null
  : publisher;

@freezed
class DealLookUpInfo with _$DealLookUpInfo {
  DealLookUpInfo._();

  @HiveType(typeId: 13, adapterName: 'DealLookUpInfoAdapter')
  factory DealLookUpInfo({
    @JsonKey(
      name: 'storeID',
      disallowNullValue: true,
      required: true,
    )
    @HiveField(0)
    required String storeId,
    @JsonKey(
      name: 'gameID',
      disallowNullValue: true,
      required: true,
    )
    @HiveField(1)
    required String gameId,
    @JsonKey(
      disallowNullValue: true,
      required: true,
      fromJson: _trimString,
    )
    @HiveField(2)
    required String name,
    @JsonKey(name: 'steamAppID') @HiveField(3) String? steamAppId,
    @JsonKey(
      disallowNullValue: true,
      required: true,
    )
    @HiveField(4)
    required String salePrice,
    @JsonKey(
      name: 'retailPrice',
      disallowNullValue: true,
      required: true,
    )
    @HiveField(5)
    required String normalPrice,
    @HiveField(6) String? steamRatingText,
    @JsonKey(
      disallowNullValue: true,
      required: true,
    )
    @HiveField(7)
    required String steamRatingPercent,
    @JsonKey(
      disallowNullValue: true,
      required: true,
    )
    @HiveField(8)
    required String steamRatingCount,
    @JsonKey(
      disallowNullValue: true,
      required: true,
    )
    @HiveField(9)
    required String metacriticScore,
    @HiveField(10) String? metacriticLink,
    @DateEpochConverter()
    @JsonKey(
      disallowNullValue: true,
      required: true,
    )
    @HiveField(11)
    required DateTime? releaseDate,
    @JsonKey(fromJson: _publisherValidator)
    @HiveField(12) String? publisher,
    @JsonKey(
      disallowNullValue: true,
      required: true,
    )
    @HiveField(14)
    required String thumb,
  }) = _DealLookUpInfo;

  factory DealLookUpInfo.fromJson(Map<String, dynamic> json) =>
      _$DealLookUpInfoFromJson(json);
}
