import 'package:clock/clock.dart';
import 'package:hive/hive.dart';
import 'package:flutter_cache_manager/src/storage/cache_info_repositories/helper_methods.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_cache_manager/src/storage/cache_object.dart';

extension _setTouchedToNow on CacheObject {
  CacheObject updateSetTouched({bool setTouchedToNow = true}) {
    return CacheObject(
      this.url,
      id: this.id,
      key: this.key,
      relativePath: this.relativePath,
      validTill: this.validTill,
      eTag: this.eTag,
      length: this.length,
      touched: setTouchedToNow ? clock.now() : this.touched,
    );
  }
}

class CacheHiveProvider extends CacheInfoRepository
    with CacheInfoRepositoryHelperMethods {
  final String databaseName;
  Box<CacheObject> box;

  CacheHiveProvider([this.databaseName = 'kDefaultCacheBox']);

  @override
  Future<bool> open() async {
    if (!shouldOpenOnNewConnection()) return openCompleter.future;
    if (Hive.isBoxOpen(databaseName))
      box ??= Hive.box<CacheObject>(databaseName);
    else
      box = await Hive.openBox<CacheObject>(databaseName);
    return opened();
  }

  @override
  Future<dynamic> updateOrInsert(CacheObject cacheObject) {
    if (cacheObject.id == null) {
      return insert(cacheObject);
    } else {
      return update(cacheObject);
    }
  }

  @override
  Future<CacheObject> insert(CacheObject cacheObject,
      {bool setTouchedToNow = true}) async {
    var id = await box
        .add(cacheObject.updateSetTouched(setTouchedToNow: setTouchedToNow));
    return cacheObject.copyWith(id: id);
  }

  @override
  Future<CacheObject> get(String key) async {
    if (box.isEmpty) return null;
    return box.values.firstWhere((cb) => cb.key == key, orElse: () => null);
  }

  @override
  Future<int> delete(int id) async {
    final exists = box.containsKey(id);
    if (!exists) return 0;
    await box.delete(id);
    return 1;
  }

  @override
  Future<int> deleteAll(Iterable<int> ids) async {
    var size = ids.where((value) => box.containsKey(value)).length;
    await box.deleteAll(ids);
    return size;
  }

  @override
  Future<int> update(CacheObject cacheObject,
      {bool setTouchedToNow = true}) async {
    await box.put(
      cacheObject.id,
      cacheObject.updateSetTouched(setTouchedToNow: setTouchedToNow),
    );
    return 1;
  }

  @override
  Future<List<CacheObject>> getAllObjects() async => box.values.toList();

  @override
  Future<List<CacheObject>> getObjectsOverCapacity(int capacity) async {
    final age = DateTime.now().subtract(const Duration(days: 1));
    final list = box.values.where((cb) => cb.touched.isBefore(age)).toList()
      ..sort((a, b) => b.touched.compareTo(a.touched));
    if (list.length > capacity)
      return list.sublist(
          capacity, (capacity + 100).clamp(capacity, list.length));
    return const <CacheObject>[];
  }

  @override
  Future<List<CacheObject>> getOldObjects(Duration maxAge) async {
    final age = DateTime.now().subtract(maxAge);
    final list = box.values.where((cb) => cb.touched.isBefore(age)).toList();
    if (list.length > 100) return list.sublist(0, 100);
    return list;
  }

  @override
  Future<bool> close() async {
    if (!shouldClose()) return false;
    await box.close();
    return true;
  }

  @override
  Future<void> deleteDataFile() async {
    await box.deleteFromDisk();
    box = null;
    box = await Hive.openBox<CacheObject>(databaseName);
  }

  @override
  Future<bool> exists() => Hive.boxExists(databaseName);
}
