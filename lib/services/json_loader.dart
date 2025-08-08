// json_loader.dart
import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/yoga_session.dart';

class YogaService {
  /// Loads JSON from an assets path (eg 'assets/data/poses.json')
  /// and normalizes the audio and image paths.
  static Future<YogaSession> loadSession({required String jsonPath}) async {
    final jsonString = await rootBundle.loadString(jsonPath);
    final jsonData = json.decode(jsonString) as Map<String, dynamic>;

    final Map<String, dynamic> modifiedJson = _fixAssetPaths(jsonData);
    return YogaSession.fromJson(modifiedJson);
  }

  /// Normalizes:
  /// - audio -> relative to assets/ (e.g. "audio/intro.mp3")
  /// - imageRef -> full asset path (e.g. "assets/images/cat.png")
  static Map<String, dynamic> _fixAssetPaths(Map<String, dynamic> original) {
    final modified = Map<String, dynamic>.from(original);

    if (modified['segments'] is List) {
      modified['segments'] = (modified['segments'] as List).map((segment) {
        final segMap = Map<String, dynamic>.from(segment);

        // Normalize audio path -> store as path relative to assets/ (e.g. "audio/intro.mp3")
        if (segMap['audio'] is String) {
          String audio = (segMap['audio'] as String).trim();
          // remove leading slashes or leading 'assets/' if present
          audio = audio.replaceFirst(RegExp(r'^(assets/|/)+'), '');
          segMap['audio'] = audio; // e.g. "audio/intro.mp3"
        }

        // Fix script image paths -> ensure "assets/..." (Image.asset expects full asset path)
        if (segMap['script'] is List) {
          segMap['script'] = (segMap['script'] as List).map((script) {
            final scriptMap = Map<String, dynamic>.from(script);
            if (scriptMap['imageRef'] is String) {
              String img = (scriptMap['imageRef'] as String).trim();
              img = img.replaceFirst(RegExp(r'^/+'), ''); // remove leading slashes
              if (!img.startsWith('assets/')) {
                img = 'assets/$img'; // -> 'assets/images/xxx.png'
              }
              scriptMap['imageRef'] = img;
            }
            return scriptMap;
          }).toList();
        }

        return segMap;
      }).toList();
    }

    return modified;
  }
}
