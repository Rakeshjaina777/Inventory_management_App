// import 'package:flutter/material.dart';
//
// // Function to check authentication
// Future<bool> isLoggedIn() async {
//   final token = await SecureStorage.getToken();
//   return token != null && token.isNotEmpty;
// }
//
// // Define a page transition with fade animation
// Page<dynamic> _customTransitionPage(Widget child) {
//   return CustomTransitionPage(
//     child: child,
//     transitionsBuilder: (context, animation, secondaryAnimation, child) {
//       return FadeTransition(opacity: animation, child: child);
//     },
//   );
// }
//
// final GoRouter router = GoRouter(
//   initialLocation: '/navigation',
//   routes: [
//     GoRoute(
//       path: '/splash',
//       pageBuilder: (context, state) => _customTransitionPage(const SplashScreen()),
//     ),
//
//   ],
//   redirect: (context, state) async {
//     bool loggedIn = await isLoggedIn();
//
//     if (state.fullPath == '/splash') {
//       return loggedIn ? '/navigation' : '/login';
//     }
//     return null;
//   },
// );
//
