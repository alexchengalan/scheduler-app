import 'package:flutter/material.dart';

class IconCircle extends StatelessWidget {
  final IconData icon;
  final Color backgroundColor;
  final Color iconColor;

  const IconCircle({
    super.key,
    required this.icon,
    this.backgroundColor = Colors.amber,
    this.iconColor = Colors.black12,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: backgroundColor,
      child: Icon(icon, color: iconColor),
    );
  }
}
