import 'package:flutter/material.dart';

class LockedLevelTile extends StatelessWidget {
  final String level;

  const LockedLevelTile({
    Key? key,
    required this.level,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      color: Colors.black,
      child: ListTile(
        title: Text(
          level,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        trailing: const Icon(Icons.lock, color: Colors.red),
        enabled: false,
      ),
    );
  }
}