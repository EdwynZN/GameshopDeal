import 'package:flutter_riverpod/all.dart';
import 'package:gameshop_deals/model/game_lookup.dart';
import 'package:hive/hive.dart';

final savedBoxProvider = FutureProvider<LazyBox<GameLookup>>((ref) async {
  LazyBox<GameLookup> lazyBox;

  if (Hive.isBoxOpen('SavedDeals'))
    lazyBox = Hive.lazyBox('SavedDeals');
  else
    lazyBox = await Hive.openLazyBox<GameLookup>('SavedDeals');

  ref.onDispose(() => lazyBox?.close());

  return lazyBox;
}, name: 'Saved Box Provider');

final savedDealsProvider = Provider.family<bool, String>((ref, gameId) {
  final savedDeals = ref.watch(savedBoxProvider).data?.value;

  savedDeals.watch();

  return savedDeals.keys.contains(gameId);
}, name: 'Saved Game Provider');

final savedStreamProvider =
    StreamProvider.family<bool, String>((ref, gameId) async* {
  final savedDeals = ref.watch(savedBoxProvider).data?.value;

  yield savedDeals.containsKey(gameId);
  yield* savedDeals.watch(key: gameId).map((event) => !event.deleted);
}, name: 'Saved Game Provider');
