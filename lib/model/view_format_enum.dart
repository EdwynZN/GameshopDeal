import 'package:hive/hive.dart';

enum ViewFormat { List, Grid, Detail, Compact, Swipe }

class ViewFormatAdapter extends TypeAdapter<ViewFormat> {
  @override
  final int typeId = 8;

  @override
  ViewFormat read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return ViewFormat.List;
      case 1:
        return ViewFormat.Grid;
      case 2:
        return ViewFormat.Detail;
      case 3:
        return ViewFormat.Compact;
      case 4:
        return ViewFormat.Swipe;
      default:
        return ViewFormat.List;
    }
  }

  @override
  void write(BinaryWriter writer, ViewFormat obj) {
    switch (obj) {
      case ViewFormat.List:
        writer.writeByte(0);
        break;
      case ViewFormat.Grid:
        writer.writeByte(1);
        break;
      case ViewFormat.Detail:
        writer.writeByte(2);
        break;
      case ViewFormat.Compact:
        writer.writeByte(3);
        break;
      case ViewFormat.Swipe:
        writer.writeByte(4);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ViewFormatAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
