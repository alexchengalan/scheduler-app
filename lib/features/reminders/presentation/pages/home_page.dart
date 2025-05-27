import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:scheduler/app/router.dart';
import 'package:scheduler/core/services/notification_permissions.dart';
import 'package:scheduler/core/services/notification_service.dart';
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
  void initState() {
    super.initState();
    _checkPermissions();
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
            onPressed: () async {
              // await NotificationService().showImmediateNotification(
              //   id: 1,
              //   title: "Test Reminder",
              //   body: "This should appear as a banner even in foreground",
              //   // dateTime: DateTime.now().add(Duration(seconds: 2)),
              //   // frequency: null,
              // );
              debugPrint('Notification scheduled');

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

  Future<void> _checkPermissions() async {
    final notificationService = NotificationService();
    notificationService.init();

    final granted = await NotificationPermissions.requestPermissions(
      notificationService.flutterLocalNotificationsPlugin,
    );

    if (!granted) {
      _showPermissionDeniedDialog();
    }
  }

  void _showPermissionDeniedDialog() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Permissions Required'),
            content: const Text(
              'Notification permissions are required for reminders. Please enable them in settings.',
            ),
            actions: [
              TextButton(
                onPressed: () async {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () async {
                  Navigator.of(context).pop();
                  await openAppSettings(); // Opens device app settings
                },
                child: const Text('Open Settings'),
              ),
            ],
          ),
    );
  }
}
