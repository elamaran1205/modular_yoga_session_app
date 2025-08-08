// sessionmodel.dart
class YogaSession {
  final String name;
  final String description;
  final List<Segment> segments;

  YogaSession({
    required this.name,
    required this.description,
    required this.segments,
  });

  factory YogaSession.fromJson(Map<String, dynamic> json) {
    return YogaSession(
      name: json['name'],
      description: json['description'],
      segments: List<Segment>.from(json['segments'].map((x) => Segment.fromJson(x))),
    );
  }
}

class Segment {
  final String type;
  final String audio; // expected like 'audio/intro.mp3'
  final int? loops;
  final List<ScriptItem> script;

  Segment({
    required this.type,
    required this.audio,
    this.loops,
    required this.script,
  });

  factory Segment.fromJson(Map<String, dynamic> json) {
    return Segment(
      type: json['type'],
      audio: json['audio'],
      loops: json['loops'],
      script: List<ScriptItem>.from(json['script'].map((x) => ScriptItem.fromJson(x))),
    );
  }
}

class ScriptItem {
  final String text;
  final int startSec;
  final int endSec;
  final String imageRef; // expected full path 'assets/images/xxx.png'

  ScriptItem({
    required this.text,
    required this.startSec,
    required this.endSec,
    required this.imageRef,
  });

  factory ScriptItem.fromJson(Map<String, dynamic> json) {
    return ScriptItem(
      text: json['text'],
      startSec: json['startSec'],
      endSec: json['endSec'],
      imageRef: json['imageRef'],
    );
  }
}
