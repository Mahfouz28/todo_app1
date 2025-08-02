import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:todo_app1/auth/login/model/usermodel.dart';
import 'package:todo_app1/auth/login/repo/login_repo.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this.loginRepo) : super(LoginInitial());
  final formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final LoginRepo loginRepo;

  bool obscure = true;
  Future<void> login() async {
    if (formKey.currentState?.validate() != true) {
      emit(LoginError("Please check your input."));
      return;
    }
    emit(LoginLoading());
    try {
      final userModel = loginRepo.logIn(
        emailController.text.trim(),
        passwordController.text.trim(),
      );
      emit(LoginSuccess(await userModel));
    } catch (e) {
      emit(LoginError("An error occurred during sign up: $e"));
    }
  }

  void togglePasswordVisibility() {
    obscure = !obscure;
    emit(LoginTogglePassword(obscure));
  }
}
