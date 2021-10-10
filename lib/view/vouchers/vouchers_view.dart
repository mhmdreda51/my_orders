// ignore_for_file: implementation_imports

import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:my_orders/constants/app_colors.dart';

import 'component/active_tab_view.dart';
import 'component/expired_tab_view.dart';
import 'component/used_tab_view.dart';

class VouchersView extends StatefulWidget {
  const VouchersView({Key? key}) : super(key: key);

  @override
  _VouchersViewState createState() => _VouchersViewState();
}

class _VouchersViewState extends State<VouchersView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text("vouchers.appBar_title".tr())),
        body: DefaultTabController(
          length: 3,
          child: Column(
            children: <Widget>[
              ButtonsTabBar(
                radius: 0.0,
                duration: 0,
                borderWidth: 1.0,
                backgroundColor: Colors.white,
                borderColor: AppColors.redColor,
                unselectedBackgroundColor: Colors.white,
                physics: const BouncingScrollPhysics(),
                unselectedLabelStyle: const TextStyle(color: Colors.black),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 24.0),
                labelStyle: const TextStyle(
                    color: AppColors.redColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0),
                tabs: [
                  Tab(text: "vouchers.active".tr()),
                  Tab(text: "vouchers.used".tr()),
                  Tab(text: "vouchers.expired".tr()),
                ],
              ),
              const Expanded(
                child: TabBarView(
                  children: <Widget>[
                    ActiveTabView(),
                    UsedTabView(),
                    ExpiredTabView(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
