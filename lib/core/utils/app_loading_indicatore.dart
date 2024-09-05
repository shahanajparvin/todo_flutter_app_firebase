import 'package:flutter/material.dart';
import 'dart:math' as math;

class AppLoadingIndicator extends StatefulWidget {
  @override
  _AppLoadingIndicatorState createState() => _AppLoadingIndicatorState();
}

class _AppLoadingIndicatorState extends State<AppLoadingIndicator> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, child) {
        return CustomPaint(
          painter: LoadingPainter(_controller.value),
          size: Size(45, 45),
        );
      },
    );
  }
}

class LoadingPainter extends CustomPainter {
  final double animationValue;

  LoadingPainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final gradient = SweepGradient(
      startAngle: 0,
      endAngle: math.pi * 2,
      colors: [Colors.blue, Colors.yellow],
      stops: [0.0, animationValue],
    );

    final paint = Paint()
      ..shader = gradient.createShader(rect)
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;

    canvas.drawArc(
      rect,
      -math.pi / 2,
      math.pi * 2 * animationValue,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}