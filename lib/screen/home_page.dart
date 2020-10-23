import 'package:flutter/material.dart';
import 'package:gameshop_deals/model/deal.dart';
import 'package:gameshop_deals/provider/deal_provider.dart';
import 'package:provider/provider.dart';
import 'package:gameshop_deals/provider/theme_provider.dart';
import 'package:gameshop_deals/widget/tile.dart';
import 'package:gameshop_deals/utils/routes_constants.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DealProvider dealProvider;
  ThemeProvider themeProvider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    dealProvider = context.read<DealProvider>();
    themeProvider = context.read<ThemeProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        //endDrawer: FilterScreen(isDrawer: true),
        body: RefreshIndicator(
          child: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                snap: true, floating: true,
                automaticallyImplyLeading: false,
                title: Text('Gameshop'),
                actions: <Widget>[
                  IconButton(
                    tooltip: 'Change Theme',
                    icon: const Icon(Icons.brightness_low),
                    onPressed: () {
                      print('preferred: ${themeProvider.preferredTheme}');
                      if(themeProvider.preferredTheme == ThemeMode.light)
                        themeProvider.themePreference(ThemeMode.dark);
                      else themeProvider.themePreference(ThemeMode.light);
                    }
                  ),
                  Builder(
                    builder: (BuildContext ctx) =>
                      IconButton(
                        icon: const Icon(Icons.filter_list),
                        onPressed: () => Scaffold.of(ctx).hasEndDrawer ?
                          Scaffold.of(ctx).openEndDrawer() : Navigator.pushNamed(ctx, filterRoute),
                        tooltip: 'Open filter menu',
                      )
                  ),
                  const SizedBox(width: 10)
                ],
              ),
              StreamProvider<List<Deal>>.value(
                value: dealProvider.collectionList,
                builder: (context, child){
                  final List<Deal> deals = context.watch<List<Deal>>();
                  if(deals != null) {
                    if(deals.isNotEmpty) return SliverList(
                      delegate: SliverChildBuilderDelegate((BuildContext _, int index) {
                        return Tile(deal: deals[index],);
                        //return DealCard2(deal: deals[index],);
                      },
                        childCount: deals?.length != null ? deals?.length : 0,
                      )
                    );
                    return SliverFillRemaining(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Icon(Icons.signal_wifi_off, size: 40),
                          const Padding(
                            padding: const EdgeInsets.only(top: 40),
                            child: Text('No internet connection', style: TextStyle(fontSize: 18)),
                          )
                        ],
                      )
                    );
                  }
                  return child;
                },
                child: const SliverFillRemaining(child: Center(child: const CircularProgressIndicator())),
                catchError: (BuildContext ctx, error){
                  Scaffold.of(ctx).showSnackBar(SnackBar(
                    content: Text(error.toString()),
                    action: SnackBarAction(
                      label: 'retry',
                      onPressed: () => dealProvider.requestListOfDeals
                    ),
                  ));
                  return List<Deal>()..clear();
                },
              ),
            ],
          ),
          onRefresh: () => dealProvider.requestListOfDeals,
        ),
      )
    );
  }
}