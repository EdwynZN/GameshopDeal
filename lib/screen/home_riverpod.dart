import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gameshop_deals/riverpod/deal_provider.dart';
import 'package:gameshop_deals/screen/filter_riverpod_screen.dart';
import 'package:gameshop_deals/widget/appbar.dart';
import 'package:gameshop_deals/widget/deal_card.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  bool _scrollListener(ScrollNotification scrollNotification){
    if(scrollNotification is ScrollEndNotification &&
      scrollNotification.metrics.pixels >= (scrollNotification.metrics.maxScrollExtent * 0.9)){
      if(context.read(dealPageProvider.state).data != null) context.read(dealPageProvider).retrievePage();
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final bool isTablet = MediaQuery.of(context).size.shortestSide >= 700;
    return SafeArea(
      child: Scaffold(
        endDrawer: isTablet ? FilterScreen() : null,
        body: RefreshIndicator(
          child: NotificationListener(
            onNotification: _scrollListener,
            child: const CustomScrollView(
              slivers: <Widget>[
                const HomeAppBar(),
                const _DealListView(),
                const EndLinearProgressIndicator()
              ],
            )
          ),
          onRefresh: () async => context.refresh(dealPageProvider),
        ),
      )
    );
  }
}

class EndLinearProgressIndicator extends ConsumerWidget {
  const EndLinearProgressIndicator({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    ProviderListener(onChange: null, provider: null, child: null);
    // final deals = watch(dealList).status;
    final deals = watch(dealPageProvider.state);
    return deals.maybeWhen(
      orElse: () => const SliverFillRemaining(
        hasScrollBody: false,
        child: const Align(
          alignment: Alignment.topCenter,
          child: const LinearProgressIndicator()
        )
      ),
      error: (e, _) => SliverFillRemaining(
        hasScrollBody: false,
        child: Center(
          child: OutlinedButton(
            child: Text('Error fetching the deals'),
            onPressed: () async => context.read(dealPageProvider).retrievePage(),
          )
        )
      ),
    );
  }
}

class _DealListView extends ConsumerWidget {
  const _DealListView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final deals = watch(dealsProvider.state);
    return SliverList(
      delegate: SliverChildBuilderDelegate((BuildContext _, int index) {
        return ProviderScope(
          overrides: [singleDeal.overrideWithValue(deals[index])],
          child: const Tile(),
        );
      },
        childCount: deals?.length != null ? deals?.length : 0,
      )
    );
  }
}
