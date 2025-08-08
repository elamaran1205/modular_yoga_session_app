
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:yoga2/models/yoga_session.dart';


class YogaSessionPlayer extends StatefulWidget {
  final YogaSession session;

  const YogaSessionPlayer({Key? key, required this.session}) : super(key: key);

  @override
  _YogaSessionPlayerState createState() => _YogaSessionPlayerState();
}

class _YogaSessionPlayerState extends State<YogaSessionPlayer> {
  int _currentSegmentIndex = 0;
  int _currentScriptIndex = 0;
  int _currentTimeInSegment = 0;
  int _totalElapsedTime = 0;

  Timer? _sessionTimer;
  final AudioPlayer _audioPlayer = AudioPlayer();
  PlayerState _audioState = PlayerState.stopped;
  bool _isPlaying = false;
  bool _sessionStarted = false;

  @override
  void initState() {
    super.initState();


    _audioPlayer.onPlayerComplete.listen((_) {
      debugPrint('Audio completed for segment $_currentSegmentIndex');
      _handleAudioComplete();
    });


    _audioPlayer.onPlayerStateChanged.listen((state) {
      setState(() {
        _audioState = state;
      });
    });

    _resetSession();
  }

  void _resetSession() {
    _currentSegmentIndex = 0;
    _currentScriptIndex = 0;
    _currentTimeInSegment = 0;
    _totalElapsedTime = 0;
    _isPlaying = false;
    _audioState = PlayerState.stopped;
    _sessionStarted = false;
    _sessionTimer?.cancel();
  }

  Future<void> _startSession() async {

    if (widget.session.segments.isEmpty) {
      Get.snackbar('No session', 'Session contains no segments');
      return;
    }

    
    _sessionTimer?.cancel();
    try {
      await _audioPlayer.stop();
    } catch (_) {}

    setState(() {
      _isPlaying = true;
      _sessionStarted = true;
    });

   
    await _playCurrentSegment();

    _sessionTimer = Timer.periodic(const Duration(seconds: 1), _sessionTimerCallback);
  }

  Future<void> _playCurrentSegment() async {
    final segment = widget.session.segments[_currentSegmentIndex];

  
    final audioPath = segment.audio;
    debugPrint('Playing audio: $audioPath for segment $_currentSegmentIndex');

    try {
      await _audioPlayer.stop();
     
      await _audioPlayer.play(AssetSource(audioPath));
      setState(() {
        _audioState = PlayerState.playing;
        _isPlaying = true;
      });
    } catch (e, st) {
      debugPrint('Audio play failed for $audioPath: $e\n$st');
      setState(() {
        _audioState = PlayerState.stopped;
        _isPlaying = false;
      });
      Get.snackbar('Audio error', 'Failed to play $audioPath');
    }
  }

  void _handleAudioComplete() {
   
    if (_currentSegmentIndex < widget.session.segments.length - 1) {
      _nextSegment();
    } else {
      _endSession();
    }
  }

  void _nextSegment() {
    debugPrint('Moving to next segment from $_currentSegmentIndex');
    _sessionTimer?.cancel();
    setState(() {
      _currentSegmentIndex++;
      _currentScriptIndex = 0;
      _currentTimeInSegment = 0;
    });
  
    _playCurrentSegment();
   
    _sessionTimer = Timer.periodic(const Duration(seconds: 1), _sessionTimerCallback);
  }

  void _sessionTimerCallback(Timer timer) {
    if (!_isPlaying) return;


    setState(() {
      _currentTimeInSegment++;
      _totalElapsedTime++;
    });

    final currentSegment = widget.session.segments[_currentSegmentIndex];
    if (_currentScriptIndex < currentSegment.script.length - 1) {
      final nextScriptStart = currentSegment.script[_currentScriptIndex + 1].startSec;
      if (_currentTimeInSegment >= nextScriptStart) {
        setState(() {
          _currentScriptIndex++;
        });
      }
    }


    final segmentDuration = currentSegment.script.last.endSec;
    if (_currentTimeInSegment >= segmentDuration) {

      if (_currentSegmentIndex < widget.session.segments.length - 1) {
        _nextSegment();
      } else {
        _endSession();
      }
    }
  }

