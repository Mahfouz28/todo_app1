import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app1/auth/login/ui/widgets/text_field_auth.dart';
import 'package:todo_app1/auth/signup/ui/screen/signup_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              233.verticalSpace,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 48),
                child: Text(
                  "Welcome Back",
                  style: TextStyle(
                    fontSize: 30.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              35.verticalSpace,

              TextFieldAuth(
                hintText: "your.email@example.com",
                suffixIcon: Icons.mail_outline,
                fieldName: 'Email Address',
              ),
              15.verticalSpace,

              TextFieldAuth(
                hintText: "Enter your password",
                suffixIcon: Icons.lock_outline,
                fieldName: 'Password',
              ),
              40.verticalSpace,

              ElevatedButton(
                onPressed: () {},

                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  minimumSize: Size(340.w, 56.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: Text(
                  'Log in',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              15.verticalSpace,

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account?"),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => SignupScreen()),
                      );
                    },
                    child: Text(
                      "Register",
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
