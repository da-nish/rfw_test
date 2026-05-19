import 'package:flutter/material.dart';

class UserCard extends StatelessWidget {

  final String name;
  final VoidCallback onTap;
  // final Function(String, int) onTap;

  const UserCard({
    super.key,
    required this.name,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {

    return Card(
      child: ListTile(
        title: Text(name),
        onTap: onTap,
        // onTap: onTap(name, 999),
      ),
    );
  }
}