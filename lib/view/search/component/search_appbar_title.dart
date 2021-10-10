// ignore_for_file: implementation_imports

import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_orders/constants/app_colors.dart';

class SearchAppBarTitle extends StatelessWidget {
  const SearchAppBarTitle({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(end: 16.0),
      child: TextField(
        keyboardType: TextInputType.text,
        controller: controller,
        decoration: InputDecoration(
          suffixIconConstraints: const BoxConstraints(),
          hintText: "search.search_bar".tr(),
          suffixIcon: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.0),
            child: FaIcon(
              FontAwesomeIcons.filter,
              color: AppColors.redColor,
              size: 16.0,
            ),
          ),
        ),
      ),
    );
  }
}
