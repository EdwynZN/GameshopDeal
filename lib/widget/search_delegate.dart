import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:gameshop_deals/riverpod/deal_provider.dart';
import 'package:gameshop_deals/riverpod/search_provider.dart';

final suggestions =
    Provider.autoDispose.family<List<String>, String>((ref, query) {
  final deals = ref.watch(dealsProvider.state);
  final exp = RegExp(query, caseSensitive: false);
  return deals
      .map((e) => e.title)
      .where((element) => element.contains(exp))
      .toList();
}, name: 'Suggestions');

/* final results = Provider.autoDispose.family<List<String>, String>((ref, query) {
  final deals = ref.watch(dealsProvider.state);
  final exp = RegExp(query, caseSensitive: false);
  return deals
      .map((e) => e.title)
      .where((element) => element.contains(exp))
      .toList();
}, name: 'Results'); */

class AppSearchDelegate<T> extends SearchDelegate<T> {
  AppSearchDelegate() : super(
    searchFieldLabel: 'Title',
    keyboardType: TextInputType.text
  );

  @override
  void showResults(BuildContext context) {
    if(query.isNotEmpty) super.showResults(context);
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
    CloseButton(onPressed: () {
      query = '';
      showSuggestions(context);
    })
  ];

  @override
  Widget buildLeading(BuildContext context) => BackButton();

  @override
  Widget buildSuggestions(BuildContext context) {
    return Consumer(builder: (context, watch, _) {
      final suggestionsList = watch(suggestions(query));
      return ListView.builder(
        itemCount: suggestionsList.length,
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () => query = suggestionsList[index],
            title: Text(suggestionsList[index]),
          );
        },
      );
    });
  }

  @override
  Widget buildResults(BuildContext context) {
    return Consumer(builder: (context, watch, _) {
      final resultsList = watch(results(query));
      return resultsList.when(
        loading: () => const LinearProgressIndicator(),
        error: (e, _) {
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            Scaffold.of(context, nullOk: true)?.showSnackBar(SnackBar(
              content: Text(e.toString()),
              duration: const Duration(minutes: 1),
            ));
          });
          return Center(
            child: OutlinedButton(
              child: const Text('Error fetching the deals'),
              onPressed: () => context.refresh(results(query)),
            ),
          );
        },
        data: (list) {
          return ListView.builder(
            itemCount: list.length,
            itemBuilder: (context, index) {
              return ListTile(
                onTap: () => close(context, list[index] as T),
                title: Text(list[index]),
              );
            },
          );
        },
      );
    });
  }
}
