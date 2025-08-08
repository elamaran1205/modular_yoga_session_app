// session_controller.dart
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:audioplayers/audioplayers.dart';
import '../models/yoga_session.dart';
import '../services/json_loader.dart';

class SessionController extends GetxController {
  final AudioPlayer audioPlayer = AudioPlayer();
  late YogaSession currentSession;
  Timer? sessionTimer;
  RxInt currentTime = 0.obs;
  RxString currentPose = ''.obs;
  RxString currentInstruction = ''.obs;

  bool _isPlaying = false;

  Future<void> loadSessionFromAssets(String jsonPath) async {
    currentSession = await YogaService.loadSession(jsonPath: jsonPath);
  }

  Future<void> startSession() async {
    if (currentSession.segments.isEmpty) return;
    _isPlaying = true;
    currentTime.value = 0;
    final firstAudio = currentSession.segments[0].audio;
    try {
      await audioPlayer.stop();
      await audioPlayer.play(AssetSource(firstAudio));
    } catch (e) {
      debugPrint('SessionController: startSession audio play error: $e');
    }
    sessionTimer?.cancel();
    sessionTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!_isPlaying) return;
      currentTime.value++;
    });
  }

  void pauseSession() {
    _isPlaying = false;
    sessionTimer?.cancel();
    audioPlayer.pause();
  }

  Future<void> stopSession() async {
    _isPlaying = false;
    sessionTimer?.cancel();
    await audioPlayer.stop();
    currentTime.value = 0;
  }

  @override
  void onClose() {
    sessionTimer?.cancel();
    audioPlayer.dispose();
    super.onClose();
  }
}
