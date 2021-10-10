import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_orders/view/login/controller/login_cubit.dart';

import '../../../core/router/router.dart';
import '../../cart/cart_view.dart';
import '../../order/controller/order_cubit.dart';
import '../../settings/settings_view.dart';

class DrawerHeaderBody extends StatelessWidget {
  const DrawerHeaderBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit()..getData(),
      child: BlocBuilder<LoginCubit, LoginState>(
        builder: (context, state) {
          final cubit = LoginCubit.get(context);

          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                onPressed: () {
                  MagicRouter.pop();
                  MagicRouter.navigateTo(BlocProvider.value(
                    value: OrderCubit.get(context),
                    child: const CartView(),
                  ));
                },
                icon: const FaIcon(FontAwesomeIcons.shoppingCart,
                    color: Colors.white),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(50)),
                      child: const CircleAvatar(
                        backgroundColor: Colors.transparent,
                        foregroundColor: Colors.white,
                        radius: 30,
                        child: Center(
                            child: Icon(
                          Icons.person_outline,
                          size: 30,
                        )),
                      ),
                    ),
                    const SizedBox(height: 8),
                    // InkWell(
                    //   onTap: () => MagicRouter.navigateAndPopUntilFirstPage(
                    //       const LoginView()),
                    //   child: Text(
                    //     //TODO: add the user name here
                    //     '${cubit.usersList[0].data.firstName + cubit.users!.data.lastName}',
                    //     style: const TextStyle(
                    //         color: Colors.white,
                    //         fontWeight: FontWeight.bold,
                    //         fontSize: 18),
                    //   ),
                    // ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {
                  MagicRouter.pop();
                  MagicRouter.navigateTo(const SettingsView());
                },
                icon: const FaIcon(FontAwesomeIcons.cog, color: Colors.white),
              ),
            ],
          );
        },
      ),
    );
  }
}
