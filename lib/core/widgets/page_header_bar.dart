import 'package:flutter/material.dart';

class PageHeaderBar extends StatelessWidget {
  final String title;
  final VoidCallback? onClose;
  final Color backgroundColor;
  final Color textColor;

  const PageHeaderBar({
    super.key,
    required this.title,
    this.onClose,
    this.backgroundColor = Colors.amber,
    this.textColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor,
      child: SafeArea(
        child: SizedBox(
          height: kToolbarHeight,
          child: Padding(
            padding: const EdgeInsets.only(left: 25, right: 8, top: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: textColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.close, color: textColor),
                  onPressed: onClose ?? () => Navigator.pop(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
