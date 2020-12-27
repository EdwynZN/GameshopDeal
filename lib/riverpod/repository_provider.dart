import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gameshop_deals/service/cheap_shark_retrofit.dart';
import 'package:dio/dio.dart';

final dioProvider = Provider.autoDispose<Dio>((ref) {
  final Dio dio = Dio(
    BaseOptions(
      connectTimeout: 5000,
      receiveTimeout: 3000,
      responseType: ResponseType.json
    )
  );
  ref.onDispose(dio.close);
  return dio;
}, name: 'Dio');

final cheapSharkProvider = Provider.autoDispose<DiscountApi>((ref) =>
  DiscountApi(ref.watch(dioProvider)), name: 'CheapShark API');