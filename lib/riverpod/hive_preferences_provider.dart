import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:gameshop_deals/utils/preferences_constants.dart' show preferenceHiveBox;

final hiveBoxProvider =
    FutureProvider.autoDispose.family<Box<dynamic>, String>((ref, name) async {
  Box<dynamic> box;

  if (Hive.isBoxOpen(name)) box = Hive.box<dynamic>(name);
  box = await Hive.openBox<dynamic>(name);

  ref.onDispose(() async => await box?.close());

  return box;
}, name: 'HiveBox');

final hivePreferencesProvider = Provider<Box<dynamic>>(
  (_) => Hive.box<dynamic>(preferenceHiveBox),
  name: 'HivePreferences',
);

class HiveNotifier<T extends Object> extends StateNotifier<T> {
  HiveNotifier(this._read, this._key, T mode)
      : assert(_key != null),
        assert(mode != null),
        super(mode);

  final Reader _read;
  final String _key;

  Future<void> changeState(T mode) async {
    if (mode != state) {
      await _read(hivePreferencesProvider).put(_key, mode);
      state = mode;
    }
  }
}