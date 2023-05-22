import 'package:hive/hive.dart';
import 'package:gameshop_deals/utils/preferences_constants.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'search_provider.g.dart';

@riverpod
Box<String>? searchSync(SearchSyncRef ref) {
  Box<String>? box;

  if (Hive.isBoxOpen(searchHistoryHiveBox))
    box = Hive.box<String>(searchHistoryHiveBox);

  ref.onDispose(() async => await box?.close());

  return box;
}

@riverpod
Future<Box<String>> _searchLocalCache(_SearchLocalCacheRef ref) async {
  final Box<String> box;

  if (Hive.isBoxOpen(searchHistoryHiveBox))
    box = Hive.box<String>(searchHistoryHiveBox);
  else
    box = await Hive.openBox<String>(searchHistoryHiveBox);

  ref.onDispose(box.close);

  return box;
}

@Riverpod(dependencies: [_searchLocalCache])
List<String> suggestions(ref, {String query = ''}) {
  final asyncBox = ref.watch(_searchLocalCache).asData;
  Box<String>? box;

  if (asyncBox != null) box = asyncBox.value;

  if (box == null || !box.isOpen || box.length == 0) return const <String>[];

  if (query.isEmpty) return box.values.toList();

  final exp = RegExp(query, caseSensitive: false);
  return box.values.where((element) => element.contains(exp)).toList();
}
