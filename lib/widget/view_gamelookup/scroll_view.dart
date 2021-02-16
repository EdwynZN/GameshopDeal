import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gameshop_deals/model/view_enum.dart';
import 'package:gameshop_deals/riverpod/saved_deals_provider.dart'
  show savedGamesProvider, singleGameLookup, gameKeysProvider;
import 'package:gameshop_deals/riverpod/display_provider.dart';
import 'package:gameshop_deals/widget/gamelookup_widget.dart';

class GameListView extends ConsumerWidget {
  const GameListView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final games = watch(gameKeysProvider);
    final View view = watch(displayProvider.state);
    if (games.isEmpty) return const SliverToBoxAdapter();
    switch (view) {
      /* case View.Grid:
        return SliverPadding(
          padding: const EdgeInsets.all(4.0),
          sliver: SliverGrid(
            delegate: SliverChildBuilderDelegate(
              (BuildContext _, int index) {
                return ProviderScope(
                  overrides: [
                    indexGameLookup.overrideWithValue(index),
                    singleGameLookup.overrideAs((watch) => watch(savedGamesProvider.state)[games[index]])
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
        ); */
      case View.Detail:
        return SliverList(
          //itemExtent: 86.0,
          delegate: SliverChildBuilderDelegate(
            (BuildContext _, int index) {
              return ProviderScope(
                overrides: [
                  indexGameLookup.overrideWithValue(index),
                  singleGameLookup.overrideAs((watch) => watch(savedGamesProvider.state)[games[index]])
                ],
                child: const DetailedGameLookup(),
              );
            },
            childCount: games?.length ?? 0,
          ),
        );
      case View.Compact:
        return SliverList(
          //itemExtent: 64.0,
          delegate: SliverChildBuilderDelegate(
            (BuildContext _, int index) {
              return ProviderScope(
                overrides: [
                  indexGameLookup.overrideWithValue(index),
                  singleGameLookup.overrideAs((watch) => watch(savedGamesProvider.state)[games[index]])
                ],
                child: const CompactGameLookup(),
              );
            },
            childCount: games?.length ?? 0,
          ),
        );
      case View.List:
      default:
        return SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext _, int index) {
              return ProviderScope(
                overrides: [
                  indexGameLookup.overrideWithValue(index),
                  singleGameLookup.overrideAs((watch) => watch(savedGamesProvider.state)[games[index]])
                ],
                child: const ListGameLookup(),
              );
            },
            childCount: games?.length ?? 0,
          ),
        );
    }
  }
}