import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yoga2/services/json_loader.dart';


class DailyRoutine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 150,
              width: 500,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: const LinearGradient(
                  colors: [
                    Colors.black87,
                    Color.fromARGB(255, 10, 25, 39),
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  )
                ],
              ),
              child: Stack(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 20, left: 20),
                    child: Text(
                      '15-min Morning Routine',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 12,
                    right: 12,
                    child: Container(
                     height: 40,
                     width: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFFFFC107),
                            Color(0xFFFF9800), 
                          ],
                        ),
                      ),
                      child: TextButton.icon(
                       onPressed: () async {
    try {
      final session = await YogaService.loadSession(jsonPath: 'assets/data/poses.json');
      Get.toNamed(
        '/session-player',
        arguments: session, 
      );
    } catch (e) {
      Get.snackbar('Error', 'Failed to load yoga session: $e');
    }
  },
                        icon: const Icon(Icons.play_arrow, size: 16, color: Colors.black),
                        label: const Text('Start', style: TextStyle(color: Colors.black)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20,),
            Align(alignment: Alignment.centerLeft, child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text("Recent Excercie",style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),),
            )),
            SizedBox(height: 20,),
             SizedBox(
              height: 120,
              child: Row(
                children: [
                  _buildExerciseBox("Cat-cow Pose", "assets/images/cat1.png",10),
                  const SizedBox(width: 10),
                  _buildExerciseBox("Cobra stretch", "assets/images/cobra.png",10),
                  const SizedBox(width: 10),
                  _buildExerciseBox("Updown", "assets/images/super.png",10),
                  const SizedBox(width: 10),
                  _buildExerciseBox("Meditation", "assets/images/med.png",10),
                ],
              ),
            ),
            SizedBox(height: 21,)
          ],
        ),
      ),
    );
  }
}

Widget _buildExerciseBox(String name, String imagePath,double size) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
           gradient: const LinearGradient(
                colors: [
                  Colors.black87,
                  Color.fromARGB(255, 10, 25, 39), 
                ],
              ),
          image: DecorationImage(
            image: AssetImage(imagePath),
            fit: BoxFit.contain,
          ),
        ),
        child: Align(
          alignment: Alignment.bottomLeft,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              name,
              style:TextStyle(
                color: Colors.white,
                fontSize: size,
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(
                    blurRadius: 6,
                    color: Colors.black,
                    offset: Offset(0, 1),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
}
