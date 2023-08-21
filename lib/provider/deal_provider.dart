import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gameshop_deals/model/deal.dart';
import 'package:gameshop_deals/model/filter.dart';
import 'package:gameshop_deals/model/pagination_model.dart';
import 'package:gameshop_deals/provider/filter_provider.dart';
import 'package:gameshop_deals/provider/repository_provider.dart';
import 'package:gameshop_deals/service/cheap_shark_service.dart';

/* part 'deal_provider.g.dart';
 */
final singleDeal = Provider<Deal>((_) => throw UnimplementedError());
/* 
@Riverpod(dependencies: [cheapShark])
class DealPage extends _$DealPage implements Pagination<List<Deal>> {
  late Filter _filter;
  late CheapSharkService _cheapSharkService;
  late CancelToken _cancelToken;
  late Object? _key;
  late int _page;
  late bool _lastPage;

  @override
  FutureOr<List<Deal>> build({String title = ''}) async {
    _cancelToken = CancelToken();
    _key = Object();
    _filter = ref.watch(filterProvider(title));
    _cheapSharkService = ref.watch(cheapSharkProvider);
    ref.onDispose(() {
      _key = null;
      _cancelToken.cancel();
    });
    _page = 0;
    _lastPage = false;
    return fetchPage();
  }

  @override
  Future<void> retrieveNextPage() async {
    if (state.isLoading || isLastPage)
      return;
    else if (state is AsyncData) ++_page;
    state = const AsyncValue<List<Deal>>.loading().copyWithPrevious(state);
    await _fetch();
  }

  @override
  Future<List<Deal>> fetchPage() => _cheapSharkService.deals(
        page: _page,
        filter: _filter,
        cancelToken: _cancelToken,
      );

  Future<void> _fetch() async {
    final key = _key;
    final fetch = await AsyncValue.guard(() => fetchPage());
    if (key != _key) return;
    state = fetch.whenData(
      (deals) {
        final previous = state.valueOrNull;
        return previous == null ? deals : [...previous, ...deals];
      },
    ).copyWithPrevious(state);
  }

  @override
  bool get isLastPage {
    if (_lastPage) {
      return _lastPage;
    } else if (state is AsyncData &&
        (state.asData?.value.length ?? _filter.pageSize) < _filter.pageSize) {
      _lastPage = true;
    }
    return _lastPage;
  }
}
 */
final dealPageProvider = StateNotifierProvider.autoDispose
    .family<DealListPagination, AsyncValue<List<Deal>>, String>((ref, title) {
  final CancelToken cancelToken = CancelToken();
  final Filter filter = ref.watch(filterProvider(title));
  ref.onDispose(cancelToken.cancel);

  final CheapSharkService api = ref.watch(cheapSharkProvider);
  return DealListPagination(filter, api, cancelToken);
}, name: 'dealList');

class DealListPagination extends StateNotifier<AsyncValue<List<Deal>>>
    implements Pagination<List<Deal>> {
  final Filter filter;
  final CheapSharkService _cheapSharkService;
  final CancelToken cancelToken;
  DealListPagination(this.filter, this._cheapSharkService, this.cancelToken)
      : super(const AsyncValue.loading()) {
    _fetch();
  }

  bool _lastPage = false;

  int _page = 0;

  @override
  Future<void> retrieveNextPage() async {
    if (state.isLoading || isLastPage)
      return;
    else if (state is AsyncData) ++_page;
    state = const AsyncValue<List<Deal>>.loading().copyWithPrevious(
      state,
      isRefresh: false,
    );
    await _fetch();
  }

  @override
  Future<List<Deal>> fetchPage() => _cheapSharkService.deals(
        page: _page,
        filter: filter,
        cancelToken: cancelToken,
      );

  Future<void> _fetch() async {
    final fetch = await AsyncValue.guard(fetchPage);
    if (mounted) {
      state = fetch.whenData(
        (deals) {
          final previous = state.valueOrNull;
          return previous == null ? deals : [...previous, ...deals];
        },
      ).copyWithPrevious(state, isRefresh: false);
    }
  }

  Future<void> refresh() async {
    if (state.isLoading) return;
    state = const AsyncValue<List<Deal>>.loading().copyWithPrevious(
      state,
      isRefresh: true,
    );
    final fetch = await AsyncValue.guard(() => _cheapSharkService.deals(
          page: 0,
          filter: filter,
          cancelToken: cancelToken,
        ));
    if (mounted) {
      state = fetch.maybeMap(
        data: (d) {
          _lastPage = false;
          _page = 0;
          return d;
        },
        orElse: () => fetch.copyWithPrevious(state),
      );
    }
  }

  @override
  bool get isLastPage {
    if (_lastPage) {
      return _lastPage;
    } else if (state is AsyncData &&
        (state.asData?.value.length ?? filter.pageSize) < filter.pageSize) {
      _lastPage = true;
    }
    return _lastPage;
  }
}
