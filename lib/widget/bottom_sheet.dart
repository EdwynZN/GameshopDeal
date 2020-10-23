import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:gameshop_deals/provider/deal_provider.dart';
import 'package:gameshop_deals/screen/filter_screen.dart';

class BottomFilter extends StatelessWidget{

  _showBottomSheet(BuildContext context){
    showModalBottomSheet(
      context: context,
      isDismissible: false,
      isScrollControlled: true,
      builder: (ctx){
        final DealProvider dealProvider = Provider.of<DealProvider>(ctx, listen: false);
        return SizedBox(
          height: MediaQuery.of(context).size.height - 24,
          child: FilterPage(dealProvider.filter),
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        MaterialButton(
          height: 34,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          highlightColor: Colors.transparent,
          //textColor: Theme.of(context).accentColor,
          //splashColor: Theme.of(context).selectedRowColor,
          onPressed: () => _showBottomSheet(context),
          child: Row(
            children: <Widget>[
              Text('Filter'),
              const SizedBox(width: 8,),
              const Icon(Icons.sort)
            ],
          ),
        )
      ],
    );
  }
}