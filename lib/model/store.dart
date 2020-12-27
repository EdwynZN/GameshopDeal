import 'dart:convert';
import 'package:equatable/equatable.dart';

List<Store> storeFromJson(List<dynamic> json) => List<Store>.from(json.map((x) => Store.fromJson(x)));

String storeToJson(List<Store> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

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
