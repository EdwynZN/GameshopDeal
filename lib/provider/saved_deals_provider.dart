import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gameshop_deals/model/price_alert.dart';
import 'package:gameshop_deals/service/cheap_shark_service.dart';
import 'package:gameshop_deals/utils/preferences_constants.dart';
import 'package:hive/hive.dart';
import 'package:dio/dio.dart';
import 'package:gameshop_deals/model/game_lookup.dart';
import 'package:gameshop_deals/provider/repository_provider.dart';
import 'package:gameshop_deals/model/pagination_model.dart';

/// Maximum of 25 games id as documented by CheapShark API
const int _kMaximumGamesId = 25;

final singleGameLookup = Provider.autoDispose<GameLookup>((_) => throw UnimplementedError());

final savedBoxProvider = FutureProvider<LazyBox<PriceAlert>>((ref) async {
  final LazyBox<PriceAlert> lazyBox;

  if (Hive.isBoxOpen(alertHiveBox))
    lazyBox = Hive.lazyBox<PriceAlert>(alertHiveBox);
  else
    lazyBox = await Hive.openLazyBox<PriceAlert>(alertHiveBox);

  ref.onDispose(lazyBox.close);

  return lazyBox;
}, name: 'Saved Box Provider');

final savedStreamProvider =
    StreamProvider.autoDispose.family<bool, String>((ref, gameId) async* {
  final savedDeals = await ref.watch(savedBoxProvider.future);

  yield savedDeals.containsKey(gameId);
  yield* savedDeals.watch(key: gameId).map((event) => !event.deleted);
}, name: 'Saved Game Provider');

final savedGamesPageProvider =
    StateNotifierProvider.autoDispose<GamesPagination, AsyncValue<Map<String, GameLookup>>>((ref) {
  final CancelToken cancelToken = CancelToken();
  final CheapSharkService api = ref.watch(cheapSharkProvider);

  ref.onDispose(cancelToken.cancel);

  return ref.watch(savedBoxProvider).whenData((cb) {
    final list = cb.keys
      .toList()
      .cast<int>();
    final joinedGames = <List<int>>[];
    for (int i = 0; i < list.length; i += _kMaximumGamesId) {
      int end = i + _kMaximumGamesId;
      if (end > list.length) end -= end - list.length;
      joinedGames.add(list.getRange(i, end).toList());
    }
    return joinedGames;
  }).maybeWhen(
    orElse: () => GamesPagination(List<List<int>>.empty(), api, cancelToken),
    data: (list) => GamesPagination(list, api, cancelToken),
  );
}, name: 'dealList');

final savedGamesProvider =
    Provider.autoDispose<Map<String, GameLookup>>(
        (ref) {
  final notifier = const <String, GameLookup>{};
  
  final dealList = ref.watch(savedGamesPageProvider.notifier);
  final pageListener = dealList.addListener((value) {
    if (value.asData != null)
      ref.state = Map<String, GameLookup>.from(ref.state)
        ..addAll(value.asData!.value);
  });
  ref.onDispose(pageListener);

  return notifier;
});

final gameKeysProvider = Provider.autoDispose<List<String>>((ref) {
  return ref.watch(savedGamesProvider).keys.toList();
}, name: 'List of GamesID Provider');

class GamesPagination extends StateNotifier<AsyncValue<Map<String, GameLookup>>>
    implements Pagination<Map<String, GameLookup>> {
  final List<List<int>> _pagesGames;
  final CheapSharkService _cheapSharkService;
  final CancelToken cancelToken;
  GamesPagination(this._pagesGames, this._cheapSharkService, this.cancelToken)
      : super(_pagesGames.isEmpty
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
      _cheapSharkService.gamesById(_pagesGames[_page], cancelToken: cancelToken);

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
    else if (state is AsyncData && page >= (_pagesGames.length - 1))
      _lastPage = true;
    return _lastPage;
  }
}
