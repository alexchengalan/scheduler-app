import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTabSelected;

  const CustomBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTabSelected,
  });

  void _onNavBarTapped(int index) {
    onTabSelected(index);
  }

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: SizedBox(
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(
                size: currentIndex == 0 ? 40 : 30,
                Icons.article,
                color: currentIndex == 0 ? Colors.amber : Colors.white,
              ),
              onPressed: () => _onNavBarTapped(0),
            ),
            const SizedBox(width: 48), // Space for FAB
            IconButton(
              icon: Icon(
                size: currentIndex == 1 ? 35 : 28,
                Icons.calendar_today,
                color: currentIndex == 1 ? Colors.amber : Colors.white,
              ),
              onPressed: () => _onNavBarTapped(1),
            ),
          ],
        ),
      ),
    );
  }
}
