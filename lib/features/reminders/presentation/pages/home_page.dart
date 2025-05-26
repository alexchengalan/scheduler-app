import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:scheduler/app/router.dart';
import 'package:scheduler/features/reminders/presentation/pages/calendar_view_page.dart';
import 'package:scheduler/core/widgets/bottom_nav_bar.dart';
import 'reminders_list_page.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  int _selectedIndex = 0;

  void _onTabSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: IndexedStack(
          index: _selectedIndex,
          children: const [RemindersListPage(), RemindersCalendarPage()],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Builder(
        builder: (context) {
          return FloatingActionButton(
            heroTag: 'fab',
            backgroundColor: Colors.amber,
            onPressed: () {
              final renderBox = context.findRenderObject() as RenderBox;
              final fabOffset = renderBox.localToGlobal(
                renderBox.size.center(Offset.zero),
              );

              Navigator.of(context).pushNamed(
                '/createReminder',
                arguments: CircularRevealRouteArgs(centerOffset: fabOffset),
              );
            },
            child: const Icon(Icons.add),
          );
        },
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _selectedIndex,
        onTabSelected: _onTabSelected,
      ),
    );
  }
}
