import 'package:flutter/foundation.dart';

abstract class Pagination<T> {
  const Pagination();

  @protected
  Future<T> fetchPage();

  Future<void> retrieveNextPage();

  bool get isLastPage;
}

/* abstract class Pagination<T> extends StateNotifier<AsyncValue<T>> {
  Pagination([T initValue]) : super(initValue == null ? AsyncValue.loading() : AsyncData(initValue)) {
    _lastPage = initValue ?? false;
    if (!_lastPage) _fetch();
  }

  @protected
  void updatePageCounter();

  @protected
  bool get conditionNextPage;

  @protected
  Future<T> fetchPage();

  bool _lastPage;

  Future<void> retrieveNextPage() async {
    if (state is AsyncLoading || isLastPage)
      return;
    else if (state is AsyncData) updatePageCounter();
    state = AsyncValue.loading();
    await _fetch();
  }

  Future<void> _fetch() async {
    final fetch = await AsyncValue.guard<T>(() => fetchPage());
    if (mounted) state = fetch;
  }

  bool get isLastPage {
    if (_lastPage) return _lastPage;
    if (state is AsyncData && conditionNextPage) _lastPage = true;
    return _lastPage;
  }
} */
