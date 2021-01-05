import 'package:flutter_riverpod/all.dart';
import 'package:dio/dio.dart';
import 'package:gameshop_deals/riverpod/filter_provider.dart';
import 'package:gameshop_deals/riverpod/repository_provider.dart';

final results =
    FutureProvider.autoDispose.family<List<String>, String>((ref, query) async {
  final cancelToken = CancelToken();
  ref.onDispose(cancelToken.cancel);

  final parameters =
      ref.watch(filterProvider).state.copyWith(title: query).parameters;
  if (parameters.isEmpty) return const <String>[];
  final games =
    await ref.watch(cheapSharkProvider).getGames(parameters, cancelToken);

  ref.maintainState = true;

  return games.map((e) => e.externalName).toList();
}, name: 'Results');
