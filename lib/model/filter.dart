import 'package:hive/hive.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'sort_by_enum.dart';
part 'filter.freezed.dart';
part 'filter.g.dart';

int _boolToInt(bool value) => value ? 1 : 0;
bool _intToBool(int value) => value == 1;

@freezed
abstract class Filter with _$Filter {
  @HiveType(typeId: 9, adapterName: 'FilterAdapter')
  factory Filter({
    @HiveField(0) @Default(const <int>{}) @JsonKey(defaultValue: const <int>{}) Set<int> storeID,
    @HiveField(1) @Default(60) @JsonKey(defaultValue: 60) int pageSize,
    @HiveField(2) @Default(SortBy.Deal_Rating) SortBy sortBy,
    @HiveField(3) @Default(false) @JsonKey(name: 'desc', defaultValue: false, toJson: _boolToInt, fromJson: _intToBool) bool isAscendant,
    @HiveField(4) @Default(0) @JsonKey(defaultValue: 0) int lowerPrice,
    @HiveField(5) @Default(50) @JsonKey(defaultValue: 0) int upperPrice,
    @HiveField(6) @Default(0) @JsonKey(defaultValue: 0) int metacritic,
    @HiveField(7) @Default(0) @JsonKey(defaultValue: 0) int steamRating,
    @HiveField(8) @Default(const <String>{}) @JsonKey(defaultValue: const <String>{}) Set<String> steamAppId,
    @HiveField(9) @Default(false) @JsonKey(name: 'AAA', defaultValue: false, toJson: _boolToInt, fromJson: _intToBool) bool onlyRetail,
    @HiveField(10) @Default(false) @JsonKey(defaultValue: false, toJson: _boolToInt, fromJson: _intToBool) bool steamWorks,
    @HiveField(11) @Default(false) @JsonKey(defaultValue: false, toJson: _boolToInt, fromJson: _intToBool) bool onSale,
    String title,
    @Default(false) @JsonKey(defaultValue: false, toJson: _boolToInt, fromJson: _intToBool) bool exact,
  }) = _Filter;

  @late
  Map<String, dynamic> get parameters => <String, dynamic>{
    if(storeID.isNotEmpty) 'storeID' : storeID.join(','),
    if(sortBy != SortBy.Deal_Rating) 'sortBy' : describeEnum(sortBy),
    if(pageSize != 60) 'pageSize' : pageSize,
    if(isAscendant) 'desc' : 1,
    if(lowerPrice != 0) 'lowerPrice' : lowerPrice,
    if(upperPrice < 50) 'upperPrice' : upperPrice,
    if(metacritic != 0) 'metacritic' : metacritic,
    if(steamRating > 40) 'steamRating' : steamRating,
    if(steamAppId.isNotEmpty) 'steamAppID ' : steamAppId.join(','),
    if(title != null && title.isNotEmpty) ...<String, dynamic>{
      'title' : title,
      if(exact) 'exact' : 1,
    },
    if(onlyRetail) 'AAA' : 1,
    if(steamWorks) 'steamworks' : 1,
    if(onSale) 'onSale' : 1
  };

  factory Filter.fromJson(Map<String, dynamic> json) => _$FilterFromJson(json);
}