import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {

  int _selectedIndex = 0;
  final List<Widget> tabs = [
    const Center(child: Text('Track Cycle'),),
    const Center(child: Text('Get Pregnant'),),
    const Center(child: Text('Track Pregnancy'),),
  ];
  final List<String> buttonTabs = [
    'Track Cycle',
    'Get Pregnant',
    'Track Pregnancy',
  ];

  void onTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Text(
                'Account',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 16,),
              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                  color: Colors.white,
                ),
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const CircleAvatar(
                      radius: 18,
                      backgroundImage: AssetImage("assets/images/face.webp"),
                    ),
                    const SizedBox(width: 10,),
                    const Column(
                      children: [
                        Text(
                          'Emily Johnson',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'emilyjohnson@gmail.com',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w200,
                          ),
                        )
                      ],
                    ),
                    OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                    ),
                    onPressed: (){}, 
                    child: const Text('Edit Profile'),
                  ),
                  ],
                ),
              ),
              const SizedBox(height: 16,),
              const Text(
                'My goal',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 16,),
               Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: const EdgeInsets.symmetric(vertical: 3),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ...List.generate(
                      buttonTabs.length, 
                      (index) => GestureDetector(
                        onTap: () => onTap(index),
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          decoration: BoxDecoration(
                            color: index == _selectedIndex ? Colors.black : Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 6.5, vertical: 7),
                          child: Text(
                            buttonTabs[index], 
                            style: TextStyle(color: index == _selectedIndex ? Colors.white : Colors.black, fontSize: 13),
                          ),
                        ),
                      )
                    )
                  ],
                ),
              ),
              const SizedBox(height: 16),
              tabs[_selectedIndex],
            ],
          ),
        ),
      ),
    );
  }
}