import 'package:hive/hive.dart';

enum View{List, Grid, Detail, Compact, Swipe}

class ViewAdapter extends TypeAdapter<View> {
  @override
  final int typeId = 8;

  @override
  View read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:  
        return View.List;
      case 1:  
        return View.Grid;
      case 2:
        return View.Detail;
      case 3:
        return View.Compact;
      case 4:
        return View.Swipe;
      default:
        return View.List;
    }
  }

  @override
  void write(BinaryWriter writer, View obj) {
    switch (obj) {
      case View.List:
        writer.writeByte(0);
        break;
      case View.Grid:
        writer.writeByte(1);
        break;
      case View.Detail:
        writer.writeByte(2);
        break;
      case View.Compact:
        writer.writeByte(3);
        break;
      case View.Swipe:
        writer.writeByte(4);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
    identical(this, other) ||
    other is ViewAdapter &&
      runtimeType == other.runtimeType &&
      typeId == other.typeId;
}
