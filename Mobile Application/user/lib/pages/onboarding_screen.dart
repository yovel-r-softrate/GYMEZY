import 'package:flutter/material.dart';
import 'package:user/main.dart';
import '../theme/app_theme.dart';
import 'login_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> onboardingData = [
    {
      "title": "Welcome to GYMEZY",
      "subtitle": "Your premier gym and class booking platform.",
      "image": "assets/pages/onboarding/onboarding 1.jpg",
    },
    {
      "title": "Book Sessions Easily",
      "subtitle": "Find and reserve your favorite gym slots or fitness classes in seconds.",
      "image": "assets/pages/onboarding/onboarding 1.jpg",
    },
    {
      "title": "Manage Your Memberships",
      "subtitle": "Keep track of your bookings, subscriptions, and progress all in one place.",
      "image": "assets/pages/onboarding/onboarding 1.jpg",
    }
  ];

  @override
  Widget build(BuildContext context) {
    final backgroundColor = AppTheme.getBackgroundColor(context);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Stack(
        children: [
          // 1. Top Image spanning the top half of the screen
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: MediaQuery.of(context).size.height * 0.55,
            child: Image.asset(
              'assets/pages/onboarding/onboarding 1.jpg',
              fit: BoxFit.cover,
            ),
          ),

          // 2. Gradient Overlay for smooth fadeout
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: MediaQuery.of(context).size.height * 0.58,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    backgroundColor.withOpacity(0.2),
                    backgroundColor.withOpacity(0.8),
                    backgroundColor,
                  ],
                  stops: const [0.0, 0.5, 0.8, 1.0],
                ),
              ),
            ),
          ),

          // 3. Content overlay (PageView and Buttons)
          SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    onPageChanged: (value) {
                      setState(() {
                        _currentPage = value;
                      });
                    },
                    itemCount: onboardingData.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              onboardingData[index]["title"]!,
                              style: AppTheme.getTitleStyle(context),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              onboardingData[index]["subtitle"]!,
                              textAlign: TextAlign.center,
                              style: AppTheme.getSubtitleStyle(context),
                            ),
                            const SizedBox(height: 40), // Space to sit above the controls
                          ],
                        ),
                      );
                    },
                  ),
                ),
                // Indicators and Navigation Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    onboardingData.length,
                    (index) => buildDot(index: index, context: context),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
                  child: Row(
                    mainAxisAlignment: _currentPage == onboardingData.length - 1
                        ? MainAxisAlignment.center
                        : MainAxisAlignment.spaceBetween,
                    children: [
                      if (_currentPage != onboardingData.length - 1)
                        TextButton(
                          onPressed: () {
                            _pageController.jumpToPage(onboardingData.length - 1);
                          },
                          child: Text(
                            "Skip",
                            style: AppTheme.getSkipButtonStyle(context),
                          ),
                        ),
                      ElevatedButton(
                        onPressed: () {
                          if (_currentPage == onboardingData.length - 1) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginScreen(),
                              ),
                            );
                          } else {
                            _pageController.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.ease,
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.secondaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: EdgeInsets.symmetric(
                              horizontal: _currentPage == onboardingData.length - 1 ? 60 : 30,
                              vertical: 15),
                        ),
                        child: Text(
                          _currentPage == onboardingData.length - 1 ? "Get Started" : "Next",
                          style: AppTheme.buttonTextStyle,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  AnimatedContainer buildDot({required int index, required BuildContext context}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.only(right: 5),
      height: 8,
      width: _currentPage == index ? 24 : 8,
      decoration: BoxDecoration(
        color: AppTheme.getDotColor(context, _currentPage == index),
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}
