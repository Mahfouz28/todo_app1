import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app1/auth/login/ui/screen/login_screen.dart';
import 'package:todo_app1/auth/login/ui/widgets/text_field_auth.dart';
import 'package:todo_app1/auth/signup/cubit/cubit/sign_up_cubit.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocListener<SignUpCubit, SignUpState>(
          listener: (context, state) {
            if (state is SignUpSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Account created successfully :${state.userModel.username}',
                  ),
                  backgroundColor: Colors.green,
                  behavior: SnackBarBehavior.floating,
                  duration: const Duration(seconds: 3),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  margin: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                ),
              );

              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const LoginScreen()),
              );
            } else if (state is SignUpError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.red,
                  behavior: SnackBarBehavior.floating,
                  duration: const Duration(seconds: 3),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  margin: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                ),
              );
            }
          },
          child: BlocBuilder<SignUpCubit, SignUpState>(
            builder: (context, state) {
              final cubit = context.read<SignUpCubit>();

              return SingleChildScrollView(
                child: Form(
                  key: cubit.formKey,
                  child: Column(
                    children: [
                      60.verticalSpace,

                      Text(
                        "Create Your Account",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 30.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      20.verticalSpace,

                      Image.asset(
                        "assets/images/Selection.jpg",
                        height: 140,
                        width: 200,
                        fit: BoxFit.cover,
                      ),

                      35.verticalSpace,

                      // Full Name
                      TextFieldAuth(
                        controller: cubit.nameController,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Name cannot be empty';
                          }
                          if (value.trim().length < 3) {
                            return 'Name must be at least 3 characters long';
                          }
                          if (!RegExp(r"^[a-zA-Z\s]+$").hasMatch(value)) {
                            return 'Name can only contain letters and spaces';
                          }
                          return null;
                        },
                        hintText: "John Doe",
                        suffixIcon: Icons.person_outline,
                        fieldName: 'Full Name',
                      ),

                      // Email
                      TextFieldAuth(
                        controller: cubit.emailController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Email cannot be empty';
                          }
                          final emailRegex = RegExp(
                            r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                          );
                          if (!emailRegex.hasMatch(value)) {
                            return 'Enter a valid email address';
                          }
                          return null;
                        },
                        hintText: "example@email.com",
                        suffixIcon: Icons.mail_outline,
                        fieldName: 'Email Address',
                      ),

                      // Password
                      TextFieldAuth(
                        controller: cubit.passwordController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Password cannot be empty';
                          }
                          if (value.length < 8) {
                            return 'Password must be at least 8 characters';
                          }
                          if (!RegExp(r'[A-Z]').hasMatch(value)) {
                            return 'Must include at least one uppercase letter';
                          }
                          if (!RegExp(r'[a-z]').hasMatch(value)) {
                            return 'Must include at least one lowercase letter';
                          }
                          if (!RegExp(r'\d').hasMatch(value)) {
                            return 'Must include at least one number';
                          }
                          if (!RegExp(r'[!@#\$&*~]').hasMatch(value)) {
                            return 'Must include at least one special character (!@#\$&*~)';
                          }
                          return null;
                        },
                        hintText: "Enter your password",
                        suffixIcon: Icons.lock_outline,
                        fieldName: 'Password',
                      ),

                      20.verticalSpace,

                      // Register Button
                      ElevatedButton(
                        onPressed: state is SignUpLoading
                            ? null
                            : () => cubit.signUp(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          minimumSize: Size(340.w, 56.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                        child: state is SignUpLoading
                            ? CircularProgressIndicator(color: Colors.white)
                            : Text(
                                'Register',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                      ),

                      20.verticalSpace,

                      // Go to login
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Already have an account? "),
                          TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const LoginScreen(),
                                ),
                              );
                            },
                            child: const Text(
                              "Log in",
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
