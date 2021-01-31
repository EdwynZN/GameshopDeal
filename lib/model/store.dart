import 'package:freezed_annotation/freezed_annotation.dart';

part 'store.freezed.dart';
part 'store.g.dart';

int _boolToInt(bool value) => value ? 1 : 0;
bool _intToBool(int value) => value == 1;

@freezed
abstract class Store with _$Store{
  const factory Store({
    @JsonKey(name: 'storeID') String storeId,
    String storeName,
    @JsonKey(fromJson: _intToBool, toJson: _boolToInt) bool isActive,
    _Images images,
  }) = _Store;

  factory Store.fromJson(Map<String, dynamic> json) => _$StoreFromJson(json);
}

@freezed
abstract class _Images with _$_Images{
  const factory _Images({
    // ignore: unused_element
    String banner,
    // ignore: unused_element
    String logo,
    // ignore: unused_element
    String icon
  }) = __Images;

  factory _Images.fromJson(Map<String, dynamic> json) => _$_ImagesFromJson(json);
}