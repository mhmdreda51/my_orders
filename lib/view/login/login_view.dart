// ignore_for_file: implementation_imports

import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:my_orders/core/router/router.dart';
import 'package:my_orders/view/home/home_view.dart';
import 'package:my_orders/widgets/email_text_field.dart';
import 'package:my_orders/widgets/main_button.dart';
import 'package:my_orders/widgets/password_text_field.dart';

import 'components/text_button_row.dart';
import 'controller/login_cubit.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text("login.appBar_title".tr())),
        body: BlocProvider(
          create: (context) => LoginCubit(),
          child: BlocConsumer<LoginCubit, LoginState>(
            listener: (context, state) {
              if (state is LoginSuccessState) {
                MagicRouter.navigateAndPopAll(const HomeView());
              } else if (state is LoginLoadingState) {}
            },
            builder: (context, state) {
              final cubit = LoginCubit.get(context);
              return Form(
                key: cubit.formKey,
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  children: <Widget>[
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
                    Conditional.single(
                      context: context,
                      conditionBuilder: (context) => state is LoginLoadingState,
                      widgetBuilder: (context) => const SizedBox(
                        height: 48.0,
                        width: double.infinity,
                        child: Center(
                            child: CupertinoActivityIndicator(
                                radius: 16.0, animating: true)),
                      ),
                      fallbackBuilder: (context) => MainButton(
                        text: "login.login".tr(),
                        onPressed: () async {
                          if (cubit.formKey.currentState!.validate()) {
                            await cubit.userLogin(
                                email: cubit.emailController.text,
                                password: cubit.passwordController.text);
                          }
                        },
                      ),
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
