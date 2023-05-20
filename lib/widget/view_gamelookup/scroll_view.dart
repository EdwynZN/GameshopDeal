import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gameshop_deals/riverpod/saved_deals_provider.dart'
    show savedGamesProvider, singleGameLookup, gameKeysProvider;
import 'package:gameshop_deals/riverpod/display_provider.dart';
import 'package:gameshop_deals/widget/gamelookup_widget.dart';
import 'package:gameshop_deals/model/view_enum.dart' as viewEnum;

class GameListView extends ConsumerWidget {
  const GameListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final games = ref.watch(gameKeysProvider);
    final viewEnum.View view = ref.watch(displayProvider);
    if (games.isEmpty) return const SliverToBoxAdapter();
    switch (view) {
      case viewEnum.View.Grid:
        return SliverPadding(
          padding: const EdgeInsets.all(4.0),
          sliver: SliverGrid(
            delegate: SliverChildBuilderDelegate(
              (BuildContext _, int index) {
                return ProviderScope(
                  overrides: [
                    indexGameLookup.overrideWithValue(index),
                    singleGameLookup.overrideWithProvider(
                      Provider.autoDispose((ref) =>
                        ref.watch(savedGamesProvider)[games[index]]!,
                      ),
                    ),
                  ],
                  child: const GridGameLookup(),
                );
              },
              childCount: games.length,
            ),
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 150,
              childAspectRatio: 0.65,
              mainAxisSpacing: 4.0,
              crossAxisSpacing: 4.0,
            ),
          ),
        );
      case viewEnum.View.Detail:
        return SliverList(
          //itemExtent: 86.0,
          delegate: SliverChildBuilderDelegate(
            (BuildContext _, int index) {
              return ProviderScope(
                overrides: [
                  indexGameLookup.overrideWithValue(index),
                  singleGameLookup.overrideWithProvider(
                    Provider.autoDispose((ref) =>
                      ref.watch(savedGamesProvider)[games[index]]!,
                    ),
                  ),
                ],
                child: const DetailedGameLookup(),
              );
            },
            childCount: games.length,
          ),
        );
      case viewEnum.View.Compact:
        return SliverList(
          //itemExtent: 64.0,
          delegate: SliverChildBuilderDelegate(
            (BuildContext _, int index) {
              return ProviderScope(
                overrides: [
                  indexGameLookup.overrideWithValue(index),
                  singleGameLookup.overrideWithProvider(
                    Provider.autoDispose((ref) =>
                      ref.watch(savedGamesProvider)[games[index]]!,
                    ),
                  ),
                ],
                child: const CompactGameLookup(),
              );
            },
            childCount: games.length,
          ),
        );
      case viewEnum.View.List:
      default:
        return SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext _, int index) {
              return ProviderScope(
                overrides: [
                  indexGameLookup.overrideWithValue(index),
                  singleGameLookup.overrideWithProvider(
                    Provider.autoDispose((ref) =>
                      ref.watch(savedGamesProvider)[games[index]]!,
                    ),
                  ),
                ],
                child: const ListGameLookup(),
              );
            },
            childCount: games.length,
          ),
        );
    }
  }
}
