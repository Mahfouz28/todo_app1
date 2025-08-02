part of 'login_cubit.dart';

sealed class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

final class LoginInitial extends LoginState {}

final class LoginLoading extends LoginState {}

final class LoginSuccess extends LoginState {
  final UserModel userModel;
  LoginSuccess(this.userModel);
}

class LoginError extends LoginState {
  final String message;
  const LoginError(this.message);
}

class LoginTogglePassword extends LoginState {
  final bool obscure;
  const LoginTogglePassword(this.obscure);

  @override // This override is valid because List<Object?> is a subtype of List<Object>
  List<Object> get props => [obscure];
}
