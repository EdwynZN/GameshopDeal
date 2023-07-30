import 'package:dio/dio.dart';
import 'package:gameshop_deals/model/store.dart';
import 'package:gameshop_deals/provider/repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'store_provider.g.dart';

@Riverpod(dependencies: [cheapShark])
Future<List<Store>> fetchStores(FetchStoresRef ref) async {
  final cancelToken = CancelToken();

  ref.onDispose(() {
    cancelToken.cancel();
  });

  final stores =
      await ref.watch(cheapSharkProvider).stores(cancelToken: cancelToken);

  ref.keepAlive();

  return stores.where((element) => element.isActive).toList();
}

@Riverpod(dependencies: [fetchStores])
AsyncValue<Store> singleStore(SingleStoreRef ref, {required String id}) {
  final asyncStore = ref
      .watch(fetchStoresProvider)
      .whenData((data) => data.firstWhere((store) => store.storeId == id));

  if (asyncStore.hasValue) {
    ref.keepAlive();
  }

  return asyncStore;
}
