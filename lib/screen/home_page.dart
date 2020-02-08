import 'package:flutter/material.dart';
import 'package:gameshop_deals/widget/card.dart';
import 'package:gameshop_deals/widget/drawer.dart';
import 'package:gameshop_deals/widget/appbar.dart';
import 'package:gameshop_deals/model/deal.dart';
import 'package:gameshop_deals/provider/deal_provider.dart';
import 'package:provider/provider.dart';
import 'package:gameshop_deals/provider/theme_provider.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DealProvider dealProvider;
  ThemeProvider themeProvider;
  final Deal deal = Deal(
    title: 'Lorem ipsum dolor ',
    dealId: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis blandit',
    dealRating: '7.9',
    gameId: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis blandit',
    isOnSale: '1',
    metacriticScore: '84',
    savings: 54,
    salePrice: '24.99',
    normalPrice: '49.99',
    releaseDate: 1576494456,
    storeId: '9',
    thumb: "https://www.gamersgate.com/media/products/profile/132203/180_259.jpg"
  );

  @override
  Widget build(BuildContext context) {
    dealProvider = Provider.of<DealProvider>(context, listen: false);
    themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    return SafeArea(
      child: Scaffold(
        drawer: Drawer(),
        endDrawer: FilterDrawer(dealProvider.parameters),
        appBar: AppBar(
          shape: CustomAppBarShape(),
          primary: true,
          title: Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis blandit'),
          actions: <Widget>[
            const Icon(Icons.remove_red_eye),
            const SizedBox(width: 10,),
            Builder(
              builder: (BuildContext ctx) =>
                IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () => Scaffold.of(ctx).openEndDrawer(),
                  tooltip: 'Open filter menu',
                )
            ),
            const SizedBox(width: 10,)
          ],
        ),
        body: RefreshIndicator(
          child: CustomScrollView(
            slivers: <Widget>[
              /*
              HomeAppBar(),
              */
              SliverToBoxAdapter(
                child: IconButton(
                  icon: const Icon(Icons.brightness_low),
                  onPressed: () {
                    if(themeProvider.preferredTheme == ThemeMode.light)
                      themeProvider.themePreference('Dark');
                    else themeProvider.themePreference('Light');
                  }
                ),
              ),
              StreamProvider<List<Deal>>.value(
                value: dealProvider.collectionList,
                child: Consumer<List<Deal>>(
                  builder: (BuildContext ctx, deals, child){
                    if(deals != null) {
                      if(deals.isNotEmpty) return SliverList(
                          delegate: SliverChildBuilderDelegate((BuildContext _, int index) {
                            return DealCard2(deal: deals[index],);
                          },
                            childCount: deals?.length != null ? deals?.length : 0,
                          )
                      );
                      return SliverFillRemaining(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            const Icon(Icons.signal_wifi_off, size: 40,),
                            const SizedBox(height: 40),
                            const Text('No internet connection', style: TextStyle(fontSize: 18))
                          ],
                        )
                      );
                    }
                    return child;
                  },
                  child: SliverFillRemaining(child: Center(child: CircularProgressIndicator())),
                ),
                catchError: (BuildContext ctx, error){
                  Scaffold.of(ctx).showSnackBar(SnackBar(
                    content: Text('No internet'),
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
        //extendBodyBehindAppBar: true,
      )
    );
  }
}