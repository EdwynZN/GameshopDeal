import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
part 'filter.freezed.dart';
part 'filter.g.dart';

int _boolToInt(bool value) => value ? 1 : 0;
bool _intToBool(int value) => value == 1;

@freezed
abstract class Filter with _$Filter {
  factory Filter({
    @Default(const <int>{}) @JsonKey(defaultValue: const <int>{}) Set<int> storeID,
    // @Default(0) @JsonKey(defaultValue: 0) int pageNumber,
    @Default(60) @JsonKey(defaultValue: 60) int pageSize,
    @Default(SortBy.Deal_Rating) SortBy sortBy,
    @Default(false) @JsonKey(name: 'desc', defaultValue: false, toJson: _boolToInt, fromJson: _intToBool) bool isAscendant,
    @Default(0) @JsonKey(defaultValue: 0) int lowerPrice,
    @Default(50) @JsonKey(defaultValue: 0) int upperPrice,
    @Default(0) @JsonKey(defaultValue: 0) int metacritic,
    @Default(0) @JsonKey(defaultValue: 0) int steamRating,
    @Default(const <String>{}) @JsonKey(defaultValue: const <String>{}) Set<String> steamAppId,
    String title,
    @Default(false) @JsonKey(defaultValue: false, toJson: _boolToInt, fromJson: _intToBool) bool exact,
    @Default(false) @JsonKey(name: 'AAA', defaultValue: false, toJson: _boolToInt, fromJson: _intToBool) bool onlyRetail,
    @Default(false) @JsonKey(defaultValue: false, toJson: _boolToInt, fromJson: _intToBool) bool steamWorks,
    @Default(false) @JsonKey(defaultValue: false, toJson: _boolToInt, fromJson: _intToBool) bool onSale,
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

enum SortBy{
  Deal_Rating,
  Title,
  Savings,
  Price,
  Metacritic,
  Reviews,
  Release,
  Store,
  Recent
}