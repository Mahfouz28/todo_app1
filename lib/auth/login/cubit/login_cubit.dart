import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app1/auth/login/model/usermodel.dart';
import 'package:todo_app1/auth/login/repo/login_repo.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this.loginRepo) : super(LoginInitial());

  final LoginRepo loginRepo;
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool obscure = true;

  Future<void> login() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    if (formKey.currentState?.validate() != true) {
      emit(LoginError("Please check your input."));
      return;
    }

    emit(LoginLoading());
    try {
      final userModel = await loginRepo.logIn(
        emailController.text.trim(),
        passwordController.text.trim(),
      );

      pref.setString("username", userModel.username.toString());
      pref.setString("id", userModel.id.toString());
      pref.setString("email", userModel.email.toString());
      emit(LoginSuccess(userModel));
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('is_logged_in', true);
    } catch (e) {
      emit(LoginError("An error occurred during login: $e"));
    }
  }

  void togglePasswordVisibility() {
    obscure = !obscure;
    emit(LoginTogglePassword(obscure));
  }

  
}
