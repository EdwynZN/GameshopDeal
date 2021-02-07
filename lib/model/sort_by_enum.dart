import 'package:hive/hive.dart';

enum SortBy {
  Deal_Rating,
  Title,
  Savings,
  Price,
  Metacritic,
  Reviews,
  Release,
  Store,
  Recent,
}

class SortByAdapter extends TypeAdapter<SortBy> {
  @override
  final int typeId = 10;

  @override
  SortBy read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:  
        return SortBy.Deal_Rating;
      case 1:  
        return SortBy.Title;
      case 2:
        return SortBy.Savings;
      case 3:
        return SortBy.Price;
      case 4:
        return SortBy.Metacritic;
      case 5:
        return SortBy.Reviews;
      case 6:
        return SortBy.Release;
      case 7:
        return SortBy.Store;
      case 8:
        return SortBy.Recent;
      default:
        return SortBy.Deal_Rating;
    }
  }

  @override
  void write(BinaryWriter writer, SortBy obj) {
    switch (obj) {
      case SortBy.Deal_Rating:
        writer.writeByte(0);
        break;
      case SortBy.Title:
        writer.writeByte(1);
        break;
      case SortBy.Savings:
        writer.writeByte(2);
        break;
      case SortBy.Price:
        writer.writeByte(3);
        break;
      case SortBy.Metacritic:
        writer.writeByte(4);
        break;
      case SortBy.Reviews:
        writer.writeByte(5);
        break;
      case SortBy.Release:
        writer.writeByte(6);
        break;
      case SortBy.Store:
        writer.writeByte(7);
        break;
      case SortBy.Recent:
        writer.writeByte(8);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
    identical(this, other) ||
    other is SortByAdapter &&
      runtimeType == other.runtimeType &&
      typeId == other.typeId;
}
