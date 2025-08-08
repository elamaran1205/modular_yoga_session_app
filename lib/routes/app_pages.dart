import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yoga2/views/onboard/level_selection.dart';
import 'package:yoga2/views/onboard/onboarding_screen.dart';
import 'package:yoga2/views/session/yoga_session_player.dart';
import '../models/yoga_session.dart'; // Add this import
import '../views/home/home_screen.dart';

abstract class AppPages {
  static const INITIAL = '/onboarding';
  
  static final routes = [
    GetPage(name: '/onboarding', page: () => OnboardingScreen()),
    GetPage(name: '/level-selection', page: () => LevelSelection()),
    GetPage(name: '/home', page: () => HomeScreen()),
    
    // Fixed session-player route with argument handling
    GetPage(
      name: '/session-player',
      page: () {
        // Safely get and cast the arguments
        final dynamic arguments = Get.arguments;
        if (arguments is YogaSession) {
          return YogaSessionPlayer(session: arguments);
        } else {
          // Fallback to a default session or show error
          return Scaffold(
            body: Center(
              child: Text('Error: Invalid session data'),
            ),
          );
        }
      },
    ),
  ];
}