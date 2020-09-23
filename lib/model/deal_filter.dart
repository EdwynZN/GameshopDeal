import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class DealFilter extends Equatable{
  final List<int> storeID;
  final int pageNumber;
  final int pageSize;
  final String sortBy;
  final int desc;
  final int lowerPrice;
  final int upperPrice;
  final int metacritic;
  final int steamRating;
  final int AAA;
  final int steamworks;
  final int onSale;

  DealFilter({
    this.storeID = const <int>[],
    this.pageNumber = 0,
    this.pageSize = 60,
    this.sortBy = 'Deal Rating',
    this.desc = 0,
    this.lowerPrice = 0,
    this.upperPrice = 50,
    this.metacritic = 0,
    this.steamRating = 0,
    this.AAA = 0,
    this.steamworks = 0,
    this.onSale = 0
  });

  factory DealFilter.fromFilter(DealFilter dealFilter) =>
    DealFilter(
      storeID: dealFilter.storeID,
      pageNumber: dealFilter.pageNumber,
      pageSize: dealFilter.pageSize,
      sortBy: dealFilter.sortBy,
      desc: dealFilter.desc,
      lowerPrice: dealFilter.lowerPrice,
      upperPrice: dealFilter.upperPrice,
      metacritic: dealFilter.metacritic,
      steamRating: dealFilter.steamRating,
      AAA: dealFilter.AAA,
      steamworks: dealFilter.steamworks,
      onSale: dealFilter.onSale
    );

  Map<String, dynamic> toJson() => {
    'storeID' : storeID,
    'pageNumber' : pageNumber,
    'pageSize' : pageSize,
    'sortBy' : describeEnum(sortBy).replaceAll('_', ' '),
    'desc' : desc,
    'lowerPrice' : lowerPrice,
    'upperPrice' : upperPrice,
    'metacritic' : metacritic,
    'steamRating' : steamRating,
    'steamAppID' : 0,
    'title' : null,
    'exact' : 0, //Flag to allow only exact string match for title parameter
    'AAA' : AAA, //Flag to include only deals with retail price > $29
    'steamworks' : steamworks, //Flag to include only deals that redeem on Steam (best guess, depends on store support)
    'onSale' : onSale //Flag to include only games that are currently on sale
  };

  Map<String, dynamic> get parameters => {
    if(storeID.isNotEmpty) 'storeID' : storeID,
    if(pageNumber != 0) 'pageNumber' : pageNumber,
    if(pageSize != 60) 'pageSize' : pageSize,
    if(sortBy != 'Deal Rating') 'sortBy' : sortBy,
    if(desc != 0) 'desc' : desc,
    if(lowerPrice != 0) 'lowerPrice' : lowerPrice,
    if(upperPrice < 50) 'upperPrice' : upperPrice,
    if(metacritic != 0) 'metacritic' : metacritic,
    if(steamRating != 0) 'steamRating' : steamRating,
    if(AAA != 0) 'AAA' : AAA, //Flag to include only deals with retail price > $29
    if(steamworks != 0) 'steamworks' : steamworks, //Flag to include only deals that redeem on Steam (best guess, depends on store support)
    if(onSale != 0) 'onSale' : onSale //Flag to include only games that are currently on sale
  };

  @override
  List<Object> get props => [
    storeID,
    pageNumber,
    pageSize,
    sortBy,
    desc,
    lowerPrice,
    upperPrice,
    metacritic,
    steamRating,
    AAA,
    steamworks,
    onSale
  ];

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
  Recent,
}