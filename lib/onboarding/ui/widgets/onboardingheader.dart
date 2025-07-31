import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app1/onboarding/bloC/onboardingcubit.dart';

class Onboardingheader extends StatelessWidget {
  Onboardingheader({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<OnboardingCubit>();

    return Row(
      textDirection: TextDirection.rtl,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        BlocBuilder<OnboardingCubit, int>(
          builder: (context, state) {
            return TextButton(
              onPressed: () {
                cubit.skipToLast();
              },
              child: Text(
                'Skip',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.blue,
                ),
              ),
            );
          },
        ),
        BlocBuilder<OnboardingCubit, int>(
          builder: (context, state) {
            return Visibility(
              visible: state > 0,
              child: TextButton.icon(
                onPressed: () {
                  context.read<OnboardingCubit>().PreviousPage();
                },
                icon: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: Colors.blue,
                ),
                label: Text(
                  'Back',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.blue,
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
