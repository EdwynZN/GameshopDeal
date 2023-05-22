import 'package:freezed_annotation/freezed_annotation.dart';

part 'store.freezed.dart';
part 'store.g.dart';

int _boolToInt(bool value) => value ? 1 : 0;
bool _intToBool(int value) => value == 1;

@freezed
class Store with _$Store{
  const factory Store({
    @JsonKey(
      name: 'storeID',
      disallowNullValue: true,
      required: true,
    ) required String storeId,
    required String storeName,
    @JsonKey(
      disallowNullValue: true,
      required: true,
      fromJson: _intToBool,
      toJson: _boolToInt,
    ) required bool isActive,
    required _Images images,
  }) = _Store;

  factory Store.fromJson(Map<String, dynamic> json) => _$StoreFromJson(json);
}

@freezed
class _Images with _$_Images{
  const factory _Images({
    @JsonKey(
      disallowNullValue: true,
      required: true,
    ) required String banner,
    @JsonKey(
      disallowNullValue: true,
      required: true,
    ) required String logo,
    @JsonKey(
      disallowNullValue: true,
      required: true,
    ) required String icon
  }) = __Images;

  factory _Images.fromJson(Map<String, dynamic> json) => _$_ImagesFromJson(json);
}