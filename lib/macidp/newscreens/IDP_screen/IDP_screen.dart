import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:macidp/macidp/app_cubit/app_cubit.dart';
import 'package:macidp/macidp/app_cubit/app_states.dart';
import 'package:macidp/macidp/layout/shop_layout.dart';
import 'package:macidp/macidp/newscreens/IDP_screen/IDP_list_view.dart';
import 'package:macidp/macidp/newscreens/IDP_screen/water_view.dart';
import 'package:macidp/macidp/newscreens/ui_view/body_measurement.dart';
import 'package:macidp/macidp/newscreens/ui_view/glass_view.dart';
import 'package:macidp/macidp/newscreens/ui_view/title_view.dart';
import 'package:macidp/macidp/shared/colors.dart';
import 'package:macidp/macidp/shared/components/applocale.dart';

class IDPScreen extends StatefulWidget {
  @override
  _IDPScreenState createState() => _IDPScreenState();
}

class _IDPScreenState extends State<IDPScreen> with TickerProviderStateMixin {
  List<Widget> listViews = <Widget>[];
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // addAllListData();
  }

  // void addAllListData() {
  //   listViews.add(getAppBarUI());

  //   listViews.add(
  //     TitleView(
  //       titleTxt: '{getLang(context, "LICENCE_TITLE")}',
  //       subTxt: 'Details',
  //     ),
  //   );
  //   // listViews.add(
  //   //   MediterranesnDietView(),
  //   // );
  //   // listViews.add(
  //   //   TitleView(
  //   //     titleTxt: 'Our offers',
  //   //     subTxt: 'Order Now',
  //   //   ),
  //   // );

  //   listViews.add(
  //     IDPListView(),
  //   );

  //   listViews.add(
  //     BodyMeasurementView(),
  //   );
  //   listViews.add(
  //     TitleView(
  //       titleTxt: 'اراء العملاء',
  //       subTxt: '',
  //     ),
  //   );

  //   listViews.add(
  //     WaterView(),
  //   );
  //   listViews.add(
  //     GlassView(),
  //   );

  //   listViews.add(
  //     SizedBox(
  //       height: 80,
  //     ),
  //   );
  // }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 50));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Container(
            color: whiteColor,
            child: getMainListViewUI(),
          );
        });
  }

  Widget getMainListViewUI() {
    return ListView(
      // controller: scrollController,
      children: [
        getAppBarUI(context),
        TitleView(
          titleTxt: '${getLang(context, "LICENCE_TITLE")}',
          subTxt: 'Details',
        ),
        IDPListView(),
        BodyMeasurementView(),
        TitleView(
          titleTxt: '${getLang(context, "LICENCE_COUSTMER")}',
          subTxt: '',
        ),
        WaterView(),
        GlassView(),
        SizedBox(
          height: 80,
        ),
      ],
    );
  }
}
