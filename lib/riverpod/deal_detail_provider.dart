import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gameshop_deals/model/deal.dart';
import 'package:dio/dio.dart';
import 'package:gameshop_deals/riverpod/repository_provider.dart';
import 'package:gameshop_deals/model/game_lookup.dart';

final gameDealLookupProvider =
    FutureProvider.autoDispose.family<GameLookup, String>((ref, id) async {
  final cancelToken = CancelToken();
  ref.onDispose(cancelToken.cancel);

  return ref.watch(cheapSharkProvider).getGamesById(id, cancelToken);
}, name: 'Game Deal Lookup');

final dealsOfGameProvider =
    Provider.autoDispose.family<AsyncValue<List<Deal>>, String>((ref, id) {
  return ref.watch(gameDealLookupProvider(id)).whenData((value) => value.deals);
}, name: 'Deals of Game Lookup');