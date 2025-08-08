
import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/yoga_session.dart';

class YogaService {
  static Future<YogaSession> loadSession({required String jsonPath}) async {
    final jsonString = await rootBundle.loadString(jsonPath);
    final jsonData = json.decode(jsonString) as Map<String, dynamic>;

    final Map<String, dynamic> modifiedJson = _fixAssetPaths(jsonData);
    return YogaSession.fromJson(modifiedJson);
  }


  static Map<String, dynamic> _fixAssetPaths(Map<String, dynamic> original) {
    final modified = Map<String, dynamic>.from(original);

    if (modified['segments'] is List) {
      modified['segments'] = (modified['segments'] as List).map((segment) {
        final segMap = Map<String, dynamic>.from(segment);

       
        if (segMap['audio'] is String) {
          String audio = (segMap['audio'] as String).trim();
          audio = audio.replaceFirst(RegExp(r'^(assets/|/)+'), '');
          segMap['audio'] = audio; 
        }

      
        if (segMap['script'] is List) {
          segMap['script'] = (segMap['script'] as List).map((script) {
            final scriptMap = Map<String, dynamic>.from(script);
            if (scriptMap['imageRef'] is String) {
              String img = (scriptMap['imageRef'] as String).trim();
              img = img.replaceFirst(RegExp(r'^/+'), '');
              if (!img.startsWith('assets/')) {
                img = 'assets/$img'; 
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
