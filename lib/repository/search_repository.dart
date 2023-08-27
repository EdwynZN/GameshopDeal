import 'dart:async';

import 'package:hive/hive.dart';

interface class SearchRepository {
  final Future<Box<String>> _box;

  const SearchRepository({required Future<Box<String>> box}) : _box = box;

  FutureOr<void> saveSearch(String text) async {
    final box = await _box;
    box.put(text, text);
  }

  FutureOr<List<String>> getCoincidence(String query) async {
    final box = await _box;
    if (!box.isOpen || box.length == 0) return const <String>[];
    else if (query.isEmpty) return box.values.toList();
    final exp = RegExp(query, caseSensitive: false);
    return box.values.where((element) => element.contains(exp)).toList();
  }

  FutureOr<void> clear() async => (await _box).clear();
}
