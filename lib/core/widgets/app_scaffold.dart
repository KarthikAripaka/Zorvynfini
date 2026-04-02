// ─── lib/core/widgets/app_scaffold.dart ───
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppScaffold extends StatefulWidget {
  const AppScaffold({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  State<AppScaffold> createState() => _AppScaffoldState();
}

class _AppScaffoldState extends State<AppScaffold> {
  int _currentIndex = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final location = GoRouterState.of(context).uri.path;
    _currentIndex = _getIndexFromLocation(location);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() => _currentIndex = index);
          switch (index) {
            case 0:
              context.go('/');
            case 1:
              context.go('/transactions');
            case 2:
              context.go('/goals');
            case 3:
              context.go('/insights');
          }
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.dashboard_outlined),
            selectedIcon: Icon(Icons.dashboard),
            label: 'Home',
            tooltip: 'Dashboard',
          ),
          NavigationDestination(
            icon: Icon(Icons.receipt_long_outlined),
            selectedIcon: Icon(Icons.receipt_long),
            label: 'Transactions',
            tooltip: 'Transactions',
          ),
          NavigationDestination(
            icon: Icon(Icons.flag_outlined),
            selectedIcon: Icon(Icons.flag),
            label: 'Goals',
            tooltip: 'Goals & Challenges',
          ),
          NavigationDestination(
            icon: Icon(Icons.insights_outlined),
            selectedIcon: Icon(Icons.insights),
            label: 'Insights',
            tooltip: 'Analytics',
          ),
        ],
      ),
    );
  }

  int _getIndexFromLocation(String location) {
    switch (location) {
      case '/':
        return 0;
      case '/transactions':
        return 1;
      case '/goals':
        return 2;
      case '/insights':
        return 3;
      default:
        return 0;
    }
  }
}
