import 'package:flutter/foundation.dart';

class FilterProvider {
  Set<int> storeId;
  int pageNumber;
  int pageSize;
  SortBy sortBy;
  OrderBy orderBy;
  int lowerPrice;
  int upperPrice;
  int metacritic;
  int steamRating;
  bool onlyRetail;
  bool steamWorks;
  bool onSale;

  FilterProvider({
    Set<int> stores,
    this.pageNumber = 0,
    this.pageSize = 60,
    this.sortBy = SortBy.Deal_Rating,
    this.orderBy = OrderBy.Descendant,
    this.lowerPrice = 0,
    this.upperPrice = 50,
    this.metacritic = 0,
    this.steamRating = 0,
    //this.steamAppId,
    this.onlyRetail = false,
    this.steamWorks = false,
    this.onSale = false
  }) : this.storeId = stores ?? const <int>{};

  FilterProvider copyWith({
      Set<int> stores,
      int pageNumber,
      int pageSize,
      SortBy sortBy,
      OrderBy orderBy,
      int lowerPrice,
      int upperPrice,
      int metacritic,
      int steamRating,
      //this.steamAppId,
      bool onlyRetail,
      bool steamWorks,
      bool onSale
    }) =>
      FilterProvider(
      stores: storeId ?? this.storeId,
      pageSize: pageSize ?? this.pageSize,
      pageNumber: pageNumber ?? this.pageNumber,
      sortBy: sortBy ?? this.sortBy,
      orderBy: orderBy ?? this.orderBy,
      lowerPrice: lowerPrice ?? this.lowerPrice,
      upperPrice: upperPrice ?? this.upperPrice,
      metacritic: metacritic ?? this.metacritic,
      steamRating: steamRating ?? this.steamRating,
      onlyRetail: onlyRetail ?? this.onlyRetail,
      steamWorks: steamWorks ?? this.steamWorks,
      onSale: onSale ?? this.onSale,
    );

  Map<String, dynamic> get parameters => <String, dynamic>{
    if(storeId.isNotEmpty) 'storeID' : storeId.toList(),
    'sortBy' : describeEnum(sortBy).replaceFirst('_', ' '),
    'desc' : orderBy.index,
    'lowerPrice' : lowerPrice,
    'upperPrice' : upperPrice,
    'metacritic' : metacritic,
    'AAA' : onlyRetail ? 1 : 0,
    'steamworks' : steamWorks ? 1 : 0,
    'onSale' : onSale ? 1 : 0
  };

  Map<String, dynamic> toJson() => <String, dynamic>{
    if(storeId.isNotEmpty) 'storeID' : storeId.toList(),
    if(sortBy != SortBy.Deal_Rating) 'sortBy' : describeEnum(sortBy),
    if(orderBy != OrderBy.Descendant) 'desc' : 1,
    if(lowerPrice != 0) 'lowerPrice' : lowerPrice,
    if(upperPrice < 50) 'upperPrice' : upperPrice,
    if(metacritic != 0) 'metacritic' : metacritic,
    if(onlyRetail) 'AAA' : 1,
    if(steamWorks) 'steamworks' : 1,
    if(onSale) 'onSale' : 1
  };

}

enum OrderBy{
  Descendant,
  Ascendant
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
  recent
}