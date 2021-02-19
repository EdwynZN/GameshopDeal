import 'package:flutter/foundation.dart';

abstract class Pagination<T> {
  const Pagination();

  @protected
  Future<T> fetchPage();

  Future<void> retrieveNextPage();

  bool get isLastPage;
}