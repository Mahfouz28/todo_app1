import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app1/auth/login/ui/screen/login_screen.dart';
import 'package:todo_app1/onboarding/bloC/onboardingcubit.dart';

/// A bottom section of the onboarding screen that includes:
/// - An animated page indicator
/// - Title text based on the current onboarding page
/// - A button to navigate to the next page or complete onboarding
class OnboardingBottom extends StatelessWidget {
  final PageController pageController;

  const OnboardingBottom({super.key, required this.pageController});

  @override
  Widget build(BuildContext context) {
    // Access the OnboardingCubit from the widget tree
    final cubit = context.read<OnboardingCubit>();

    return Container(
      height: 398.h,
      width: 390.w,
      padding: EdgeInsets.all(14.0.r),
      decoration: BoxDecoration(
        color: Color(0xFFF9F9F9), // Light gray background with transparency

        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
      ),

      // BlocBuilder listens to changes in the OnboardingCubit (which is just an int: page index)
      child: BlocBuilder<OnboardingCubit, int>(
        builder: (context, state) {
          // List of onboarding messages, one for each page
          final pageTexts = [
            'Manage your\n notes easily',
            'Organize your \n thougts',
            'Create cards and\n easy styling',
          ];
          // List of onboarding SupText one for each page

          final supText = [
            "A completely easy way to manage and customize\n your notes.",
            "Most beautiful note taking application.",
            "Making your content legible has never been\n easier.",
          ];

          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Animated progress bar changes alignment depending on the current page
              // Outer background track with inner animated bar
              // Container(
              //   height: 8.h,
              //   width: double.infinity.w,
              //   decoration: BoxDecoration(
              //     color: Colors.grey[400], // Light track background
              //     borderRadius: BorderRadius.circular(10.r),
              //   ),
              //   child: Stack(
              //     children: [
              //       AnimatedAlign(
              //         alignment: state == 0
              //             ? Alignment.centerLeft
              //             : state == 1
              //             ? Alignment.center
              //             : Alignment.centerRight,
              //         duration: const Duration(milliseconds: 300),
              //         curve: Curves.easeInOut,
              //         child: Container(
              //           height: 8.h,
              //           width: 112
              //               .w, // Width of the sliding blue segment (adjustable)
              //           decoration: BoxDecoration(
              //             color: Colors.blue,
              //             borderRadius: BorderRadius.circular(10.r),
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              // Display the title/message based on the current page
              Text(
                pageTexts[state],
                style: TextStyle(
                  fontSize: 32.sp,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF1C2121),
                ),
                textAlign: TextAlign.center,
              ),

              // Display the SupText/message based on the current page
              Text(
                supText[state],
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF1C2121),
                ),
                textAlign: TextAlign.center,
              ),

              // Next or Get Started button depending on the current page
              ElevatedButton(
                onPressed: () {
                  if (state < 2) {
                    // Move to the next onboarding page
                    pageController.animateToPage(
                      state + 1,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeIn,
                    );
                    cubit.ChangePage(state + 1); // Update state in Cubit
                  } else {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                      (route) => false,
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  minimumSize: Size(340.w, 56.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: Text(
                  // Change button text on last page
                  state < 2 ? 'Next' : 'Get Started',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
