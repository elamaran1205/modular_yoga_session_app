import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yoga2/views/onboard/level_selection.dart';
import 'package:yoga2/views/onboard/onboarding_screen.dart';
import 'package:yoga2/views/session/yoga_session_player.dart';
import '../models/yoga_session.dart'; 
import '../views/home/home_screen.dart';

abstract class AppPages {
  static const INITIAL = '/onboarding';
  
  static final routes = [
    GetPage(name: '/onboarding', page: () => OnboardingScreen()),
    GetPage(name: '/level-selection', page: () => LevelSelection()),
    GetPage(name: '/home', page: () => HomeScreen()),
    
   
    GetPage(
      name: '/session-player',
      page: () {
       
        final dynamic arguments = Get.arguments;
        if (arguments is YogaSession) {
          return YogaSessionPlayer(session: arguments);
        } else {
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