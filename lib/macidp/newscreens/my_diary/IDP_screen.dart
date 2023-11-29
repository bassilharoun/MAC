import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:macidp/macidp/app_cubit/app_cubit.dart';
import 'package:macidp/macidp/app_cubit/app_states.dart';
import 'package:macidp/macidp/layout/shop_layout.dart';
import 'package:macidp/macidp/newscreens/app_theme.dart';
import 'package:macidp/macidp/newscreens/my_diary/IDP_list_view.dart';
import 'package:macidp/macidp/newscreens/my_diary/water_view.dart';
import 'package:macidp/macidp/newscreens/ui_view/body_measurement.dart';
import 'package:macidp/macidp/newscreens/ui_view/glass_view.dart';
import 'package:macidp/macidp/newscreens/ui_view/mediterranean_diet_view.dart';
import 'package:macidp/macidp/newscreens/ui_view/title_view.dart';

class IDPScreen extends StatefulWidget {
  @override
  _IDPScreenState createState() => _IDPScreenState();
}

class _IDPScreenState extends State<IDPScreen> with TickerProviderStateMixin {
  List<Widget> listViews = <Widget>[];
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    addAllListData();
    super.initState();
  }

  void addAllListData() {
    const int count = 9;

    listViews.add(getAppBarUI());

    listViews.add(
      TitleView(
        titleTxt: '! استخراج رخصة قيادة دولية',
        subTxt: 'Details',
      ),
    );
    // listViews.add(
    //   MediterranesnDietView(),
    // );
    // listViews.add(
    //   TitleView(
    //     titleTxt: 'Our offers',
    //     subTxt: 'Order Now',
    //   ),
    // );

    listViews.add(
      IDPListView(),
    );

    listViews.add(
      BodyMeasurementView(),
    );
    listViews.add(
      TitleView(
        titleTxt: 'Customer Review',
        subTxt: '',
      ),
    );

    listViews.add(
      WaterView(),
    );
    listViews.add(
      GlassView(),
    );
  }

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
            color: AppTheme.background,
            child: getMainListViewUI(),
          );
        });
  }

  Widget getMainListViewUI() {
    return ListView.builder(
      // padding: EdgeInsets.only(
      //   top: AppBar().preferredSize.height +
      //       MediaQuery.of(context).padding.top +
      //       24,
      //   bottom: 62 + MediaQuery.of(context).padding.bottom,
      // ),
      itemCount: listViews.length,
      itemBuilder: (BuildContext context, int index) {
        return listViews[index];
      },
    );
  }
}
