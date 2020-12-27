// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deal_test.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Deal _$_$_DealFromJson(Map<String, dynamic> json) {
  return _$_Deal(
    internalName: json['internalName'] as String,
    title: _trimString(json['title'] as String),
    metacriticLink: json['metacriticLink'] as String,
    dealId: json['dealId'] as String,
    storeId: json['storeId'] as String,
    gameId: json['gameId'] as String,
    salePrice: json['salePrice'] as String,
    normalPrice: json['normalPrice'] as String,
    isOnSale: json['isOnSale'] as String,
    savings: _stringToInt(json['savings'] as String),
    metacriticScore: json['metacriticScore'] as String,
    steamRatingText: json['steamRatingText'] as String,
    steamRatingPercent: json['steamRatingPercent'] as String,
    steamRatingCount: json['steamRatingCount'] as String,
    steamAppId: json['steamAppId'] as String,
    releaseDate: json['releaseDate'] as int,
    lastChange: json['lastChange'] as int,
    dealRating: json['dealRating'] as String,
    thumb: json['thumb'] as String,
  );
}

Map<String, dynamic> _$_$_DealToJson(_$_Deal instance) => <String, dynamic>{
      'internalName': instance.internalName,
      'title': instance.title,
      'metacriticLink': instance.metacriticLink,
      'dealId': instance.dealId,
      'storeId': instance.storeId,
      'gameId': instance.gameId,
      'salePrice': instance.salePrice,
      'normalPrice': instance.normalPrice,
      'isOnSale': instance.isOnSale,
      'savings': _intToString(instance.savings),
      'metacriticScore': instance.metacriticScore,
      'steamRatingText': instance.steamRatingText,
      'steamRatingPercent': instance.steamRatingPercent,
      'steamRatingCount': instance.steamRatingCount,
      'steamAppId': instance.steamAppId,
      'releaseDate': instance.releaseDate,
      'lastChange': instance.lastChange,
      'dealRating': instance.dealRating,
      'thumb': instance.thumb,
    };
