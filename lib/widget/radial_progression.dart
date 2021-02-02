import 'package:flutter/material.dart';
import 'dart:math';

import 'package:gameshop_deals/generated/l10n.dart';

const double _strokePaint = 3.0;

class AnimatedRadial extends StatefulWidget {
  final String percentage;

  const AnimatedRadial({Key key, @required this.percentage}) : super(key: key);

  @override
  _AnimatedRadialState createState() => _AnimatedRadialState();
}

class _AnimatedRadialState extends State<AnimatedRadial>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  S translate;
  double _percentage;
  String _text;

  @override
  void initState() {
    super.initState();
    _percentage = (double.tryParse(widget.percentage) ?? 0) / 100;
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      debugLabel: widget.toStringShort(),
      vsync: this,
    )
      ..value = 0
      ..animateTo(_percentage);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    translate = S.of(context);
    _text = _percentage == 0 ? translate.no_score : '${widget.percentage}%';
  }

  @override
  void didUpdateWidget(covariant AnimatedRadial oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.percentage != oldWidget.percentage) {
      _percentage = (double.tryParse(widget.percentage) ?? 0) / 100;
      _text = _percentage == 0 ? translate.no_score : '${widget.percentage}%';
      if (_controller.value != _percentage) _controller.animateTo(_percentage);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      foregroundPainter: _RadialProgression(_controller),
      willChange: true,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Text(
            _text,
            style: Theme.of(context).textTheme.button,
          ),
        ),
      ),
    );
  }
}

class _RadialProgression extends CustomPainter {
  final Animation<double> listenable;
  final Paint line;
  final Paint progressLine;
  final TweenSequence<Color> _colorTween = TweenSequence<Color>([
    TweenSequenceItem<Color>(
      tween: ColorTween(begin: Colors.grey[700], end: Colors.red[400]),
      weight: 25,
    ),
    TweenSequenceItem<Color>(
      tween: ColorTween(begin: Colors.red[400], end: Colors.yellow[300]),
      weight: 25,
    ),
    TweenSequenceItem<Color>(
      tween: ColorTween(begin: Colors.yellow[300], end: Colors.amber[300]),
      weight: 25,
    ),
    TweenSequenceItem<Color>(
      tween: ColorTween(begin: Colors.amber[300], end: Colors.lightGreen),
      weight: 20,
    ),
    TweenSequenceItem<Color>(
      tween: ColorTween(begin: Colors.lightGreen, end: Colors.green[600]),
      weight: 5,
    ),
  ]);

  _RadialProgression(this.listenable)
      : progressLine = Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = _strokePaint,
        line = Paint()
          ..color = Colors.grey[700]
          ..style = PaintingStyle.stroke
          ..strokeWidth = _strokePaint,
        super(repaint: listenable);

  @override
  void paint(Canvas canvas, Size size) {
    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = min(size.width / 2, size.height / 2) - _strokePaint;
    assert(radius > 0);
    canvas
      ..drawCircle(center, radius, line)
      ..drawArc(
        Rect.fromCircle(center: center, radius: radius),
        -pi / 2,
        2 * pi * listenable.value,
        false,
        progressLine..color = _colorTween.evaluate(listenable),
      );
  }

  @override
  bool shouldRepaint(_RadialProgression oldDelegate) => false;
}
