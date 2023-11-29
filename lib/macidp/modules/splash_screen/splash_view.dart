import 'package:flutter/material.dart';
import 'package:macidp/const.dart';
import 'package:macidp/macidp/app_cubit/app_cubit.dart';
import 'package:macidp/macidp/layout/shop_layout.dart';
import 'package:macidp/macidp/modules/login/login_screen.dart';
import 'package:macidp/macidp/shared/components/components.dart';
import 'package:macidp/macidp/shared/network/local/cache_helper.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  _getData() async {
    Widget widget;
    uId = await CacheHelper.getData(key: 'uId');
    if (uId != null) {
      AppCubit.get(context).getUserData();
      widget = ShopLayout();
    } else {
      widget = LoginScreen();
    }
    AppCubit.get(context).getProducts(context).then((value) {
      AppCubit.get(context).getCart(context).then((value) {
        _goNext(widget);
      });
    });
  }

  _goNext(Widget widget) {
    navigateAndFinish(context, widget);
  }

  @override
  void initState() {
    super.initState();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Container(
        width: double.infinity,
        child: const Image(
          image: AssetImage("assets/images/logo.png"),
          fit: BoxFit.cover,
        ),
      )),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
