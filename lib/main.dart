import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app1/auth/login/cubit/login_cubit.dart';
import 'package:todo_app1/auth/signup/cubit/cubit/sign_up_cubit.dart';
import 'package:todo_app1/homeScreen/bloC/cubit/home_screen_cubit.dart';
import 'package:todo_app1/auth/signup/repo/signin_repo.dart';
import 'package:todo_app1/auth/login/repo/login_repo.dart';
import 'package:todo_app1/homeScreen/ui/screen/home_screen.dart';
import 'package:todo_app1/onboarding/bloC/onboardingcubit.dart';
import 'package:todo_app1/onboarding/ui/screen/onboardingscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final initialScreen = await getInitialScreen();

  runApp(MyApp(startScreen: initialScreen));
}

class MyApp extends StatelessWidget {
  final Widget startScreen;

  const MyApp({super.key, required this.startScreen});

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
            BlocProvider(create: (_) => HomeScreenCubit()),
            BlocProvider(create: (_) => SignUpCubit(SigninRepo())),
            BlocProvider(create: (_) => LoginCubit(LoginRepo())),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            home: startScreen,
          ),
        );
      },
    );
  }
}

Future<Widget> getInitialScreen() async {
  final prefs = await SharedPreferences.getInstance();
  final isLoggedIn = prefs.getBool('is_logged_in') ?? false;

  if (isLoggedIn) {
    return HomeScreen();
  } else {
    return Onboardingscreen();
  }
}
