import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:gameshop_deals/service/cheap_shark_service.dart';

final dioProvider = Provider.autoDispose<Dio>((ref) {
  final Dio dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 3),
      responseType: ResponseType.json
    )
  );
  ref.onDispose(dio.close);
  return dio;
}, name: 'Dio');

final cheapSharkProvider = Provider.autoDispose<CheapSharkService>(
  (ref) => CheapSharkService(ref.watch(dioProvider)),
  name: 'CheapShark API',
);