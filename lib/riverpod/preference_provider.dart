import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

final hiveBoxProvider =
    FutureProvider.family<Box<dynamic>, String>((_, name) async {
  if (Hive.isBoxOpen(name)) return Hive.box<dynamic>(name);
  return Hive.openBox<dynamic>(name);
}, name: 'HiveBox');

final preferencesProvider = Provider<Box<dynamic>>(
  (_) => Hive.box<dynamic>('preferences'),
  name: 'HivePreferences',
);

class HiveNotifier<T extends Object> extends StateNotifier<T> {
  HiveNotifier(this._read, this._key, T mode) : 
    assert(_key != null),
    assert(mode != null),
    super(mode);

  final Reader _read;
  final String _key;

  Future<void> changeState(T mode) async {
    if (mode != state) {
      await _read(preferencesProvider).put(_key, mode);
      state = mode;
    }
  }
}
