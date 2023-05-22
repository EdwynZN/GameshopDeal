import 'package:dio/dio.dart';
import 'package:gameshop_deals/model/deal.dart';
import 'package:gameshop_deals/model/game_lookup.dart';
import 'package:gameshop_deals/riverpod/repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'game_provider.g.dart';

@Riverpod(dependencies: [cheapShark])
Future<GameLookup> gameLookup(GameLookupRef ref, {
  required int id,
}) async {
  final cancelToken = CancelToken();

  ref.onDispose(cancelToken.cancel);

  return ref
    .watch(cheapSharkProvider)
    .game(id, cancelToken: cancelToken);
}


@Riverpod(dependencies: [gameLookup])
AsyncValue<List<Deal>> dealsOfGame(DealsOfGameRef ref, {
  required int id,
}) => ref
    .watch(gameLookupProvider(id: id))
    .whenData((value) => value.deals);

