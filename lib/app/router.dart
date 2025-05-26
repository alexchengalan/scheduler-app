import 'package:flutter/material.dart';
import 'package:scheduler/core/animations/circular_reveal_route.dart';
import 'package:scheduler/features/reminders/presentation/pages/create_reminder_page.dart';
import 'package:scheduler/features/reminders/presentation/pages/home_page.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const HomePage());

      case '/createReminder':
        if (args is CircularRevealRouteArgs) {
          return CircularRevealRoute(
            page: const CreateReminderPage(),
            centerOffset: args.centerOffset,
            backgroundColor: args.backgroundColor,
            duration: args.duration,
          );
        }
        return MaterialPageRoute(builder: (_) => const CreateReminderPage());

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}

/// Custom argument class for animated circular reveal route
class CircularRevealRouteArgs {
  final Offset centerOffset;
  final Color backgroundColor;
  final Duration duration;

  CircularRevealRouteArgs({
    required this.centerOffset,
    this.backgroundColor = Colors.amber,
    this.duration = const Duration(milliseconds: 700),
  });
}