import 'package:flutter/material.dart';
import 'package:ovia_app/features/home/splash_router.dart';
import 'package:ovia_app/screens/home_screen.dart';
import 'package:ovia_app/screens/partner_screen.dart';
import 'package:ovia_app/screens/pregnancy_feed_screen.dart';
import 'package:ovia_app/screens/pregnancy_home_screen.dart';

class EntryPoint extends StatefulWidget{
  const EntryPoint({super.key});

  @override
  State<EntryPoint> createState() => _EntryPointState();
}

class _EntryPointState extends State<EntryPoint>{
  _EntryPointState();

  int _selectedIndex = 0;

  final List<Widget> screens = [
    const SplashRouter(),
    const PregnancyHomeScreen(),
    const PregnancyFeedScreen(),
    const PartnerScreen(),
  ];

  void onTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      extendBody: true,
      body: Stack(
        children:[
          screens[_selectedIndex],
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              color: Colors.transparent,
              padding: const EdgeInsets.only(bottom: 20),
              child: Container(
                width: MediaQuery.of(context).size.width - 110,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.35),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ...List.generate(
                      buttonNavs.length, 
                      (index) => GestureDetector(
                        onTap: () => onTap(index),
                        child: Container(
                          width: 60,
                          height: 60,
                          margin: const EdgeInsets.symmetric(horizontal: 1),
                          decoration: BoxDecoration(
                            color: index == _selectedIndex ? Colors.black : Colors.white,
                            borderRadius: BorderRadius.circular(40),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black,
                                blurRadius: 30,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          padding: const EdgeInsets.all(20),
                          child: Image.asset(
                            buttonNavs[index], 
                            color: index == _selectedIndex ? Colors.white : Colors.black,
                          ),
                        ),
                      )
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }  
}

List<String> buttonNavs = [
  'assets/icons/calendar.png',
  'assets/icons/app.png',
  'assets/icons/notification.png',
  'assets/icons/friends.png',
];