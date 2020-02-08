import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      shape: CustomAppBarShape(),
      pinned: true, primary: true,
      title: Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis blandit'),
      actions: <Widget>[
        const Icon(Icons.search),
        const SizedBox(width: 20,),
        const Icon(Icons.remove_red_eye),
        const SizedBox(width: 20,)
      ],
    );
  }
}

class CustomAppBarShape extends ContinuousRectangleBorder{

  @override
  Path getOuterPath(Rect rect, { TextDirection textDirection }) {
    return Path()..lineTo(0, rect.height)
      ..quadraticBezierTo(rect.width / 2, rect.height + 20, rect.width, rect.height)
      ..lineTo(rect.width, 0);
  }
}