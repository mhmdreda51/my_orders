import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_orders/view/cart/states.dart';

import '../../widgets/loading_widget.dart';
import '../offers/component/no_offers.dart';
import 'component/buttons_row.dart';
import 'component/order_details_card.dart';
import 'cubit.dart';

class CartView extends StatelessWidget {
  const CartView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CartCubit()..getDetails(),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text("cart.appBar_title".tr()),
            actions: [
              Builder(builder: (context) {
                return IconButton(
                    onPressed: () {
                      CartCubit.of(context).clearCart();
                    },
                    icon: const Icon(Icons.delete_forever));
              }),
            ],
          ),
          body: Center(
            child: BlocBuilder<CartCubit, CartStates>(
              builder: (context, state) {
                if (state is CartLoading) return const LoadingWidget();
                final cartModel = CartCubit.of(context).cartModel;
                if (cartModel == null || cartModel.data!.items!.isEmpty) {
                  return NoData(text: "cart.no_orders".tr());
                }
                final data = cartModel.data!;
                return ListView(
                  children: [
                    // ListView.builder(
                    //   shrinkWrap: true,
                    //   itemCount: data.items!.length,
                    //   physics: const NeverScrollableScrollPhysics(),
                    //   itemBuilder: (context, index) {
                    //     final item = data.items![index];
                    //     return FoodCartCard(
                    //       item: item,
                    //       storeId: data.store!.id!,
                    //       orderCount: item.pivot!.quantity!,
                    //       name: item.name!,
                    //       price: item.pivot!.itemSizeId!.price!.toDouble(),
                    //       image: item.image!,
                    //       description: item.description!,
                    //       onTap: () {},
                    //     );
                    //   },
                    // ),
                    OrderDetailsCard(
                      totalPrice: data.total!.toDouble(),
                      deliveryFee: data.deliveryFees!,
                    ),
                    const ButtonsRow(),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
