// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Filter _$_$_FilterFromJson(Map<String, dynamic> json) {
  return _$_Filter(
    storeID: (json['storeID'] as List)?.map((e) => e as int)?.toSet() ?? {},
    pageSize: json['pageSize'] as int ?? 60,
    sortBy: _$enumDecodeNullable(_$SortByEnumMap, json['sortBy']) ??
        SortBy.Deal_Rating,
    isAscendant: _intToBool(json['desc'] as int) ?? false,
    lowerPrice: json['lowerPrice'] as int ?? 0,
    upperPrice: json['upperPrice'] as int ?? 0,
    metacritic: json['metacritic'] as int ?? 0,
    steamRating: json['steamRating'] as int ?? 0,
    onlyRetail: _intToBool(json['AAA'] as int) ?? false,
    steamWorks: _intToBool(json['steamWorks'] as int) ?? false,
    onSale: _intToBool(json['onSale'] as int) ?? false,
  );
}

Map<String, dynamic> _$_$_FilterToJson(_$_Filter instance) => <String, dynamic>{
      'storeID': instance.storeID?.toList(),
      'pageSize': instance.pageSize,
      'sortBy': _$SortByEnumMap[instance.sortBy],
      'desc': _boolToInt(instance.isAscendant),
      'lowerPrice': instance.lowerPrice,
      'upperPrice': instance.upperPrice,
      'metacritic': instance.metacritic,
      'steamRating': instance.steamRating,
      'AAA': _boolToInt(instance.onlyRetail),
      'steamWorks': _boolToInt(instance.steamWorks),
      'onSale': _boolToInt(instance.onSale),
    };

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$SortByEnumMap = {
  SortBy.Deal_Rating: 'Deal_Rating',
  SortBy.Title: 'Title',
  SortBy.Savings: 'Savings',
  SortBy.Price: 'Price',
  SortBy.Metacritic: 'Metacritic',
  SortBy.Reviews: 'Reviews',
  SortBy.Release: 'Release',
  SortBy.Store: 'Store',
  SortBy.Recent: 'Recent',
};
