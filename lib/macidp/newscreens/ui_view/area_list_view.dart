import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:macidp/macidp/app_cubit/app_cubit.dart';
import 'package:macidp/macidp/newscreens/triptick/triptick_info_screen.dart';
import 'package:macidp/macidp/shared/colors.dart';
import 'package:macidp/macidp/shared/components/applocale.dart';
import 'package:macidp/macidp/shared/components/components.dart';


class AreaListView extends StatefulWidget {
  @override
  _AreaListViewState createState() => _AreaListViewState();
}

class _AreaListViewState extends State<AreaListView>
    with TickerProviderStateMixin {
  List<String> areaListData = <String>[
    'assets/images/europe.png',
    'assets/images/yemen.png',
    'assets/images/Egypt.png',
  ];

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 0.8,
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8),
        child: GridView(
          padding:
              const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 16),
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          children: List<Widget>.generate(
            areaListData.length,
            (int index) {
              if (index == 0 || index == 1) {
                return TriptickCard(
                  imagepath: areaListData[index],
                  name: AppCubit.get(context).triptickProducts[index].name,
                  price:
                      "${AppCubit.get(context).triptickProducts[index].price}",
                  index: index,
                );
              } else {
                return TriptickCard(
                  imagepath: areaListData[index],
                  name: "${getLang(context, "TRIPTICK_EGYPT")}",
                  price: "${getLang(context, "TRIPTICK_SOON")}",
                  index: index,
                );
              }
            },
          ),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 24.0,
            crossAxisSpacing: 24.0,
            childAspectRatio: 0.75,
          ),
        ),
      ),
    );
  }
}

class TriptickCard extends StatelessWidget {
  const TriptickCard(
      {Key? key,
      this.imagepath,
      this.name,
      this.price,
      this.animationController,
      this.animation,
      this.index})
      : super(key: key);

  final String? imagepath;
  final String? name;
  final String? price;
  final int? index;
  final AnimationController? animationController;
  final Animation<double>? animation;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20.0),
          bottomLeft: Radius.circular(20.0),
          bottomRight: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: greyColor.withOpacity(0.4),
              offset: const Offset(1.1, 1.1),
              blurRadius: 10.0),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          focusColor: Colors.transparent,
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
          splashColor: buttonsColor.withOpacity(0.2),
          onTap: () {
            print(AppCubit.get(context).products[index!].name);
            if (index == 0 || index == 1) {
              navigateTo(
                  context,
                  TriptickInfoScreen(
                      index!, AppCubit.get(context).triptickProducts[index!]));
            } else {
              showToast(text: "قريبا", state: ToastStates.WARNING);
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      bottomLeft: Radius.circular(20.0),
                      bottomRight: Radius.circular(20.0),
                      topRight: Radius.circular(20.0),
                    ),
                    child: Image.asset(imagepath!)),
                Expanded(
                  child: Text(
                    name!,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "${price}",
                        style: TextStyle(
                            color: buttonsColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                      if (price != getLang(context, "TRIPTICK_SOON"))
                        Text(
                          "SAR",
                          style: TextStyle(fontSize: 12),
                        )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
