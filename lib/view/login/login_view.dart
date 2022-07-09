// ignore_for_file: implementation_imports

import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../core/router/router.dart';
import '../../widgets/email_text_field.dart';
import '../../widgets/loading_widget.dart';
import '../../widgets/main_button.dart';
import '../../widgets/password_text_field.dart';
import '../home/home_view.dart';
import 'components/text_button_row.dart';
import 'controller/login_cubit.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(title: Text("login.appBar_title".tr())),
        body: BlocProvider(
          create: (context) => LoginCubit(),
          child: BlocConsumer<LoginCubit, LoginState>(
            listener: (context, state) {
              if (state is LoginSuccessState) {
                if (state.userModel.tokenType == 'bearer') {
                  Fluttertoast.showToast(msg: "login.success".tr());
                  MagicRouter.navigateAndPopAll(const HomeView());
                } else if (state.userModel.status == 0 ||
                    state.userModel.status != null) {
                  Fluttertoast.showToast(msg: "login.failed".tr());
                }
              }
            },
            builder: (context, state) {
              final cubit = LoginCubit.get(context);
              return Form(
                key: cubit.formKey,
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  children: <Widget>[
                    const LogoImage(),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: AutoSizeText("login.continue_with_email".tr(),
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 24.0)),
                    ),
                    EmailTextField(
                        hintText: "login.email".tr(),
                        controller: cubit.emailController,
                        onFieldSubmitted: (value) {
                          if (cubit.formKey.currentState!.validate()) {}
                        }),
                    const SizedBox(height: 12.0),
                    PasswordTextField(
                        hintText: "login.password".tr(),
                        controller: cubit.passwordController,
                        onFieldSubmitted: (value) {
                          if (cubit.formKey.currentState!.validate()) {}
                        },
                        obscureText: cubit.isPassword,
                        onPressed: () => cubit.changePasswordVisibility(),
                        icon: cubit.suffix),
                    const TextButtonRow(),
                    const SizedBox(height: 32.0),
                    state is LoginLoadingState
                        ? const LoadingWidget()
                        : MainButton(
                            text: "login.login".tr(),
                            onPressed: () async {
                              if (cubit.formKey.currentState!.validate()) {
                                cubit.userLogin(
                                    email: cubit.emailController.text
                                        .toLowerCase()
                                        .trim(),
                                    password: cubit.passwordController.text
                                        .toLowerCase()
                                        .trim());
                              }
                            },
                          ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class LogoImage extends StatelessWidget {
  const LogoImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Image.asset('assets/images/my_order_driver_app_icon.png',
          fit: BoxFit.cover, height: 120.0),
    );
  }
}
