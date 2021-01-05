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

/* 
class Store extends Equatable{
  final String storeId;
  final String storeName;
  final bool isActive;
  final _Images images;

  Store({
    this.storeId,
    this.storeName,
    this.isActive,
    this.images,
  });

  factory Store.fromJson(Map<String, dynamic> json) => Store(
    storeId: json["storeID"],
    storeName: json["storeName"],
    isActive: json["isActive"] == 1,
    images: _Images.fromJson(json["images"]),
  );

  Map<String, dynamic> toJson() => {
    "storeID": storeId,
    "storeName": storeName,
    "isActive": isActive ? 1 : 0,
    "images": images.toJson(),
  };

  @override
  List<Object> get props => [
    storeId,
    storeName,
    isActive,
    images
  ];

}

class _Images extends Equatable{
  final String banner;
  final String logo;
  final String icon;

  _Images({
    this.banner,
    this.logo,
    this.icon,
  });

  factory _Images.fromJson(Map<String, dynamic> json) => _Images(
    banner: json["banner"],
    logo: json["logo"],
    icon: json["icon"],
  );

  Map<String, dynamic> toJson() => {
    "banner": banner,
    "logo": logo,
    "icon": icon,
  };

  @override
  List<Object> get props => [
    banner,
    logo,
    icon
  ];
}
 */