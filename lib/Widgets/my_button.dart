import 'package:flutter/material.dart';

// Create reusable button
class MyButton extends StatelessWidget {
  final VoidCallback onTap;
  final String buttontext;
  final Color? color;

  const MyButton({
    super.key,
    required this.onTap,
    required this.buttontext,
    this.color = Colors.blueAccent
    });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        backgroundColor: color, 
        shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(10),
        ),
      ),
      onPressed: onTap, 
      child: Text(
        buttontext,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Colors.white
        )
      )
      );
  }
}