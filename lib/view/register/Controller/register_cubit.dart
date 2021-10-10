import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_orders/constants/token.dart';
import 'package:my_orders/core/cacheHelper/cache_helper.dart';
import 'package:my_orders/view/login/Models/users_model.dart';

import '../../../core/dioHelper/dio_helper.dart';
import 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  static RegisterCubit get(context) => BlocProvider.of(context);

//===============================================================
  Users? users;
  List<Users> usersList = [];

  bool isPassword = true;
  bool? isChecked = false;
  IconData suffix = Icons.visibility_outlined;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmationController =
      TextEditingController();

//===============================================================
  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(RegisterChangePasswordVisibilityState());
  }

//===============================================================
  void changeCheckBox(bool? value) {
    isChecked = value;
    emit(RegisterChangeCheckBoxState());
  }

//===============================================================
  userSignUp({
    required String firstName,
    required String lastName,
    required String phone,
    required String email,
    required String password,
    required String passwordConfirmation,
  }) async {
    emit(RegisterLoadingState());
    final response = await DioHelper.postData(
      url: 'client/auth/signUp',
      data: {
        'first_name': firstName,
        'last_name': lastName,
        'email': email,
        'phone': phone,
        'password': password,
        'password_confirmation': passwordConfirmation,
        "area_id": "2",
      },
    );
    try {
      users = Users.fromJson(response.data);
      if (users!.accessToken != null || users!.accessToken != "") {
        accessToken = users!.accessToken.toString();
        CacheHelper.saveData(
            key: 'accessToken', value: users!.accessToken.toString());
        emit(RegisterSuccessState(users: users!));
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      emit(RegisterLErrorState(error: e.toString()));
    }
  }
}
