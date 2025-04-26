import 'package:flutter/material.dart';

class SocialLoginButton extends StatelessWidget{
  const SocialLoginButton({
    super.key,
    required this.logoPath,
    required this.text,
    required this.onTap,
  });

  final String logoPath;
  final String text;
  final VoidCallback onTap;

  @override
  Widget build (BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black12),
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              logoPath,
              height: 24,
            ),
            const SizedBox(width: 8),
            Text(text),
          ],
        ),
      ),
    );
  }
}