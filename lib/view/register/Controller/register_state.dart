import 'package:my_orders/view/login/Models/users_model.dart';

abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

//===============================================================
class RegisterChangePasswordVisibilityState extends RegisterState {}

//===============================================================
class RegisterChangeCheckBoxState extends RegisterState {}
//===============================================================

class RegisterLoadingState extends RegisterState {}

class RegisterSuccessState extends RegisterState {
  late final Users users;

  RegisterSuccessState({required this.users});
}

class RegisterLErrorState extends RegisterState {
  final String error;

  RegisterLErrorState({required this.error});
}
