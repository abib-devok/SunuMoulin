import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sunu_moulin_smarteco/screens/auth/login_screen.dart';
import 'package:sunu_moulin_smarteco/screens/auth/language_selection_screen.dart';
import 'package:sunu_moulin_smarteco/screens/home/connect_to_mill_screen.dart';
import 'package:sunu_moulin_smarteco/screens/milling/milling_setup_screen.dart';
import 'package:sunu_moulin_smarteco/screens/milling/milling_control_screen.dart';
import 'package:sunu_moulin_smarteco/screens/history/milling_history_screen.dart';
import 'package:sunu_moulin_smarteco/screens/settings/settings_screen.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/languages',
        builder: (context, state) => const LanguageSelectionScreen(),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => const ConnectToMillScreen(),
      ),
      GoRoute(
        path: '/milling-setup',
        builder: (context, state) => const MillingSetupScreen(),
      ),
      GoRoute(
        path: '/milling-control',
        builder: (context, state) => const MillingControlScreen(),
      ),
      GoRoute(
        path: '/history',
        builder: (context, state) => const MillingHistoryScreen(),
      ),
      GoRoute(
        path: '/settings',
        builder: (context, state) => const SettingsScreen(),
      ),
    ],
  );
}
