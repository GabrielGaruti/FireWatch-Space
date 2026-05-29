import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/home/home_screen.dart';
import 'screens/alerts/alerts_screen.dart';
import 'screens/analytics/analytics_screen.dart';
import 'screens/focus/focus_detail_screen.dart';
import 'screens/profile/profile_screen.dart';
import 'theme/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
    systemNavigationBarColor: AppColors.card,
    systemNavigationBarIconBrightness: Brightness.light,
  ));
  runApp(const FireWatchApp());
}

final _router = GoRouter(
  initialLocation: '/',
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) =>
          _ScaffoldWithNavBar(navigationShell: navigationShell),
      branches: [
        StatefulShellBranch(routes: [
          GoRoute(path: '/', builder: (_, __) => const HomeScreen()),
        ]),
        StatefulShellBranch(routes: [
          GoRoute(path: '/alerts', builder: (_, __) => const AlertsScreen()),
        ]),
        StatefulShellBranch(routes: [
          GoRoute(path: '/analytics', builder: (_, __) => const AnalyticsScreen()),
        ]),
        StatefulShellBranch(routes: [
          GoRoute(path: '/profile', builder: (_, __) => const ProfileScreen()),
        ]),
      ],
    ),
    GoRoute(
      path: '/focus/:id',
      builder: (context, state) =>
          FocusDetailScreen(id: state.pathParameters['id'] ?? ''),
    ),
  ],
);

class FireWatchApp extends StatelessWidget {
  const FireWatchApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'FireWatch Space',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark,
      routerConfig: _router,
    );
  }
}

class _ScaffoldWithNavBar extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const _ScaffoldWithNavBar({required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: AppColors.card,
          border: Border(top: BorderSide(color: AppColors.border, width: 1)),
        ),
        child: NavigationBar(
          selectedIndex: navigationShell.currentIndex,
          onDestinationSelected: (index) => navigationShell.goBranch(
            index,
            initialLocation: index == navigationShell.currentIndex,
          ),
          backgroundColor: Colors.transparent,
          indicatorColor: AppColors.primary.withOpacity(0.15),
          elevation: 0,
          surfaceTintColor: Colors.transparent,
          destinations: [
            NavigationDestination(
              icon: Icon(Icons.home_outlined, color: AppColors.mutedForeground, size: 22),
              selectedIcon: Icon(Icons.home_rounded, color: AppColors.primary, size: 22),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(Icons.notifications_outlined, color: AppColors.mutedForeground, size: 22),
              selectedIcon: Icon(Icons.notifications_rounded, color: AppColors.primary, size: 22),
              label: 'Alertas',
            ),
            NavigationDestination(
              icon: Icon(Icons.bar_chart_outlined, color: AppColors.mutedForeground, size: 22),
              selectedIcon: Icon(Icons.bar_chart_rounded, color: AppColors.primary, size: 22),
              label: 'Analytics',
            ),
            NavigationDestination(
              icon: Icon(Icons.person_outline, color: AppColors.mutedForeground, size: 22),
              selectedIcon: Icon(Icons.person_rounded, color: AppColors.primary, size: 22),
              label: 'Perfil',
            ),
          ],
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        ),
      ),
    );
  }
}
