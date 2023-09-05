import 'package:freezed_annotation/freezed_annotation.dart';

class DateEpochConverter extends JsonConverter<DateTime?, int> {
  const DateEpochConverter();

  @override
  DateTime? fromJson(int dateInMs) {
    if (dateInMs == 0) return null;
    return DateTime.fromMillisecondsSinceEpoch(dateInMs);
  }

  @override
  int toJson(DateTime? date) => date == null ? 0 : date.millisecondsSinceEpoch;
}
