import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget {
  final String title;
  final VoidCallback logout;

  const MyAppBar({
    super.key,
    required this.title,
    required this.logout,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
        title: Text(title),
        actions: [
          IconButton(
            onPressed: logout,
            icon: const Icon(Icons.logout)
          )
        ],
      );
  }
}