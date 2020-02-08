import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class CustomCacheManager extends BaseCacheManager {
  static const key = "libCachedImageData";

  static CustomCacheManager _instance;

  /// The DefaultCacheManager that can be easily used directly. The code of
  /// this implementation can be used as inspiration for more complex cache
  /// managers.
  factory CustomCacheManager() {
    if (_instance == null) {
      _instance = CustomCacheManager._();
    }
    return _instance;
  }

  CustomCacheManager._() : super(key,
      maxAgeCacheObject: Duration(days: 30),
      maxNrOfCacheObjects: 200,
  );

  Future<String> getFilePath() async {
    var directory = await getTemporaryDirectory();
    return join(directory.path, key);
  }
}