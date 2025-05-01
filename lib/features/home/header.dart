import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                'Hello, ',
                style: Theme.of(context).textTheme.bodyMedium,
              ),Text(
                'Olivia',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const CircleAvatar(
            radius: 18,
            backgroundImage: AssetImage("assets/images/face.webp"),
          ),
        ],
      ),
    );
  }
}