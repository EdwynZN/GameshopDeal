import 'package:hive/hive.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'preference.freezed.dart';
part 'preference.g.dart';

@freezed
abstract class Preference with _$Preference {

  @HiveType(typeId: 11, adapterName: 'PreferenceAdapter')
  const factory Preference({
    @HiveField(0) @Default(false) bool webView,
  }) = _Preference;
	
}