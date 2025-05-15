import 'package:flutter/material.dart';
import 'package:ovia_app/api_connectors/login.dart';

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
                Auth().userName!,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          CircleAvatar(
            radius: 18,
            backgroundImage: AssetImage(Auth().userPhoto!),
          ),
        ],
      ),
    );
  }
}