  void _togglePlayPause() async {
    if (_isPlaying) {
      await _audioPlayer.pause();
      _sessionTimer?.cancel();
      setState(() {
        _audioState = PlayerState.paused;
        _isPlaying = false;
      });
    } else {
      try {
        await _audioPlayer.resume();
        _sessionTimer?.cancel();
        _sessionTimer = Timer.periodic(const Duration(seconds: 1), _sessionTimerCallback);
        setState(() {
          _audioState = PlayerState.playing;
          _isPlaying = true;
        });
      } catch (e) {
        debugPrint('Error resuming audio: $e');
        _startSession();
      }
    }
  }

  void _endSession() {
    _sessionTimer?.cancel();
    _audioPlayer.stop();
    setState(() {
      _isPlaying = false;
      _audioState = PlayerState.stopped;
    });
  }

  Future<void> _restartSession() async {
    _sessionTimer?.cancel();
    await _audioPlayer.stop();
    setState(() {
      _resetSession();
      _sessionStarted = true;
    });
    await _startSession();
  }

  void _onBackPressed() {
    _sessionTimer?.cancel();
    _audioPlayer.dispose();
    Get.back();
  }

  void _startButtonPressed() {
    debugPrint('Start pressed. firstSegmentAudio=${widget.session.segments[0].audio}');
    debugPrint('first imageRef=${widget.session.segments[0].script[0].imageRef}');
    setState(() {
      _sessionStarted = true;
    });
    _startSession();
  }

  @override
  void dispose() {
    _sessionTimer?.cancel();
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentSegment = widget.session.segments[_currentSegmentIndex];
    final currentScript = currentSegment.script[_currentScriptIndex];

    final progressDenominator = currentScript.endSec > 0 ? currentScript.endSec : 1;
    final progressValue = _currentTimeInSegment / progressDenominator;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(widget.session.name, style: const TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: _onBackPressed,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Wrap(
                alignment: WrapAlignment.end,
                children: [
                  IconButton(
                    icon: const Icon(Icons.replay),
                    onPressed: _sessionStarted ? _restartSession : null,
                    tooltip: 'Restart Session',
                  ),
                  const SizedBox(width: 5),
                  IconButton(
                    icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow,
                        color: _sessionStarted ? Colors.black : Colors.grey),
                    onPressed: _sessionStarted ? _togglePlayPause : null,
                  ),
                  Center(
                    child: Text(
                      '${(_totalElapsedTime ~/ 60).toString().padLeft(2, '0')}:'
                      '${(_totalElapsedTime % 60).toString().padLeft(2, '0')}',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: _sessionStarted ? Colors.black : Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            
            Container(
              height: MediaQuery.of(context).size.height * 0.4,
              child: Image.asset(
                currentScript.imageRef,
                fit: BoxFit.contain,
              ),
            ),

            
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                currentScript.text,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
            ),

            
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: LinearProgressIndicator(
                value: progressValue.clamp(0.0, 1.0),
                minHeight: 8,
                backgroundColor: Colors.grey[300],
                color: Colors.amber,
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: currentSegment.script.length,
              itemBuilder: (context, index) {
                final item = currentSegment.script[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage(item.imageRef),
                  ),
                  title: Text(item.text),
                  trailing: Text('${item.startSec}-${item.endSec} sec'),
                  tileColor: index == _currentScriptIndex ? Colors.amber.withOpacity(0.1) : null,
                );
              },
            ),

            const SizedBox(height: 20),

            // Buttons Row with Start button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(width: 10,),
                // Previous Button
                ElevatedButton.icon(
                  onPressed: _sessionStarted ? () {} : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                      side: const BorderSide(color: Colors.amber),
                    ),
                  ),
                  icon: const Icon(Icons.arrow_back),
                  label: const Text('Previous'),
                ),

                // Conditional Start Button
                if (!_sessionStarted)
                  ElevatedButton(
                    onPressed: _startButtonPressed,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber,
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text('START', style: TextStyle(fontWeight: FontWeight.bold)),
                  )
                else
                  const SizedBox(width: 0), 

                // Next Button
                ElevatedButton.icon(
                  onPressed: _sessionStarted ? () {} : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber,
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                      side: const BorderSide(color: Colors.black),
                    ),
                  ),
                  icon: const Icon(Icons.arrow_forward),
                  label: const Text('Next'),
                ),
                SizedBox(width: 10,)
              ],
            )
          ],
        ),
      ),
    );
  }
}
