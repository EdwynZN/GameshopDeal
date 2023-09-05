import 'package:dio/dio.dart';
import 'package:gameshop_deals/model/deal_lookup.dart';
import 'package:gameshop_deals/provider/dispose_extension.dart';
import 'package:gameshop_deals/provider/repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'deal_detail_provider.g.dart';

@Riverpod(dependencies: [cheapShark])
Future<DealLookup> dealDetail(DealDetailRef ref, {
  required String dealId,
}) async {
  final cancelToken = CancelToken();

  ref
    ..disposeDelay(const Duration(seconds: 10))
    ..onDispose(cancelToken.cancel);

  return ref
    .watch(cheapSharkProvider)
    .deal(dealId, cancelToken: cancelToken);
}