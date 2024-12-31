import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nibm_unity/pages/ai_chat_page.dart';
import 'package:nibm_unity/pages/dashboard_page.dart';
import 'package:nibm_unity/pages/landing_page.dart';
import 'package:nibm_unity/pages/landing_pages/event_cards_only_page.dart';
import 'package:nibm_unity/pages/login_page.dart';
import 'package:nibm_unity/widgets/splash_screen.dart';

class RouterClass {
  final router = GoRouter(
    initialLocation: '/',
    errorPageBuilder: (context, state) {
      return MaterialPage(
        key: state.pageKey,
        child: Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Error'),
                Text(state.error!.message),
              ],
            ),
          ),
        ),
      );
    },
    routes: [
      GoRoute(
        path: '/home',
        name: 'home',
        builder: (context, state) {
          return LandingPage();
        },
        routes: [
          GoRoute(
        path: 'events1',
        name: 'No-log-events',
        builder: (context, state) {
          return const EventCardsPage();
        },
      ),
        ]
      ),
      GoRoute(
        path: '/',
        name: 'splash-screen',
        builder: (context, state) {
          return const SplashScreen();
        },
      ),
      
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) {
          return const LoginPage();
        },
      ),
      GoRoute(
        path: '/ai-chat',
        name: 'ai-chat',
        builder: (context, state) {
          return const ChatPage();
        },
      ),
      GoRoute(
        path: '/dashboard',
        name: 'dashboard',
        builder: (context, state) {
          return const DashboardPage();
        },
      ),
    ],
  );
}
