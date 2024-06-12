import 'package:flutter/material.dart';

class PostButton extends StatelessWidget {
  final void Function()? onTap;
  const PostButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.only(left: 10),
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.circular(12)),
        child: const Icon(Icons.done_outline),
      ),
    );
  }
}
