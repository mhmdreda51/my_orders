// ignore_for_file: implementation_imports

import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';

import '../../../widgets/loading_widget.dart';
import '../../../widgets/main_button.dart';
import '../controller/order_cubit.dart';

class AddToCartButton extends StatelessWidget {
  const AddToCartButton({
    Key? key,
    required this.storeId,
    required this.itemId,
  }) : super(key: key);
  final int storeId;
  final int itemId;

  @override
  Widget build(BuildContext context) {
    final cubit = OrderCubit.get(context);
    final isLoading = cubit.state is OrderButtonLoading;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
      child: isLoading
          ? const LoadingWidget()
          : MainButton(
              text: "order.cart_button_title".tr(),
              onPressed: () =>
                  cubit.addToCart(storeId: storeId, itemId: itemId),
            ),
    );
  }
}
