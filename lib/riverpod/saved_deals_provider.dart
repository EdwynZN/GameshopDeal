import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gameshop_deals/model/price_alert.dart';
import 'package:gameshop_deals/utils/preferences_constants.dart';
import 'package:hive/hive.dart';
import 'package:dio/dio.dart';
import 'package:gameshop_deals/service/cheap_shark_retrofit.dart';
import 'package:gameshop_deals/model/game_lookup.dart';
import 'package:gameshop_deals/riverpod/repository_provider.dart';
import 'package:gameshop_deals/model/pagination_model.dart';

/// Maximum of 25 games id as documented by CheapShark API
const int _kMaximumGamesId = 25;

final singleGameLookup = ScopedProvider<GameLookup>(null);

final savedBoxProvider = FutureProvider<LazyBox<PriceAlert>>((ref) async {
  LazyBox<PriceAlert> lazyBox;

  if (Hive.isBoxOpen(alertHiveBox))
    lazyBox = Hive.lazyBox<PriceAlert>(alertHiveBox);
  else
    lazyBox = await Hive.openLazyBox<PriceAlert>(alertHiveBox);

  ref.onDispose(() => lazyBox?.close());

  return lazyBox;
}, name: 'Saved Box Provider');

final savedStreamProvider =
    StreamProvider.autoDispose.family<bool, String>((ref, gameId) async* {
  final savedDeals = await ref.watch(savedBoxProvider.future);

  yield savedDeals.containsKey(gameId);
  yield* savedDeals.watch(key: gameId).map((event) => !event.deleted);
}, name: 'Saved Game Provider');

final savedGamesPageProvider =
    StateNotifierProvider.autoDispose<GamesPagination>((ref) {
  final CancelToken cancelToken = CancelToken();
  final DiscountApi api = ref.watch(cheapSharkProvider);

  ref.onDispose(cancelToken.cancel);

  return ref.watch(savedBoxProvider).whenData((cb) {
    final list = cb.keys.toList();
    final joinedGames = <String>[];
    for (int i = 0; i < list.length; i += _kMaximumGamesId) {
      int end = i + _kMaximumGamesId;
      if (end > list.length) end -= end - list.length;
      joinedGames.add(
        list.getRange(i, end).join(','),
      );
    }
    return joinedGames;
  }).maybeWhen(
    orElse: () => GamesPagination(List<String>.empty(), api, cancelToken),
    data: (list) => GamesPagination(list, api, cancelToken),
  );
}, name: 'dealList');

final savedGamesProvider =
    StateNotifierProvider.autoDispose<StateController<Map<String, GameLookup>>>(
        (ref) {
  final notifier =
      StateController<Map<String, GameLookup>>(const <String, GameLookup>{});

  final dealList = ref.watch(savedGamesPageProvider);
  final pageListener = dealList.addListener((value) {
    if (value.data != null)
      notifier.state = Map<String, GameLookup>.from(notifier.state)
        ..addAll(value.data.value);
  });
  ref.onDispose(pageListener);

  return notifier;
});

final gameKeysProvider = Provider.autoDispose<List<String>>((ref) {
  return ref.watch(savedGamesProvider.state).keys.toList();
}, name: 'List of GamesID Provider');

class GamesPagination extends StateNotifier<AsyncValue<Map<String, GameLookup>>>
    implements Pagination<Map<String, GameLookup>> {
  final List<String> _gamesId;
  final DiscountApi _api;
  final CancelToken cancelToken;
  GamesPagination(this._gamesId, this._api, this.cancelToken)
      : super(_gamesId.isEmpty
            ? const AsyncData(const <String, GameLookup>{})
            : const AsyncValue.loading()) {
    if (state is AsyncLoading)
      _fetch();
    else
      _lastPage = true;
  }

  int get page => _page;

  int _page = 0;
  bool _lastPage = false;

  @override
  Future<Map<String, GameLookup>> fetchPage() =>
      _api.getGamesByMultipleId(_gamesId[_page], cancelToken);

  @override
  Future<void> retrieveNextPage() async {
    if (state is AsyncLoading || isLastPage)
      return;
    else if (state is AsyncData) ++_page;
    state = AsyncValue.loading();
    await _fetch();
  }

  Future<void> _fetch() async {
    final fetch = await AsyncValue.guard(() => fetchPage());
    if (mounted) state = fetch;
  }

  @override
  bool get isLastPage {
    if (_lastPage)
      return _lastPage;
    else if (state is AsyncData && page >= (_gamesId.length - 1))
      _lastPage = true;
    return _lastPage;
  }
}
