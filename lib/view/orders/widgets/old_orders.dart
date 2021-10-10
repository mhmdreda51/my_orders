// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:my_orders/view/orders/component/list_separator.dart';
import 'package:my_orders/view/orders/component/orders_list_card.dart';
import 'package:my_orders/view/orders/model/orders_model.dart';

class OldOrders extends StatelessWidget {
  const OldOrders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        separatorBuilder: (context, index) => ListSeparator(),
        itemCount: orderModelList.length,
        itemBuilder: (context, index) => OrdersListCard(
          orderModel: orderModelList,
          index: index,
        ),
      ),
    );
  }
}
