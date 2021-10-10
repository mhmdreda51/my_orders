// ignore_for_file: implementation_imports

import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:my_orders/constants/app_colors.dart';
import 'package:my_orders/core/router/router.dart';
import 'package:my_orders/view/home/home_view.dart';
import 'package:my_orders/widgets/email_text_field.dart';
import 'package:my_orders/widgets/main_button.dart';
import 'package:my_orders/widgets/name_text_field.dart';
import 'package:my_orders/widgets/password_text_field.dart';
import 'package:my_orders/widgets/phone_text_field.dart';

import 'Controller/register_cubit.dart';
import 'Controller/register_state.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text("register.appBar_title".tr())),
        body: BlocProvider(
          create: (context) => RegisterCubit(),
          child: BlocConsumer<RegisterCubit, RegisterState>(
            listener: (context, state) {
              if (state is RegisterSuccessState) {
                MagicRouter.navigateAndPopAll(const HomeView());
              }
            },
            builder: (context, state) {
              final cubit = RegisterCubit.get(context);
              return Form(
                key: cubit.formKey,
                child: ListView(
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: AutoSizeText("login.continue_with_email".tr(),
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 24.0)),
                    ),
                    NameTextField(
                      hintText: "register.first_name".tr(),
                      controller: cubit.firstNameController,
                      onFieldSubmitted: (value) {
                        if (cubit.formKey.currentState!.validate()) {}
                      },
                    ),
                    const SizedBox(height: 12.0),
                    NameTextField(
                      hintText: "register.last_name".tr(),
                      controller: cubit.lastNameController,
                      onFieldSubmitted: (value) {
                        if (cubit.formKey.currentState!.validate()) {}
                      },
                    ),
                    const SizedBox(height: 12.0),
                    EmailTextField(
                      hintText: "register.email".tr(),
                      controller: cubit.emailController,
                      onFieldSubmitted: (value) {
                        if (cubit.formKey.currentState!.validate()) {}
                      },
                    ),
                    const SizedBox(height: 12.0),
                    PhoneTextField(
                        hintText: "register.phone".tr(),
                        controller: cubit.phoneController,
                        onFieldSubmitted: (value) {
                          if (cubit.formKey.currentState!.validate()) {}
                        }),
                    const SizedBox(height: 12.0),
                    PasswordTextField(
                        hintText: "register.password".tr(),
                        controller: cubit.passwordController,
                        onFieldSubmitted: (value) {
                          if (cubit.formKey.currentState!.validate()) {}
                        },
                        obscureText: cubit.isPassword,
                        onPressed: () => cubit.changePasswordVisibility(),
                        icon: cubit.suffix),
                    const SizedBox(height: 12.0),
                    PasswordTextField(
                        hintText: "register.password_confirmation".tr(),
                        controller: cubit.passwordConfirmationController,
                        onFieldSubmitted: (value) {
                          if (cubit.formKey.currentState!.validate()) {}
                        },
                        obscureText: cubit.isPassword,
                        onPressed: () => cubit.changePasswordVisibility(),
                        icon: cubit.suffix),
                    const SizedBox(height: 12.0),
                    Row(
                      children: <Widget>[
                        Checkbox(
                            value: cubit.isChecked,
                            activeColor: AppColors.redColor,
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            onChanged: (value) => cubit.changeCheckBox(value)),
                        Expanded(
                          flex: 1,
                          child: Text("register.checkbox_text".tr(),
                              maxLines: 2,
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontSize: 16.0)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24.0),
                    Conditional.single(
                      context: context,
                      conditionBuilder: (context) =>
                          state is RegisterLoadingState,
                      widgetBuilder: (context) => const SizedBox(
                        height: 48.0,
                        width: double.infinity,
                        child: Center(
                            child: CupertinoActivityIndicator(
                                radius: 16.0, animating: true)),
                      ),
                      fallbackBuilder: (context) => MainButton(
                        text: "login.create_account".tr(),
                        onPressed: () async {
                          if (cubit.formKey.currentState!.validate()) {
                            cubit.userSignUp(
                              email: cubit.emailController.text,
                              firstName: cubit.firstNameController.text,
                              lastName: cubit.lastNameController.text,
                              password: cubit.passwordController.text,
                              passwordConfirmation:
                                  cubit.passwordConfirmationController.text,
                              phone: cubit.phoneController.text,
                            );
                          }
                        },
                      ),
                    ),
                    const SizedBox(height: 24.0),
                    Text("register.terms".tr(),
                        maxLines: 5,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 14.0))
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
