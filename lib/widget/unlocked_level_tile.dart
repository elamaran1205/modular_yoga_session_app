import 'package:flutter/material.dart';

class UnlockedLevelTile extends StatelessWidget {
  final String level;
  final VoidCallback onTap;

  const UnlockedLevelTile({
    Key? key,
    required this.level,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      color: Colors.black,
      child: ListTile(
        title: Text(
          level,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500,color: Colors.white),
        ),
        trailing: const Icon(Icons.arrow_forward, color: Colors.amber),
        onTap: onTap,
      ),
    );
  }
}