import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app1/onboarding/bloC/onboardingcubit.dart';
import 'package:todo_app1/onboarding/ui/widgets/animated_track.dart';
import 'package:todo_app1/onboarding/ui/widgets/onboarding_bottom.dart';
import 'package:todo_app1/onboarding/ui/widgets/onboardingheader.dart';
import 'package:todo_app1/onboarding/ui/widgets/onboardingimage.dart';

class Onboardingscreen extends StatelessWidget {
  Onboardingscreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<OnboardingCubit>();
    final controller = cubit.controller;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Onboardingheader(),

            Expanded(
              child: PageView(
                controller: controller,
                onPageChanged: (index) {
                  cubit.ChangePage(index);
                },
                children: const [
                  Onboardingimage(imagePath: 'assets/images/onBoarding1.png'),
                  Onboardingimage(imagePath: 'assets/images/onBoarding2.png'),
                  Onboardingimage(imagePath: 'assets/images/onBoarding3.png'),
                ],
              ),
            ),

            Stack(
              children: [
                OnboardingBottom(pageController: controller),
                Padding(
                  padding: EdgeInsets.all(24.0.r),
                  child: Positioned(child: AnimatedTrack()),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
