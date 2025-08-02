import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:todo_app1/auth/signup/model/user_data.dart';
import 'package:todo_app1/auth/signup/repo/signin_repo.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit(this.signinRepo) : super(SignUpInitial());

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool obscure = true;

  final formKey = GlobalKey<FormState>();
  final SigninRepo signinRepo;
  Future<void> signUp() async {
    if (formKey.currentState?.validate() != true) {
      emit(SignUpError("Please check your input."));
      return;
    }

    emit(SignUpLoading());

    try {
      final userModel = await signinRepo.signin(
        nameController.text.trim(),
        emailController.text.trim(),
        passwordController.text.trim(),
      );

      emit(SignUpSuccess(userModel));
    } catch (e) {
      emit(SignUpError("An error occurred during sign up: $e"));
    }
  }

  void togglePasswordVisibility() {
    obscure = !obscure;
    emit(SignUpTogglePassword(obscure));
  }
}
