import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../widgets/app_bottom_navbar.dart';

class MainNavigationView extends StatelessWidget {
  final Widget child;
  final String location;

  const MainNavigationView({
    super.key,
    required this.child,
    required this.location,
  });

  static const List<String> routes = [
    '/home',
    '/explore',
    '/cart',
    '/offer',
    '/account',
  ];

  @override
  Widget build(BuildContext context) {
    final int currentIndex = routes.indexOf(location);

    return Scaffold(
      body: child,
      bottomNavigationBar: AppBottomNavbar(
        currentIndex: currentIndex < 0 ? 0 : currentIndex,
        onTap: (index) {
          context.go(routes[index]);
        },
      ),
    );
  }
}