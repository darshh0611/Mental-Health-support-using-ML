import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ipd/authentication/login.dart';
import 'package:ipd/authentication/sign_up.dart';
import 'package:ipd/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';



class OnboardingScreen extends StatefulWidget {
  static const String id = '/onboarding';

  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  double currentPage = 0;

  @override
  void initState() {
    _pageController.addListener(() {
      setState(() {
        currentPage = _pageController.page!;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,

      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            children: [
              // Container(decoration: BoxDecoration(image: DecorationImage(image: AssetImage('assets/Onboarding1.png'))),)
              Container(
                  child:
                  Image.asset('assets/images/onboarding1.png', fit: BoxFit.fill)),
              Container(
                  child:
                  Image.asset('assets/images/onboarding2.png', fit: BoxFit.fill)),
              Container(
                  child:
                  Image.asset('assets/images/onboarding3.png', fit: BoxFit.fill)),
            ],
          ),
          Positioned(
            // alignment: Alignment.center,
            bottom: 60,
            left: MediaQuery.of(context).size.width * 0.5 - 32,
            child: Column(
              children: [
                SmoothPageIndicator(
                  count: 3,
                  controller: _pageController,
                  effect: WormEffect(
                    dotWidth: 16,
                    dotHeight: 4,
                    activeDotColor: AppColors.secondaryblue,
                  ),
                ),
                SizedBox(height: 24),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MaterialButton(
                  height: 42,
                  minWidth: MediaQuery.of(context).size.width * 0.9,
                  color: AppColors.primaryLight,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  onPressed: () {
                    setState(() {
                      currentPage != 2
                          ? _pageController.nextPage(
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.easeIn,
                      )
                          : Navigator.pushReplacement(
                        context,
                        PageRouteBuilder(
                          // pageBuilder: (_, __, ___) => AdminDashBoard(),
                          pageBuilder: (_, __, ___) => SignUpPage(),
                          transitionDuration:
                          const Duration(milliseconds: 300),
                          transitionsBuilder: (_, a, __, c) =>
                              FadeTransition(opacity: a, child: c),
                        ),
                      );
                    });
                  },
                  child: currentPage != 2
                      ? const Text('Next',
                      style: TextStyle(color: AppColors.secondaryblue))
                      : const Text('Get Started',
                      style: TextStyle(color: AppColors.secondaryblue)),
                ),
                SizedBox(height: 24)
              ],
            ),
          ),
        ],
      ),
    );
  }
}