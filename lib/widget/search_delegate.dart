import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:gameshop_deals/generated/l10n.dart';
import 'package:gameshop_deals/riverpod/search_provider.dart';

class AppSearchDelegate extends SearchDelegate<String> {
  AppSearchDelegate() : super(keyboardType: TextInputType.text);

  @override
  void showResults(BuildContext context) async {
    final String trimmed = query.trim();
    if (trimmed.isNotEmpty) {
      final box = await context.read(searchBox.future);
      if (box != null && box.isOpen) {
        final exp = RegExp('\^$trimmed\$', caseSensitive: false);
        final exist = box.values.any((e) => exp.hasMatch(e));
        if (!exist) await box.add(trimmed);
      }
      close(context, trimmed);
    }
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return theme.copyWith(
      primaryIconTheme: theme.appBarTheme.iconTheme,
      primaryTextTheme: theme.appBarTheme.textTheme,
      textTheme: theme.appBarTheme.textTheme,
      inputDecorationTheme: theme.inputDecorationTheme.copyWith(
        hintStyle: theme.appBarTheme.textTheme.headline6,
      ),
      primaryColorBrightness: theme.appBarTheme.brightness,
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) => <Widget>[
        IconButton(
          icon: const Icon(Icons.close),
          tooltip: MaterialLocalizations.of(context).deleteButtonTooltip,
          //tooltip: S.of(context).clear_tooltip,
          onPressed: () {
            query = '';
            showSuggestions(context);
          },
        )
      ];

  @override
  Widget buildLeading(BuildContext context) => BackButton();

  @override
  Widget buildSuggestions(BuildContext context) {
    return Consumer(builder: (context, watch, _) {
      final S translate = S.of(context);
      final String trimmed = query.trim();
      final list = watch(suggestions(trimmed));
      return CustomScrollView(
        slivers: [
          if (trimmed.isEmpty)
            SliverPadding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
              sliver: SliverToBoxAdapter(
                child: Text(
                  translate.recent_searches,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
            ),
          if (trimmed.isNotEmpty) ...[
            SliverToBoxAdapter(
              child: ListTile(
                onTap: () => showResults(context),
                leading: const Icon(Icons.search_rounded),
                title: Text(translate.title_search(trimmed)),
              ),
            ),
            SliverPadding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
              sliver: SliverToBoxAdapter(
                child: Text(
                  translate.suggested_searches,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
            ),
          ],
          SliverFixedExtentList(
            itemExtent: 56.0,
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return ListTile(
                  onTap: () => close(context, list[index]),
                  leading: const Icon(Icons.saved_search),
                  title: Text(list[index]),
                );
              },
              childCount: list.length,
            ),
          ),
        ],
      );
    });
  }

  @override
  Widget buildResults(BuildContext context) => const SizedBox();
}
