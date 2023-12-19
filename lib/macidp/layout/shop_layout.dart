import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:macidp/macidp/app_cubit/app_cubit.dart';
import 'package:macidp/macidp/app_cubit/app_states.dart';
import 'package:macidp/macidp/newscreens/app_theme.dart';
import 'package:macidp/macidp/shared/colors.dart';

class ShopLayout extends StatefulWidget {
  @override
  State<ShopLayout> createState() => _ShopLayoutState();
}

class _ShopLayoutState extends State<ShopLayout> {
  double topBarOpacity = 0.0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var cubit = AppCubit.get(context);
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
              backgroundColor: Colors.grey[200],
              body:
                  // getAppBarUI(),
                  Stack(
                children: [
                  cubit.screens[cubit.currentIndex],
                  Positioned(
                    height: 123,
                    bottom: 10,
                    right: 10,
                    left: 10,
                    child: Container(
                      height: 123,
                      child: DotNavigationBar(
                        marginR:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                        paddingR: const EdgeInsets.only(bottom: 5, top: 10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3),
                          ),
                        ],
                        onTap: (index) {
                          cubit.changeBottom(index, context);
                        },
                        currentIndex: cubit.currentIndex,
                        items: [
                          DotNavigationBarItem(
                            icon: Icon(
                              CupertinoIcons.home,
                            ),
                            selectedColor: lightColor,
                            unselectedColor: AppTheme.grey,
                          ),
                          DotNavigationBarItem(
                            icon: Icon(
                              CupertinoIcons.book,
                            ),
                            selectedColor: lightColor,
                            unselectedColor: AppTheme.grey,
                          ),
                          DotNavigationBarItem(
                            icon: Icon(
                              CupertinoIcons.cart,
                            ),
                            selectedColor: lightColor,
                            unselectedColor: AppTheme.grey,
                          ),
                          DotNavigationBarItem(
                            icon: Icon(
                              CupertinoIcons.person,
                            ),
                            selectedColor: lightColor,
                            unselectedColor: AppTheme.grey,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )),
        );
      },
    );
  }
}

Widget getAppBarUI(context) {
  return Column(
    children: <Widget>[
      Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Image.asset(
                "assets/images/logoOne.png",
                scale: 7,
              ),
            ),
            Expanded(
              flex: 4,
              child: Image.asset(
                "assets/images/logotext.png",
                scale: 6,
              ),
            ),
            Expanded(
              flex: 1,
              child: Stack(
                children: [
                  IconButton(onPressed: () {}, icon: Icon(CupertinoIcons.bell)),
                  Positioned(
                    child: CircleAvatar(
                      backgroundColor: Colors.red,
                      radius: 3,
                    ),
                    top: 25,
                    right: 12,
                    left: 25,
                    bottom: 12,
                  )
                ],
              ),
            )
          ],
        ),
      )
    ],
  );
}
