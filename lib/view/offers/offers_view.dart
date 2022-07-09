// ignore_for_file: implementation_imports

import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_orders/view/offers/widgets/offers_card.dart';

import '../../core/router/router.dart';
import '../../widgets/loading_dialog.dart';
import '../order/order_view.dart';
import '../store/controller/store_cubit.dart';
import '../store/model/store_offer_model.dart';
import 'component/no_offers.dart';

class OffersView extends StatelessWidget {
  const OffersView({Key? key, required this.storeOfferModel, this.storeId})
      : super(key: key);
  final StoreOfferModel storeOfferModel;
  final int? storeId;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<StoreCubit, StoreState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(title: Text("offers.appBar_title".tr())),
            body: storeOfferModel.data!.isEmpty
                ? NoData(text: "offers.no_offers".tr())
                : ListView.builder(
                    itemCount: storeOfferModel.data!.length,
                    itemBuilder: (context, index) => OffersCard(
                      storeOfferModelData: storeOfferModel.data![index]!,
                      onTap: () {
                        loadingDialog(context);
                        StoreCubit().getItems(storeId: storeId!).then((value) {
                          print(storeOfferModel.data![index]!.id!);
                          print(storeOfferModel.data![index]!.name!);
                          MagicRouter.pop();
                          MagicRouter.navigateTo(
                            OrderView(
                              storeId: storeId!,
                              itemId: storeOfferModel.data![index]!.id!,
                              image: storeOfferModel.data![index]!.image!,
                              name: storeOfferModel.data![index]!.name!,
                              description:
                                  storeOfferModel.data![index]!.description!,
                            ),
                          );
                        });
                      },
                    ),
                  ),
          );
        },
      ),
    );
  }
}
