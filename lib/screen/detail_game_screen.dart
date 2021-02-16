import 'package:flutter/material.dart';
import 'package:gameshop_deals/widget/view_gamelookup/swipe_page.dart';

class DetailGamePageView extends StatefulWidget {
  final int offset;
  const DetailGamePageView({Key key, this.offset}) : super(key: key);

  @override
  _DetailGamePageViewState createState() => _DetailGamePageViewState();
}

class _DetailGamePageViewState extends State<DetailGamePageView> {
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
    return SafeArea(
      child: Scaffold(
        body: PageDeal(controller: pageController),
        bottomNavigationBar: PageVisualizer(controller: pageController),
      ),
    );
  }
}