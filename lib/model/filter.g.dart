// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filter.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FilterAdapter extends TypeAdapter<_$_Filter> {
  @override
  final int typeId = 9;

  @override
  _$_Filter read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _$_Filter(
      storeId: (fields[0] as List)?.cast<String>().toSet(),
      pageSize: fields[1] as int,
      sortBy: fields[2] as SortBy,
      isAscendant: fields[3] as bool,
      lowerPrice: fields[4] as int,
      upperPrice: fields[5] as int,
      metacritic: fields[6] as int,
      steamRating: fields[7] as int,
      steamAppId: (fields[8] as List)?.cast<String>().toSet(),
      onlyRetail: fields[9] as bool,
      steamWorks: fields[10] as bool,
      onSale: fields[11] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, _$_Filter obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.storeId?.toList())
      ..writeByte(1)
      ..write(obj.pageSize)
      ..writeByte(2)
      ..write(obj.sortBy)
      ..writeByte(3)
      ..write(obj.isAscendant)
      ..writeByte(4)
      ..write(obj.lowerPrice)
      ..writeByte(5)
      ..write(obj.upperPrice)
      ..writeByte(6)
      ..write(obj.metacritic)
      ..writeByte(7)
      ..write(obj.steamRating)
      ..writeByte(8)
      ..write(obj.steamAppId?.toList())
      ..writeByte(9)
      ..write(obj.onlyRetail)
      ..writeByte(10)
      ..write(obj.steamWorks)
      ..writeByte(11)
      ..write(obj.onSale);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FilterAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Filter _$_$_FilterFromJson(Map<String, dynamic> json) {
  return _$_Filter(
    storeId: (json['storeId'] as List)?.map((e) => e as String)?.toSet() ?? {},
    pageSize: json['pageSize'] as int ?? 60,
    sortBy: _$enumDecodeNullable(_$SortByEnumMap, json['sortBy']) ??
        SortBy.Deal_Rating,
    isAscendant: _intToBool(json['desc'] as int) ?? false,
    lowerPrice: json['lowerPrice'] as int ?? 0,
    upperPrice: json['upperPrice'] as int ?? 0,
    metacritic: json['metacritic'] as int ?? 0,
    steamRating: json['steamRating'] as int ?? 0,
    steamAppId:
        (json['steamAppId'] as List)?.map((e) => e as String)?.toSet() ?? {},
    onlyRetail: _intToBool(json['AAA'] as int) ?? false,
    steamWorks: _intToBool(json['steamWorks'] as int) ?? false,
    onSale: _intToBool(json['onSale'] as int) ?? false,
    title: json['title'] as String,
    exact: _intToBool(json['exact'] as int) ?? false,
  );
}

Map<String, dynamic> _$_$_FilterToJson(_$_Filter instance) => <String, dynamic>{
      'storeId': instance.storeId?.toList(),
      'pageSize': instance.pageSize,
      'sortBy': _$SortByEnumMap[instance.sortBy],
      'desc': _boolToInt(instance.isAscendant),
      'lowerPrice': instance.lowerPrice,
      'upperPrice': instance.upperPrice,
      'metacritic': instance.metacritic,
      'steamRating': instance.steamRating,
      'steamAppId': instance.steamAppId?.toList(),
      'AAA': _boolToInt(instance.onlyRetail),
      'steamWorks': _boolToInt(instance.steamWorks),
      'onSale': _boolToInt(instance.onSale),
      'title': instance.title,
      'exact': _boolToInt(instance.exact),
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
