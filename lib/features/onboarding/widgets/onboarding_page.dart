import 'package:flutter/material.dart';

class OnboardingPage extends StatelessWidget{
  const OnboardingPage({
    super.key,
    required this.title,
    required this.subtitle,
    required this.buttonText,
    required this.image,
    required this.onButtonPressed,
  });

  final String title;
  final String subtitle;
  final String buttonText;
  final String image;
  final VoidCallback onButtonPressed;

  @override
  Widget build(BuildContext context){
    return Column(
      children: [
        Image.asset(
          fit: BoxFit.cover,
          image, 
          height: 500,            
        ),
        const SizedBox(height: 20),
        Column(
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            if (subtitle.isNotEmpty) ...[
              const SizedBox(height: 16),
              Text(
                subtitle,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],     
          ],
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
          ),
          onPressed: onButtonPressed, 
          child: Text(buttonText),
        ),
      ],
    );
  }
}