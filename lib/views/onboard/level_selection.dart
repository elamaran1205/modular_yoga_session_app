import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yoga2/widget/locked_level_tile.dart';
import 'package:yoga2/widget/unlocked_level_tile.dart';


class LevelSelection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Select Level')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 16),
            UnlockedLevelTile(
              level: 'Beginner',
              onTap: () => Get.offAllNamed('/home'),
            ),
            const SizedBox(height: 12),
            LockedLevelTile(level: 'Intermediate'),
            const SizedBox(height: 12),
            LockedLevelTile(level: 'Advanced'),
          ],
        ),
      ),
    );
  }
}