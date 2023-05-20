import 'package:flutter/material.dart';
import 'package:gameshop_deals/widget/view_deal/swipe_page.dart';

class DetailDealPageView extends StatefulWidget {
  final int offset;
  const DetailDealPageView({Key? key, this.offset = 0}) : super(key: key);

  @override
  _DetailDealPageViewState createState() => _DetailDealPageViewState();
}

class _DetailDealPageViewState extends State<DetailDealPageView> {
  late final PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: widget.offset);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: PageDeal(controller: pageController),
        bottomNavigationBar: PageVisualizer(controller: pageController),
      ),
    );
  }
}