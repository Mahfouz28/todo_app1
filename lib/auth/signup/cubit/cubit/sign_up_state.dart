part of 'sign_up_cubit.dart';

sealed class SignUpState extends Equatable {
  const SignUpState();

  @override
  List<Object> get props => [];
}

final class SignUpInitial extends SignUpState {}

final class SignUpLoading extends SignUpState {}

final class SignUpSuccess extends SignUpState {
  final UserData userModel;
  const SignUpSuccess(this.userModel);
}

class SignUpError extends SignUpState {
  final String message;
  SignUpError(this.message);
}
