import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gameshop_deals/widget/deal_widget.dart';
import 'package:gameshop_deals/widget/view_deal/swipe_page.dart';

class DetailDealScreen extends StatelessWidget {
  const DetailDealScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer(
        builder: (ctx, watch, _) {
          final int indexOffset = watch(indexDeal);
          return _DetailPageView(offset: indexOffset);
        },
      ),
    );
  }
}

class _DetailPageView extends StatefulWidget {
  final int offset;

  const _DetailPageView({Key key, this.offset}) : super(key: key);

  @override
  __DetailPageViewState createState() => __DetailPageViewState();
}

class __DetailPageViewState extends State<_DetailPageView> {
  PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: widget.offset);
  }

  @override
  void dispose() {
    pageController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageDeal(controller: pageController),
      bottomNavigationBar: PageVisualizer(controller: pageController),
    );
  }
}