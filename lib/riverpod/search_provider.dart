import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:gameshop_deals/utils/preferences_constants.dart';

final searchSyncBox = Provider.autoDispose<Box<String>>((ref) {
  Box<String> box;

  if (Hive.isBoxOpen(searchHistoryHiveBox)) box = Hive.box<String>(searchHistoryHiveBox);

  ref.onDispose(() async => await box?.close());

  return box;
}, name: 'Sync Search Hivebox');

final searchBox = FutureProvider.autoDispose<Box<String>>((ref) async {
  Box<String> box;

  if (Hive.isBoxOpen(searchHistoryHiveBox))
    box = Hive.box<String>(searchHistoryHiveBox);
  else
    box = await Hive.openBox<String>(searchHistoryHiveBox);

  ref.onDispose(() async => await box?.close());

  return box;
}, name: 'Search Hivebox');

final suggestions =
    Provider.autoDispose.family<List<String>, String>((ref, query) {
  final asyncBox = ref.watch(searchBox).data;
  Box<String> box;

  if (asyncBox != null) box = asyncBox.value;

  if (box == null || !box.isOpen || box.length == 0) return const <String>[];

  if (query.isEmpty) return box.values.toList();

  final exp = RegExp(query, caseSensitive: false);
  return box.values.where((element) => element.contains(exp)).toList();
}, name: 'Suggestions');