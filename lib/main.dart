import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app1/onboarding/ui/screen/onboardingscreen.dart';
import 'package:todo_app1/onboarding/bloC/onboardingcubit.dart'; 


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return BlocProvider(
          create: (_) => OnboardingCubit(),
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            home:  Onboardingscreen(),
          ),
        );
      },
    );
  }
}
