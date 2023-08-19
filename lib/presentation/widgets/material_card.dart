import 'package:flutter/material.dart';

class TonalCard extends Card {
  const TonalCard({
    super.key,
    super.color,
    super.surfaceTintColor,
    super.elevation,
    super.shape,
    super.borderOnForeground = true,
    super.margin,
    super.clipBehavior,
    super.child,
    super.semanticContainer = true,
  }) : super(shadowColor: Colors.transparent);
}