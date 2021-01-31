import 'package:flutter/material.dart';
import 'dart:math';

class AnimatedRadial extends StatefulWidget {
  final String percentage;

  const AnimatedRadial({Key key, this.percentage}) : super(key: key);

  @override
  _AnimatedRadialState createState() => _AnimatedRadialState();
}

class _AnimatedRadialState extends State<AnimatedRadial>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  double _percentage;

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
  void didUpdateWidget(covariant AnimatedRadial oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.percentage != oldWidget.percentage) {
      _percentage = (double.tryParse(widget.percentage) ?? 0) / 100;
      if (_controller.value != _percentage) _controller.animateTo(_percentage);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
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
            '${widget.percentage}%',
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
          ..strokeWidth = 2.5,
        line = Paint()
          ..color = Colors.grey[700]
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2.5,
        super(repaint: listenable);

  @override
  void paint(Canvas canvas, Size size) {
    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = min(size.width / 2, size.height / 2) - 2.5;
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
