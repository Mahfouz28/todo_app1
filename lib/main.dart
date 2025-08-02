import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app1/auth/login/cubit/login_cubit.dart';
import 'package:todo_app1/auth/signup/cubit/cubit/sign_up_cubit.dart';
import 'package:todo_app1/homeScreen/bloC/cubit/home_screen_cubit.dart';
import 'package:todo_app1/onboarding/ui/screen/onboardingscreen.dart';
import 'package:todo_app1/auth/signup/repo/signin_repo.dart';
import 'package:todo_app1/auth/login/repo/login_repo.dart';
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
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => OnboardingCubit()),
            BlocProvider(create: (context) => HomeScreenCubit()),
            BlocProvider(create: (_) => SignUpCubit(SigninRepo())),
            BlocProvider(create: (_) => LoginCubit(LoginRepo())),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Onboardingscreen(),
          ),
        );
      },
    );
  }
}
