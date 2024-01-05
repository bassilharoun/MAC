import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:macidp/macidp/app_cubit/app_cubit.dart';
import 'package:macidp/macidp/app_cubit/app_states.dart';
import 'package:macidp/macidp/models/products_model.dart';
import 'package:macidp/macidp/models/IDP_list_data.dart';
import 'package:macidp/macidp/newscreens/license%20details/license_details_screen.dart';
import 'package:macidp/macidp/shared/colors.dart';
import 'package:macidp/macidp/shared/components/components.dart';
import 'package:macidp/main.dart';
import 'package:simple_html_css/simple_html_css.dart';

class IDPListView extends StatefulWidget {
  @override
  _IDPListViewState createState() => _IDPListViewState();
}

class _IDPListViewState extends State<IDPListView>
    with TickerProviderStateMixin {
  AnimationController? animationController;

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    super.initState();
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 50));
    return true;
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        List<IdpListData> idpListData = <IdpListData>[
          IdpListData(
            startColor: '#FE95B6',
            endColor: '#8201E9',
          ),
          IdpListData(
            startColor: '#D89501',
            endColor: '#FFD700',
          ),
          IdpListData(
            startColor: '#0A296D',
            endColor: '#C0C0C0',
          ),
        ];

        return Container(
          height: 260,
          width: double.infinity,
          child: ListView.builder(
            padding:
                const EdgeInsets.only(top: 0, bottom: 0, right: 16, left: 16),
            itemCount: idpListData.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              final int count =
                  idpListData.length > 10 ? 10 : idpListData.length;
              final Animation<double> animation =
                  Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
                      parent: animationController!,
                      curve: Interval((1 / count) * index, 1.0,
                          curve: Curves.fastOutSlowIn)));
              animationController?.forward();

              return GestureDetector(
                onTap: () {
                  AppCubit.get(context)
                      .getOneProduct(
                          context, AppCubit.get(context).idpProducts[index])
                      .then((value) {
                    Navigator.pop(context);
                    navigateTo(
                        context,
                        CourseInfoScreen(
                            index, AppCubit.get(context).idpProducts[index]));
                  });
                },
                child: CarsView(
                  AppCubit.get(context).idpProducts[index],
                  idpListData: idpListData[index],
                  animation: animation,
                  animationController: animationController!,
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class CarsView extends StatelessWidget {
  const CarsView(this.product,
      {this.idpListData, this.animationController, this.animation});

  final Products product;
  final IdpListData? idpListData;
  final AnimationController? animationController;
  final Animation<double>? animation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: animation!,
          child: Transform(
            transform: Matrix4.translationValues(
                100 * (1.0 - animation!.value), 0.0, 0.0),
            child: SizedBox(
              width: 300,
              child: Stack(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 32, left: 8, right: 8, bottom: 16),
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: HexColor(idpListData!.endColor)
                                  .withOpacity(0.6),
                              offset: const Offset(1.1, 4.0),
                              blurRadius: 8.0),
                        ],
                        gradient: LinearGradient(
                          colors: <HexColor>[
                            HexColor(idpListData!.startColor),
                            HexColor(idpListData!.endColor),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: const BorderRadius.only(
                          bottomRight: Radius.circular(20.0),
                          bottomLeft: Radius.circular(20.0),
                          topLeft: Radius.circular(20.0),
                          topRight: Radius.circular(20.0),
                        ),
                      ),
                      child: Padding(
                        padding:
                            const EdgeInsets.only(top: 40, left: 10, right: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              product.name!,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                letterSpacing: 0.2,
                                color: whiteColor,
                              ),
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  // RichText(
                                  //   text: HTML.toTextSpan(
                                  //       context, product.shortDescription!),
                                  //   maxLines: 4,
                                  // ),
                                  // Html(
                                  //   data: product.description!,
                                  // ),
                                  Text(
                                    AppCubit.get(context)
                                        .extractTextFromLiElements(
                                            product.shortDescription!)
                                        .join('\n'),
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12,
                                      letterSpacing: 0.2,
                                      color: whiteColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  Text(
                                    product.price.toString(),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 30,
                                      letterSpacing: 0.2,
                                      color: whiteColor,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 4, bottom: 3),
                                    child: Text(
                                      'ر.س',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15,
                                        letterSpacing: 0.2,
                                        color: whiteColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              margin: EdgeInsets.only(bottom: 8),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: -50,
                    bottom: 150,
                    left: -50,
                    right: 150,
                    child: Container(
                      width: 250,
                      height: 150,
                      decoration: BoxDecoration(
                        color: whiteColor.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
