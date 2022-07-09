// ignore_for_file: implementation_imports

import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../constants/app_colors.dart';
import '../../core/router/router.dart';
import '../../widgets/confirm_password_text_field.dart';
import '../../widgets/email_text_field.dart';
import '../../widgets/first_name_text_field.dart';
import '../../widgets/last_name_text_field.dart';
import '../../widgets/loading_widget.dart';
import '../../widgets/main_button.dart';
import '../../widgets/password_text_field.dart';
import '../../widgets/phone_text_field.dart';
import '../home/home_view.dart';
import 'Controller/register_cubit.dart';
import 'Controller/register_state.dart';
import 'components/area_of_city_drop_down_button.dart';
import 'components/city_drop_down_button.dart';
import 'components/shimmer_drop_down_button.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text("register.appBar_title".tr())),
        body: BlocProvider(
          create: (context) => RegisterCubit()..getCity(),
          child: BlocConsumer<RegisterCubit, RegisterState>(
            listener: (context, state) {
              if (state is RegisterSuccessState) {
                if (state.userModel.tokenType == 'bearer') {
                  Fluttertoast.showToast(msg: "register.success".tr());
                  MagicRouter.navigateAndPopAll(const HomeView());
                } else if (state.userModel.errors!.email != null) {
                  Fluttertoast.showToast(
                      msg: state.userModel.errors!.email!.join());
                } else if (state.userModel.errors!.phone != null) {
                  Fluttertoast.showToast(
                      msg: state.userModel.errors!.phone!.join());
                }
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
                    Row(
                      children: <Widget>[
                        Expanded(
                            flex: 1,
                            child: FirstNameTextField(
                              hintText: "register.first_name".tr(),
                              controller: cubit.firstNameController,
                              onFieldSubmitted: (value) {
                                if (cubit.formKey.currentState!.validate()) {}
                              },
                            )),
                        const SizedBox(width: 12),
                        Expanded(
                          flex: 1,
                          child: LastNameTextField(
                            hintText: "register.last_name".tr(),
                            controller: cubit.lastNameController,
                            onFieldSubmitted: (value) {
                              if (cubit.formKey.currentState!.validate()) {}
                            },
                          ),
                        ),
                      ],
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
                    ConfirmPasswordTextField(
                        hintText: "register.confirm_password".tr(),
                        controller: cubit.confirmPasswordController,
                        onFieldSubmitted: (value) {
                          if (cubit.formKey.currentState!.validate()) {}
                        },
                        obscureText: cubit.isPasswordConfirm,
                        onPressed: () =>
                            cubit.changeConfirmPasswordVisibility(),
                        icon: cubit.suffixConfirm),
                    const SizedBox(height: 12.0),
                    cubit.cityModel == null
                        ? const ShimmerDropDownButton()
                        : CityDropDownButton(
                            itemsList: cubit.cityModel!.data!,
                            value: cubit.cityDropDownValue,
                            onChanged: (value) {
                              cubit.changeCityDropDown(value: value);
                              debugPrint(value);
                              cubit.areaOfCityDropDownValue = null;
                              cubit.getAreaOfCityById(
                                  areaId: int.parse(value!));
                            }),
                    const SizedBox(height: 12.0),
                    cubit.cityDropDownValue == null
                        ? const SizedBox()
                        : state is GetAreaOfCityLoading
                            ? const ShimmerDropDownButton()
                            : AreaOfCityDropDownButton(
                                itemsList: cubit.areaOfCityModel!.data!,
                                value: cubit.areaOfCityDropDownValue,
                                onChanged: (value) {
                                  cubit.changeAreaOfCityDropDown(value: value);
                                },
                              ),
                    const SizedBox(height: 12.0),
                    Row(
                      children: <Widget>[
                        Checkbox(
                            value: cubit.isChecked,
                            activeColor: AppColors.redColor,
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            onChanged: (value) => cubit.changeCheckBox(value!)),
                        Expanded(
                          child: Text("register.checkbox_text".tr(),
                              maxLines: 2,
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontSize: 16.0)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24.0),
                    state is RegisterLoadingState
                        ? const LoadingWidget()
                        : MainButton(
                            text: "login.create_account".tr(),
                            onPressed: () {
                              if (cubit.cityDropDownValue == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                            "register.please_choose_city"
                                                .tr())));
                              }
                              if (cubit.areaOfCityDropDownValue == null &&
                                  cubit.areaOfCityModel != null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                            "register.please_choose_area"
                                                .tr())));
                              }
                              if (cubit.passwordController.value.text !=
                                  cubit.confirmPasswordController.value.text) {
                                Fluttertoast.showToast(
                                    msg: "register.password_match".tr());
                              }
                              if (cubit.formKey.currentState!.validate()) {
                                cubit.areaOfCityDropDownValue == null
                                    ? () {}
                                    : cubit.userSignUp(
                                        firstName:
                                            cubit.firstNameController.text,
                                        lastName: cubit.lastNameController.text,
                                        phone: cubit.phoneController.text,
                                        email: cubit.emailController.text
                                            .toLowerCase()
                                            .trim(),
                                        password: cubit.passwordController.text
                                            .toLowerCase()
                                            .trim(),
                                        passwordConfirm: cubit
                                            .confirmPasswordController.text
                                            .toLowerCase()
                                            .trim(),
                                        registerAreaId: int.parse(
                                            cubit.areaOfCityDropDownValue!));
                              }
                            },
                          ),
                    const SizedBox(height: 24.0),
                    Text("register.terms".tr(),
                        maxLines: 5,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 14.0)),
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
