// ignore_for_file: implementation_imports

import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';

import '../../../core/router/router.dart';
import '../../../widgets/description_text.dart';
import '../../register/register_view.dart';

class TextButtonRow extends StatelessWidget {
  const TextButtonRow({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        DescriptionText(
          description: "login.no_account".tr(),
          horizontalPadding: 0.0,
          verticalPadding: 0.0,
        ),
        TextButton(
          onPressed: () => MagicRouter.navigateTo(const RegisterView()),
          child: Text("login.create_account".tr(),
              style: const TextStyle(fontSize: 16.0)),
        ),
      ],
    );
  }
}
