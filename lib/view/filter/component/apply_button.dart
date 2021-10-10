// ignore_for_file: implementation_imports

import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:my_orders/core/router/router.dart';
import 'package:my_orders/view/filter_result/filter_result_view.dart';
import 'package:my_orders/widgets/main_button.dart';

class ApplyButton extends StatelessWidget {
  const ApplyButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: MainButton(
            text: "filter.apply".tr(),
            onPressed: () {
              //TODO: add the apply filter button functionality here
              MagicRouter.navigateTo(const FilterResultView());
            }),
      ),
    );
  }
}
