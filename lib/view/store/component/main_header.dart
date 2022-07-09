// ignore_for_file: implementation_imports

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../core/router/router.dart';
import '../../../widgets/clickable_small_text.dart';
import '../../../widgets/custom_vertical_divider.dart';
import '../../../widgets/small_grey_text.dart';
import '../../../widgets/stars_bar.dart';
import '../../../widgets/store_time.dart';
import '../../food/model/store_model.dart';
import '../../restaurant_info/restaurant_info_view.dart';
import '../../reviews/reviews_view.dart';
import '../controller/store_cubit.dart';

class MainHeader extends StatelessWidget {
  final StoreCubit cubit;
  final StoreModelData storeModelData;
  const MainHeader(
      {Key? key, required this.cubit, required this.storeModelData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String open = "2020-07-20T${storeModelData.openAt}";
    String close = "2020-07-20T${storeModelData.closeAt}";
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    storeModelData.name!,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20.0),
                  ),
                  const SizedBox(width: 4.0),
                ],
              ),
              StarsBar(stars: double.parse(storeModelData.rate!)),
            ],
          ),
          const SizedBox(height: 8.0),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: Text(storeModelData.description!,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 16.0)),
              ),
              const CustomVerticalDivider(),
              Flexible(
                child: SmallGreyText(
                  text: "restaurant.delivery".tr() +
                      storeModelData.deliveryFees!.toString() +
                      ' ' +
                      "restaurant.egp".tr(),
                  fontSize: 10.0,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          Row(
            children: <Widget>[
              StoreTime(
                  text: DateFormat.jm().format(DateTime.parse(open)),
                  color: Colors.green),
              const CustomVerticalDivider(),
              StoreTime(
                  text: DateFormat.jm().format(DateTime.parse(close)),
                  color: Colors.red),
              const Spacer(),
              ClickableSmallText(
                  text: "restaurant.info".tr(),
                  onTap: () => MagicRouter.navigateTo(RestaurantInfoView(
                        storeModelData: storeModelData,
                      ))),
              const CustomVerticalDivider(),
              ClickableSmallText(
                  text: "restaurant.reviews".tr(),
                  onTap: () => MagicRouter.navigateTo(ReviewsView(
                        storeModelData: storeModelData,
                        cubit: cubit,
                      ))),
            ],
          )
        ],
      ),
    );
  }
}
