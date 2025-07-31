import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app1/onboarding/bloC/onboardingcubit.dart';

class AnimatedTrack extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 8.h,
      width: double.infinity.w,
      decoration: BoxDecoration(
        color: Colors.grey[400], // Light track background
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Stack(
        children: [
          BlocBuilder<OnboardingCubit, int>(
            builder: (context, state) {
              return AnimatedAlign(
                alignment: state == 0
                    ? Alignment.centerLeft
                    : state == 1
                    ? Alignment.center
                    : Alignment.centerRight,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                child: Container(
                  height: 8.h,
                  width:
                      112.w, // Width of the sliding blue segment (adjustable)
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
