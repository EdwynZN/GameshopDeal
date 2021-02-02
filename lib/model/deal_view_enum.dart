import 'package:hive/hive.dart';

enum DealView{List, Grid, Detail, Compact, Swipe}

class DealVieweAdapter extends TypeAdapter<DealView> {
  @override
  final int typeId = 8;

  @override
  DealView read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:  
        return DealView.List;
      case 1:  
        return DealView.Grid;
      case 2:
        return DealView.Detail;
      case 3:
        return DealView.Compact;
      case 4:
        return DealView.Swipe;
      default:
        return DealView.List;
    }
  }

  @override
  void write(BinaryWriter writer, DealView obj) {
    switch (obj) {
      case DealView.List:
        writer.writeByte(0);
        break;
      case DealView.Grid:
        writer.writeByte(1);
        break;
      case DealView.Detail:
        writer.writeByte(2);
        break;
      case DealView.Compact:
        writer.writeByte(3);
        break;
      case DealView.Swipe:
        writer.writeByte(4);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
    identical(this, other) ||
    other is DealVieweAdapter &&
      runtimeType == other.runtimeType &&
      typeId == other.typeId;
}