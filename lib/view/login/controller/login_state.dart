part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}
//===============================================================

class LoginChangePasswordVisibilityState extends LoginState {}
//===============================================================

class LoginLoadingState extends LoginState {}

class LoginSuccessState extends LoginState {
  late final Users users;

  LoginSuccessState({required this.users});
}

class LoginLErrorState extends LoginState {
  final String error;

  LoginLErrorState({required this.error});
}

class GetUserDataLoadingState extends LoginState {}

class GetUserDataSuccessState extends LoginState {}
//===============================================================
