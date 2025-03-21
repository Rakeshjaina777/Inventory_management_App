import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:healthgini/src/apps/doctor/presentation/screens/auth/doctor_login_screen.dart';
import 'package:healthgini/src/apps/doctor/presentation/screens/doctor_central_screen/doctor_appointment/doctor_appointments_major_screen/doctor_appointment_screen.dart';
import 'package:healthgini/src/apps/doctor/presentation/screens/doctor_dashboard_screen.dart';
import 'package:healthgini/src/apps/doctor/presentation/screens/doctor_central_screen/doctor_homepage_screen.dart';
import 'package:healthgini/src/apps/doctor/presentation/screens/doctor_central_screen/Doctor_profile_screen/doctor_profile_screen.dart';
import 'package:healthgini/src/apps/doctor/presentation/screens/Minor_screen/doctor_Navigation_screen.dart';
import 'package:healthgini/src/shared/screens/splash_screen.dart';
import 'package:healthgini/src/core/storage/secure_storage.dart';


import '../apps/doctor/presentation/screens/Auth/doctor_signup_screen.dart';
import '../apps/doctor/presentation/screens/Auth/verification/doctor_verification_screen.dart';
import '../apps/doctor/presentation/screens/auth/doctor_create_password_screen.dart';
import '../apps/doctor/presentation/screens/auth/doctor_otp_verification_screen.dart';
import '../apps/doctor/presentation/screens/auth/forgot_password_enter_email.dart';
import '../apps/doctor/presentation/screens/doctor_central_screen/doctor_appointment/doctor_appointments_major_screen/common_Appointment_screen.dart';
import '../apps/doctor/presentation/screens/doctor_central_screen/doctor_appointment/doctor_appointments_major_screen/doctor_appointment_patient_detail_ai_screen.dart';
import '../apps/doctor/presentation/screens/doctor_central_screen/doctor_appointment/doctor_appointments_major_screen/doctor_appointment_patient_detail_screen.dart';

// Function to check authentication
Future<bool> isLoggedIn() async {
  final token = await SecureStorage.getToken();
  return token != null && token.isNotEmpty;
}

// Define a page transition with fade animation
Page<dynamic> _customTransitionPage(Widget child) {
  return CustomTransitionPage(
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(opacity: animation, child: child);
    },
  );
}

final GoRouter router = GoRouter(
  initialLocation: '/navigation',
  routes: [
    GoRoute(
      path: '/splash',
      pageBuilder: (context, state) => _customTransitionPage(const SplashScreen()),
    ),

    GoRoute(
      path: '/appointment',
      pageBuilder: (context, state) => _customTransitionPage( AppointmentsScreen()),
    ),
    GoRoute(
      path: '/login',
      pageBuilder: (context, state) => _customTransitionPage(const DoctorLoginScreen()),
    ),
    GoRoute(
      path: '/dashboard',
      pageBuilder: (context, state) => _customTransitionPage( DoctorDashboard()),
    ),
    GoRoute(
      path: '/Documentverification',
      pageBuilder: (context, state) => _customTransitionPage( DocumentVerificationScreen()),
    ),
    GoRoute(
      path: '/create-password',
      pageBuilder: (context, state) {
        // Extract extra data
        final Map<String, dynamic>? data = state.extra as Map<String, dynamic>?;

        if (data == null || !data.containsKey('token')) {
          throw Exception("Missing required 'token' parameter for Create Password Screen");
        }

        return _customTransitionPage(DoctorCreatePasswordScreen(
          token: data['token'],
        ));
      },
    ),

    GoRoute(
      path: '/otp-verification',
      pageBuilder: (context, state) {
        // Extract extra data
        final Map<String, dynamic>? data = state.extra as Map<String, dynamic>?;

        if (data == null || !data.containsKey('token') || !data.containsKey('purpose')) {
          throw Exception("Missing required parameters for OTP Verification Screen");
        }

        return _customTransitionPage(DoctorOTPVerificationScreen(
          token: data['token'],
          purpose: data['purpose'],
        ));
      },
    ),

    GoRoute(
      path: '/PatientDetailsScreenai',
      pageBuilder: (context, state) => _customTransitionPage( PatientDetailsScreenai()),
    ),

    GoRoute(
      path: '/PatientDetailsScreen',
      pageBuilder: (context, state) => _customTransitionPage( PatientDetailsScreen()),
    ),

    GoRoute(
      path: '/doctor_sign_up',
      pageBuilder: (context, state) => _customTransitionPage( SignupScreen()),
    ),



    GoRoute(
      path: '/doctor_appointment_screen',
      pageBuilder: (context, state) => _customTransitionPage(AppointmentsScreen()),
    ),

    // GoRoute(
    //   path: '/doctor_upcomingappointment_screen',
    //   pageBuilder: (context, state) {
    //     final title = state.extra as String? ?? "Default Title"; // Get title from extra or fallback
    //     return _customTransitionPage(DoctorAppointmentsScreen(title: title));
    //   },
    // ),

    GoRoute(
      path: '/forgot-password',
      pageBuilder: (context, state) => _customTransitionPage(const DoctorForgotPasswordScreen()),
    ),
    // GoRoute(
    //   path: '/homepage',
    //   pageBuilder: (context, state) => _customTransitionPage(const DoctorHomepageScreen()),
    // ),
    GoRoute(
      path: '/profile',
      pageBuilder: (context, state) => _customTransitionPage( DoctorProfileScreen()),
    ),
    GoRoute(
      path: '/navigation',
      pageBuilder: (context, state) => _customTransitionPage( MainScreen()),
    ),
  ],
  redirect: (context, state) async {
    bool loggedIn = await isLoggedIn();

    if (state.fullPath == '/splash') {
      return loggedIn ? '/navigation' : '/login';
    }
    return null;
  },
);

