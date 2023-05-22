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
      storeId: (fields[0] as List).cast<String>().toSet(),
      pageSize: fields[1] as int,
      sortBy: fields[2] as SortBy,
      isAscendant: fields[3] as bool,
      lowerPrice: fields[4] as int,
      upperPrice: fields[5] as int,
      metacritic: fields[6] as int,
      steamRating: fields[7] as int,
      steamAppId: (fields[8] as List).cast<String>().toSet(),
      onlyRetail: fields[9] as bool,
      steamWorks: fields[10] as bool,
      onSale: fields[11] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, _$_Filter obj) {
    writer
      ..writeByte(12)
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
      ..writeByte(9)
      ..write(obj.onlyRetail)
      ..writeByte(10)
      ..write(obj.steamWorks)
      ..writeByte(11)
      ..write(obj.onSale)
      ..writeByte(0)
      ..write(obj.storeId.toList())
      ..writeByte(8)
      ..write(obj.steamAppId.toList());
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

_$_Filter _$$_FilterFromJson(Map<String, dynamic> json) => _$_Filter(
      storeId: (json['storeId'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toSet() ??
          {},
      pageSize: json['pageSize'] as int? ?? 60,
      sortBy: $enumDecodeNullable(_$SortByEnumMap, json['sortBy']) ??
          SortBy.Deal_Rating,
      isAscendant:
          json['desc'] == null ? false : _intToBool(json['desc'] as int),
      lowerPrice: json['lowerPrice'] as int? ?? 0,
      upperPrice: json['upperPrice'] as int? ?? 0,
      metacritic: json['metacritic'] as int? ?? 0,
      steamRating: json['steamRating'] as int? ?? 0,
      steamAppId: (json['steamAppId'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toSet() ??
          {},
      onlyRetail: json['AAA'] == null ? false : _intToBool(json['AAA'] as int),
      steamWorks: json['steamWorks'] == null
          ? false
          : _intToBool(json['steamWorks'] as int),
      onSale:
          json['onSale'] == null ? false : _intToBool(json['onSale'] as int),
      title: json['title'] as String? ?? '',
      exact: json['exact'] == null ? false : _intToBool(json['exact'] as int),
    );

Map<String, dynamic> _$$_FilterToJson(_$_Filter instance) => <String, dynamic>{
      'storeId': instance.storeId.toList(),
      'pageSize': instance.pageSize,
      'sortBy': _$SortByEnumMap[instance.sortBy]!,
      'desc': _boolToInt(instance.isAscendant),
      'lowerPrice': instance.lowerPrice,
      'upperPrice': instance.upperPrice,
      'metacritic': instance.metacritic,
      'steamRating': instance.steamRating,
      'steamAppId': instance.steamAppId.toList(),
      'AAA': _boolToInt(instance.onlyRetail),
      'steamWorks': _boolToInt(instance.steamWorks),
      'onSale': _boolToInt(instance.onSale),
      'title': instance.title,
      'exact': _boolToInt(instance.exact),
    };

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
