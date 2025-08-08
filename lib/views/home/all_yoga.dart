import 'package:flutter/material.dart';

class AllYoga extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            SizedBox(height: 20,),
            Text("All Poses",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
            SizedBox(height: 20,),
            Row(
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
                   SizedBox(height: 20,),
            Row(
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
                   SizedBox(height: 20,),
            Row(
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
                   SizedBox(height: 20,),
            Row(
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
                   SizedBox(height: 20,),
            Row(
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
                   SizedBox(height: 20,),
            Row(
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
          ],
        ),
      ),
    );
  }
}

Widget _buildExerciseBox(String name, String imagePath,double size) {
    return Expanded(
      child: Container(
        height: 100,
        width: 30,
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