import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_orders/constants/token.dart';
import 'package:my_orders/core/cacheHelper/cache_helper.dart';
import 'package:my_orders/view/login/Models/users_model.dart';

import '../../../core/dioHelper/dio_helper.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  static LoginCubit get(context) => BlocProvider.of(context);

//===============================================================
  Users? users;
  List<Users> usersList = [];
  bool isPassword = true;
  IconData suffix = Icons.visibility_outlined;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

//===============================================================
  Future<void> userLogin({
    required String email,
    required String password,
  }) async {
    emit(LoginLoadingState());
    final response = await DioHelper.postData(url: 'client/auth/login', data: {
      'email': email,
      'password': password,
    });
    try {
      users = Users.fromJson(response.data);
      if (users!.accessToken != null || users!.accessToken != "") {
        accessToken = users!.accessToken.toString();
        CacheHelper.saveData(
            key: 'accessToken', value: users!.accessToken.toString());
        emit(LoginSuccessState(users: users!));
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      emit(LoginLErrorState(error: e.toString()));
    }
  }

//===============================================================
  Future<void> getData() async {
    emit(GetUserDataLoadingState());
    final userResponse = await DioHelper.getData(url: 'client/auth/login');
    try {
      usersList = (userResponse.data as List<dynamic>)
          .map((value) => Users.fromJson(value))
          .toList();
      emit(GetUserDataSuccessState());
    } catch (error) {
      Fluttertoast.showToast(msg: error.toString());
    }
  }

  //===============================================================

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(LoginChangePasswordVisibilityState());
  }
}
