import 'dart:math';
import 'package:flutter/material.dart';

class CircularRevealRoute extends PageRouteBuilder {
  final Widget page;
  final Offset centerOffset;
  final Color backgroundColor;
  final Duration duration;

  CircularRevealRoute({
    required this.page,
    required this.centerOffset,
    this.backgroundColor = Colors.amber,
    this.duration = const Duration(milliseconds: 600),
  }) : super(
         transitionDuration: duration,
         pageBuilder: (context, animation, secondaryAnimation) => page,
         transitionsBuilder: (context, animation, secondaryAnimation, child) {
           return AnimatedBuilder(
             animation: animation,
             builder: (context, _) {
               final radius = Tween<double>(
                 begin: 0.0,
                 end: _calculateMaxRadius(context, centerOffset),
               ).animate(
                 CurvedAnimation(parent: animation, curve: Curves.easeOutCubic),
               );

               return Stack(
                 children: [
                   Positioned.fill(
                     child: CustomPaint(
                       painter: _RevealPainter(
                         radius: radius.value,
                         center: centerOffset,
                         color: backgroundColor,
                       ),
                     ),
                   ),
                   if (animation.value > 0.99) child, // Show page after reveal
                 ],
               );
             },
           );
         },
       );

  static double _calculateMaxRadius(BuildContext context, Offset center) {
    final size = MediaQuery.of(context).size;
    final dx = max(center.dx, size.width - center.dx);
    final dy = max(center.dy, size.height - center.dy);
    return sqrt(dx * dx + dy * dy);
  }
}

class _RevealPainter extends CustomPainter {
  final double radius;
  final Offset center;
  final Color color;

  _RevealPainter({
    required this.radius,
    required this.center,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    canvas.drawCircle(center, radius, paint);
  }

  @override
  bool shouldRepaint(covariant _RevealPainter oldDelegate) =>
      oldDelegate.radius != radius || oldDelegate.center != center;
}
