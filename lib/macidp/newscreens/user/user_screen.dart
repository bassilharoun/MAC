import 'dart:ui' as ui;
import 'dart:ui';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:macidp/const.dart';
import 'package:macidp/macidp/app_cubit/app_cubit.dart';
import 'package:macidp/macidp/newscreens/app_theme.dart';
import 'package:macidp/macidp/newscreens/ui_view/image_dialog.dart';
import 'package:macidp/macidp/shared/components/applocale.dart';
import 'package:macidp/main.dart';
import 'package:u_credit_card/u_credit_card.dart';

class NewUserScreen extends StatelessWidget {
  const NewUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
      controller: ZoomDrawerController(),
      menuScreen: YourMenuScreen(),
      mainScreen: UserScreen(),
      borderRadius: 24.0,
      showShadow: true,
      angle: -12.0,
      drawerShadowsBackgroundColor: Colors.grey[300]!,
      menuBackgroundColor: Colors.grey[300]!,
      slideWidth: MediaQuery.of(context).size.width * 0.65,
      mainScreenScale: 0.1,
    );
  }
}

class UserScreen extends StatefulWidget {
  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Locale locale;

    return Scaffold(
      extendBodyBehindAppBar: true,
      //   drawer:
      //       ZoomDrawer(
      //   controller: ZoomDrawerController,
      //   menuScreen: MenuScreen(),
      //   mainScreen: MainScreen(),
      //   borderRadius: 24.0,
      //   showShadow: true,
      //   angle: -12.0,
      //   drawerShadowsBackgroundColor: Colors.grey[300],
      //   slideWidth: MediaQuery.of(context).size.width * 0.65,
      // )
      //  Drawer(
      //   child: ListView(
      //     padding: EdgeInsets.zero,
      //     children: <Widget>[
      //       DrawerHeader(
      //         decoration: BoxDecoration(
      //           color: AppTheme.nearlyDarkBlue,
      //         ),
      //         child: Column(
      //           crossAxisAlignment: CrossAxisAlignment.start,
      //           children: [
      //             Text(
      //               '${AppCubit.get(context).userModel!.name}',
      //               style: TextStyle(
      //                 color: Colors.white,
      //                 fontSize: 24,
      //               ),
      //             ),
      //             Text(
      //               '${AppCubit.get(context).userModel!.email}',
      //               style: TextStyle(
      //                   color: Colors.white,
      //                   fontSize: 16,
      //                   fontWeight: FontWeight.normal),
      //             ),
      //           ],
      //         ),
      //       ),
      //       ListTile(
      //         leading: Icon(
      //           Icons.logout,
      //           color: Colors.red,
      //         ),
      //         title: Text(
      //           '${getLang(context, "LOGOUT")}',
      //           style: TextStyle(color: Colors.red),
      //         ),
      //         onTap: () => {
      //           signOut(context),
      //         },
      //       ),
      //       ListTile(
      //         leading: Icon(
      //           Icons.translate,
      //           color: AppTheme.nearlyDarkBlue,
      //         ),
      //         title: Text(
      //           '${getLang(context, "CHANGE_LANGUAGE")}',
      //           style: TextStyle(color: AppTheme.nearlyDarkBlue),
      //         ),
      //         onTap: () {
      //           if (MyApp.of(context)!.getLocale().languageCode == 'ar') {
      //             MyApp.of(context)
      //                 ?.setLocale(Locale.fromSubtags(languageCode: 'en'));

      //             AppCubit.get(context).getProducts(context);
      //           } else {
      //             MyApp.of(context)
      //                 ?.setLocale(Locale.fromSubtags(languageCode: 'ar'));

      //             AppCubit.get(context).getProducts(context);
      //           }
      //         },
      //       ),
      //     ],
      //   ),
      // ),

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => Profile3()),
            // );
          },
          child: Builder(
            builder: (context) => IconButton(
              onPressed: () {
                print("open Drawer");
                ZoomDrawer.of(context)!.open();
                // Scaffold.of(context).openDrawer();
              },
              icon: Icon(
                Icons.menu,
                color: Colors.white,
                size: 24,
              ),
            ),
          ),
        ),
        title: Text(
          "${getLang(context, "PROFILE_TITLE")}",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: <Widget>[
          Center(
            child: Image.network(
              "${AppCubit.get(context).userModel!.image}",
              fit: BoxFit.cover,
              width: size.width,
              height: size.height,
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: size.height * 0.5,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: size.height - 100,
                    padding: EdgeInsets.symmetric(
                      horizontal: 16,
                    ),
                    decoration: BoxDecoration(
                        color: AppTheme.background,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8.0),
                          bottomLeft: Radius.circular(8.0),
                          bottomRight: Radius.circular(8.0),
                          topRight: Radius.circular(68.0),
                        )),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(
                            top: 32,
                            bottom: 16,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  CircleAvatar(
                                    radius: 28,
                                    backgroundImage: NetworkImage(
                                        "${AppCubit.get(context).userModel!.image}"),
                                  ),
                                  SizedBox(
                                    width: 12,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        "${AppCubit.get(context).userModel!.name}",
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 4,
                                      ),
                                      Text(
                                        "${AppCubit.get(context).userModel!.country}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          color: Colors.grey[200],
                        ),
                        Container(
                          height: 64,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        "${getLang(context, "PROFILE_PENDING_ORDERS")}",
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 12,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 4,
                                      ),
                                      Text(
                                        "0",
                                        style: TextStyle(
                                          color: Colors.black87,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        "${getLang(context, "PROFILE_COMPLETED_ORDERS")}",
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 12,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 4,
                                      ),
                                      Text(
                                        "${AppCubit.get(context).myLicenses.length}",
                                        style: TextStyle(
                                          color: Colors.black87,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        "${getLang(context, "PROFILE_CANCELLED_ORDERS")}",
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 12,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 4,
                                      ),
                                      Text(
                                        "0",
                                        style: TextStyle(
                                          color: Colors.black87,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          color: Colors.grey[200],
                        ),
                        Text(
                          "${getLang(context, "PROFILE_AVAILABLE_ORDERS")}",
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          height: 200,
                          child: ConditionalBuilder(
                            condition:
                                AppCubit.get(context).myLicenses.isNotEmpty,
                            builder: (context) => ListView.builder(
                                padding: EdgeInsets.all(8),
                                physics: BouncingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                itemCount:
                                    AppCubit.get(context).myLicenses.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return GestureDetector(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return ImageDialog(
                                            imageUrl:
                                                "${AppCubit.get(context).myLicenses[index]}",
                                          );
                                        },
                                      );
                                    },
                                    child: Container(
                                        height: 200,
                                        width: 300,
                                        margin:
                                            EdgeInsets.symmetric(horizontal: 4),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(
                                                  "${AppCubit.get(context).myLicenses[index]}"),
                                            ))),
                                  );
                                }),
                            fallback: (context) => Center(
                              child: Text(
                                "${getLang(context, "PROFILE_NO_AVAILABLE_ORDERS")}",
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        // Text(
                        //   "البطاقات البنكية المحفوظة",
                        //   style: TextStyle(
                        //     color: Colors.black87,
                        //     fontSize: 16,
                        //     fontWeight: FontWeight.bold,
                        //   ),
                        // ),
                        // Container(
                        //   height: 210,
                        //   child: ListView.builder(
                        //       padding: EdgeInsets.all(8),
                        //       physics: BouncingScrollPhysics(),
                        //       scrollDirection: Axis.horizontal,
                        //       itemCount: 2,
                        //       itemBuilder: (BuildContext context, int index) {
                        //         return buildPaymentCard(
                        //             paymentCards[index]["cardNumber"],
                        //             paymentCards[index]["cardHolderName"],
                        //             paymentCards[index]["topLeftColor"],
                        //             paymentCards[index]["bottomRightColor"],
                        //             paymentCards[index]["creditCardType"]);
                        //       }),
                        // ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Map> paymentCards = [
    {
      "cardHolderName": 'Abdulrahman',
      "cardNumber": '1234 5678 9012 3456',
      "validThru": '10/24',
      "creditCardType": CreditCardType.visa,
      "topLeftColor": Colors.blue,
      "bottomRightColor": Colors.blue,
    },
    {
      "cardHolderName": 'Abdulrahman',
      "cardNumber": '5555 5678 9012 6789',
      "validThru": '10/24',
      "creditCardType": CreditCardType.mastercard,
      "topLeftColor": Colors.black,
      "bottomRightColor": const Color.fromARGB(255, 53, 53, 53),
    },
  ];

  Widget buildPaymentCard(String cardNumber, String name, Color topLeftColor,
      Color bottomRightColor, CreditCardType creditCardType) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: CreditCardUi(
        cardHolderFullName: '$name',
        cardNumber: '$cardNumber',
        validThru: '10/24',
        creditCardType: creditCardType,
        topLeftColor: topLeftColor,
        bottomRightColor: bottomRightColor,
      ),
    );
  }
}

class YourMenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                height: 200,
                width: double.infinity,
                child: ClipRRect(
                  child: ImageFiltered(
                    imageFilter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                    child: Image.network(
                        fit: BoxFit.cover,
                        "${AppCubit.get(context).userModel!.image}"),
                  ),
                ),
              ),
              Column(
                children: [
                  Text(
                    '${AppCubit.get(context).userModel!.name}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                  Text(
                    '${AppCubit.get(context).userModel!.email}',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.normal),
                  ),
                ],
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8.0),
                bottomLeft: Radius.circular(8.0),
                bottomRight: Radius.circular(8.0),
                topRight: Radius.circular(30.0),
              ),
              child: Container(
                  color: Colors.red.withOpacity(0.8),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        signOut(context);
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.logout,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            '${getLang(context, "LOGOUT")}',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.normal),
                          ),
                        ],
                      ),
                    ),
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8.0),
                bottomLeft: Radius.circular(8.0),
                bottomRight: Radius.circular(8.0),
                topRight: Radius.circular(30.0),
              ),
              child: Container(
                  color: AppTheme.nearlyDarkBlue.withOpacity(0.8),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        if (MyApp.of(context)!.getLocale().languageCode ==
                            'ar') {
                          MyApp.of(context)?.setLocale(
                              Locale.fromSubtags(languageCode: 'en'));

                          AppCubit.get(context).getProducts(context);
                        } else {
                          MyApp.of(context)?.setLocale(
                              Locale.fromSubtags(languageCode: 'ar'));

                          AppCubit.get(context).getProducts(context);
                        }
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.translate,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            '${getLang(context, "CHANGE_LANGUAGE")}',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
