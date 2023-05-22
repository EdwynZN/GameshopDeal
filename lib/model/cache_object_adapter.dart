import 'package:flutter_cache_manager/src/storage/cache_object.dart';
import 'package:hive/hive.dart';

class CacheObjectAdapter extends TypeAdapter<CacheObject> {
  @override
  final int typeId = 13;

  @override
  CacheObject read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte() : reader.read(),
    };
    return CacheObject(
      fields[0] as String,
      id: fields[1] as int?,
      key: fields[2] as String?,
      relativePath: fields[3] as String,
      eTag: fields[4] as String?,
      length: fields[5] as int?,
      touched: fields[6] as DateTime?,
      validTill: fields[7] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, CacheObject obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.url)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.key)
      ..writeByte(3)
      ..write(obj.relativePath)
      ..writeByte(4)
      ..write(obj.eTag)
      ..writeByte(5)
      ..write(obj.length)
      ..writeByte(6)
      ..write(obj.touched)
      ..writeByte(7)
      ..write(obj.validTill);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CacheObjectAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
