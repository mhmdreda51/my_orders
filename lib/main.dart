import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_orders/view/orders/controller/orders_cubit.dart';
import 'package:my_orders/view/splash/splash_view.dart';

import 'core/blocObserver/bloc_observer.dart';
import 'core/cacheHelper/cache_helper.dart';
import 'core/dioHelper/dio_helper.dart';
import 'core/router/router.dart';
import 'core/theme/theme.dart';
import 'view/drawer/controller/drawer_cubit.dart';
import 'view/order/controller/order_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //===============================================================
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  //===============================================================
  await EasyLocalization.ensureInitialized();
  //===============================================================
  await CacheHelper.init();
  //===============================================================
  // var accessToken = CacheHelper.get(key: 'accessToken') ?? "";
  // late Widget startScreen;
  //
  // if (accessToken == '' || accessToken == null) {
  //   startScreen = const LoginView();
  // } else {
  //   startScreen = const HomeView();
  // }
  //===============================================================

  runApp(EasyLocalization(
    child: MyApp(),
    path: 'assets/translation',
    supportedLocales: const [Locale('en', 'US'), Locale('ar', 'EG')],
    fallbackLocale: const Locale('en', 'US'),
  ));
}

class MyApp extends StatelessWidget {
  // final Widget startScreen;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => DrawerCubit(),
        ),
        BlocProvider(
          create: (context) => OrdersCubit(),
        ),
        BlocProvider(
          create: (context) => OrderCubit(),
        ),
      ],
      child: MaterialApp(
        title: 'My Order',
        debugShowCheckedModeBanner: false,
        navigatorKey: navigatorKey,
        onGenerateRoute: onGenerateRoute,
        theme: theme(context),
        locale: context.locale,
        supportedLocales: context.supportedLocales,
        localizationsDelegates: context.localizationDelegates,
        home: const SplashView(),
      ),
    );
  }
}
