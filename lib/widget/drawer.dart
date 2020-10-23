import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:gameshop_deals/provider/deal_provider.dart';
import 'package:gameshop_deals/screen/filter_screen.dart';
import 'package:gameshop_deals/provider/filter_provider.dart';

class FilterScreen extends StatelessWidget{
  final bool isDrawer;

  FilterScreen({this.isDrawer = false});

  @override
  Widget build(BuildContext context) {
    final DealProvider dealProvider = Provider.of<DealProvider>(context, listen: false);
    final FilterProvider filterProvider = dealProvider.filter;
    return isDrawer ?
    Drawer(
        child: FilterPage(filterProvider)//FilterPage(dealProvider.parameters),
    ) :
    SafeArea(
        child: Material(
            child: FilterPage(filterProvider) //FilterPage(dealProvider.parameters)
        )
    );
  }
}

class EndDrawer extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    final DealProvider dealProvider = Provider.of<DealProvider>(context, listen: false);
    final FilterProvider filterProvider = dealProvider.filter;
    return Drawer(
      child: FilterPage(filterProvider)//FilterPage(dealProvider.parameters),
    );
  }
}