import 'package:dio/dio.dart';
import 'package:gameshop_deals/service/cheap_shark_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'repository_provider.g.dart';

@riverpod
Dio dioInstance(DioInstanceRef ref) {
  final Dio dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 3),
      responseType: ResponseType.json
    )
  );
  ref.onDispose(dio.close);
  return dio;
}

@Riverpod(dependencies: [dioInstance])
CheapSharkService cheapShark(CheapSharkRef ref) => 
  CheapSharkService(ref.watch(dioInstanceProvider));