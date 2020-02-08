import 'dart:convert';

List<Store> storeFromJson(String str) => List<Store>.from(json.decode(str).map((x) => Store.fromJson(x)));

String storeToJson(List<Store> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Store {
  final String storeId;
  final String storeName;
  final int isActive;
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
    isActive: json["isActive"],
    images: _Images.fromJson(json["images"]),
  );

  Map<String, dynamic> toJson() => {
    "storeID": storeId,
    "storeName": storeName,
    "isActive": isActive,
    "images": images.toJson(),
  };
}

class _Images {
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
}
