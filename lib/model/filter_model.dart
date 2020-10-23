import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class Filter extends Equatable{
  final Set<int> storeId;
  final int pageNumber;
  final int pageSize;
  final SortBy sortBy;
  final OrderBy orderBy;
  final int lowerPrice;
  final int upperPrice;
  final int metacritic;
  final int steamRating;
  final bool onlyRetail;
  final bool steamWorks;
  final bool onSale;

  Filter({
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
  }) : this.storeId = stores ?? <int>{};

  Filter copyWith({
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
    Filter(
      stores: stores ?? this.storeId,
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

  Filter get copy =>
    Filter(
      stores: this.storeId,
      pageSize: this.pageSize,
      pageNumber: this.pageNumber,
      sortBy: this.sortBy,
      orderBy: this.orderBy,
      lowerPrice: this.lowerPrice,
      upperPrice: this.upperPrice,
      metacritic: this.metacritic,
      steamRating: this.steamRating,
      onlyRetail: this.onlyRetail,
      steamWorks: this.steamWorks,
      onSale: this.onSale,
    );

  Map<String, dynamic> get parameters => <String, dynamic>{
    if(storeId.isNotEmpty) 'storeID' : storeId.toList(),
    // 'pageNumber': pageNumber,
    'sortBy' : describeEnum(sortBy).replaceFirst('_', ' '),
    'desc' : orderBy.index,
    'lowerPrice' : lowerPrice,
    'upperPrice' : upperPrice,
    'metacritic' : metacritic,
    'steamRating' : steamRating,
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
    if(steamRating > 40) 'steamRating' : steamRating,
    if(onlyRetail) 'AAA' : 1,
    if(steamWorks) 'steamworks' : 1,
    if(onSale) 'onSale' : 1
  };

  @override
  List<Object> get props => [
    storeId,
    steamRating,
    storeId,
    pageNumber,
    pageSize,
    sortBy,
    orderBy,
    lowerPrice,
    upperPrice,
    metacritic,
    steamRating,
    onlyRetail,
    steamWorks,
    onSale
  ];

  @override
  bool get stringify => true;

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
  Recent
}

extension enumToString on SortBy{

  String get name => describeEnum(this).replaceFirst('_', ' ');
}