// ignore_for_file: implementation_imports

import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../core/cacheHelper/cache_helper.dart';
import '../../../core/router/router.dart';
import '../../about/about_view.dart';
import '../../help/help_view.dart';
import '../../home/controller/home_cubit.dart';
import '../../home/home_view.dart';
import '../../login/login_view.dart';
import '../../notifications/notifications_view.dart';
import '../../orders/orders_view.dart';
import '../../user_details/user_details_view.dart';
import '../../vouchers/vouchers_view.dart';
import '../widget/drawer_item.dart';
import 'drawer_home_item.dart';

class DrawerBody extends StatelessWidget {
  const DrawerBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DrawerHomeItem(
          icon: Icons.home,
          text: "drawer.home".tr(),
          onTap: () {
            MagicRouter.pop();
            MagicRouter.navigateAndPopAll(const HomeView());
          },
        ),
        CacheHelper.isLogged
            ? DrawerItem(
                icon: Icons.person,
                text: "drawer.profile".tr(),
                onTap: () {
                  MagicRouter.pop();
                  MagicRouter.navigateAndPopUntilFirstPage(
                      const UserDetailsView());
                },
              )
            : const SizedBox(),
        CacheHelper.isLogged
            ? DrawerItem(
                icon: FontAwesomeIcons.clipboardList,
                text: "drawer.your_orders".tr(),
                onTap: () {
                  MagicRouter.pop();
                  MagicRouter.navigateAndPopUntilFirstPage(const OrdersView());
                },
              )
            : const SizedBox(),
        // CacheHelper.isLogged
        //     ? DrawerItem(
        //         icon: Icons.local_offer_rounded,
        //         text: "drawer.offers".tr(),
        //         onTap: () {
        //           MagicRouter.pop();
        //
        //           MagicRouter.navigateAndPopUntilFirstPage(OffersView());
        //         },
        //       )
        //     : const SizedBox(),
        CacheHelper.isLogged
            ? DrawerItem(
                icon: Icons.notifications,
                text: "drawer.notifications".tr(),
                onTap: () {
                  MagicRouter.pop();
                  MagicRouter.navigateAndPopUntilFirstPage(
                      const NotificationsView());
                },
              )
            : const SizedBox(),
        CacheHelper.isLogged
            ? DrawerItem(
                icon: FontAwesomeIcons.ticketAlt,
                text: "drawer.vouchers".tr(),
                onTap: () {
                  MagicRouter.pop();
                  MagicRouter.navigateAndPopUntilFirstPage(
                      const VouchersView());
                },
              )
            : const SizedBox(),
        DrawerItem(
          icon: FontAwesomeIcons.bullhorn,
          text: "drawer.get_help".tr(),
          onTap: () {
            MagicRouter.pop();
            MagicRouter.navigateAndPopUntilFirstPage(const HelpView());
          },
        ),
        DrawerItem(
          icon: Icons.info_outline,
          text: "drawer.about_us".tr(),
          onTap: () {
            MagicRouter.pop();
            MagicRouter.navigateAndPopUntilFirstPage(const AboutView());
          },
        ),
        CacheHelper.isLogged
            ? BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  return Row(
                    children: [
                      DrawerItem(
                        icon: Icons.logout,
                        text: "drawer.logout".tr(),
                        onTap: () async {
                          await HomeCubit.get(context).signOut();
                          Fluttertoast.showToast(
                              msg: "drawer.logout_success".tr());
                          MagicRouter.pop();
                          MagicRouter.navigateAndPopAll(const LoginView());
                        },
                      ),
                      state is LogoutLoadingState
                          ? const CupertinoActivityIndicator(animating: true)
                          : const SizedBox(),
                    ],
                  );
                },
              )
            : DrawerItem(
                icon: Icons.login,
                text: "drawer.login".tr(),
                onTap: () {
                  MagicRouter.pop();
                  MagicRouter.navigateAndPopUntilFirstPage(const LoginView());
                },
              )
      ],
    );
  }
}
