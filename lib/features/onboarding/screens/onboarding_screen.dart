import 'package:flutter/material.dart';
import 'package:ovia_app/features/onboarding/widgets/onboarding_page.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int currentPage = 0;

  final List<Map<String, String>> onboardingData = [
    {
      "title": "Here's what to expect in your first trimester",
      "subtitle": "",
      "buttonText": "Get started",
      "image": "assets/images/onboarding/cramps1.png",
    },
    {
      "title": "Expect in your first trimester",
      "subtitle": "You may feel nauseous and more tired than usual.",
      "buttonText": "Continue to symptoms",
      "image": "assets/images/onboarding/pregnant1.png",
    },
    {
      "title": "",
      "subtitle": "Meet some of the millions of people who used MyFlow to support them on their paths to parenthood.",
      "buttonText": "Next",
      "image": "assets/images/onboarding/mother_holding_child4.jpg",
    },
  ];

  void nextPage() {
    if (currentPage < onboardingData.length - 1){
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300), 
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  @override
  void dispose(){
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: onboardingData.length,
            onPageChanged: (index) {
              setState(() {
                currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              return OnboardingPage(
                title: onboardingData[index]['title']!,
                subtitle: onboardingData[index]['subtitle']!,
                buttonText: onboardingData[index]['buttonText']!,
                image: onboardingData[index]['image']!,
                onButtonPressed: nextPage,
                indicator: SmoothPageIndicator(
                    controller: _pageController,
                    count: onboardingData.length,
                    effect: const ExpandingDotsEffect(
                      activeDotColor: Colors.black,
                      dotHeight: 8,
                      dotWidth: 8,
                      spacing: 12,
                      expansionFactor: 4,
                    ),
                  ),
              );
            },  
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('OVIA', style: Theme.of(context).textTheme.headlineMedium),
                currentPage < onboardingData.length - 1
                  ? TextButton(
                      onPressed: () {
                        _pageController.jumpToPage(onboardingData.length - 1);
                      },
                      child: const Text('Skip', style: TextStyle(color: Colors.black45),),
                    )
                  : const SizedBox.shrink(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}