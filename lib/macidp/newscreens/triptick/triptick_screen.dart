import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:macidp/macidp/app_cubit/app_cubit.dart';
import 'package:macidp/macidp/app_cubit/app_states.dart';
import 'package:macidp/macidp/layout/shop_layout.dart';
import 'package:macidp/macidp/newscreens/ui_view/area_list_view.dart';
import 'package:macidp/macidp/newscreens/ui_view/running_view.dart';
import 'package:macidp/macidp/newscreens/ui_view/title_view.dart';
import 'package:macidp/macidp/newscreens/ui_view/workout_view.dart';

import '../app_theme.dart';

class TriptickScreen extends StatefulWidget {
  @override
  _TriptickScreenState createState() => _TriptickScreenState();
}

class _TriptickScreenState extends State<TriptickScreen>
    with TickerProviderStateMixin {
  List<Widget> listViews = <Widget>[];

  @override
  void initState() {
    addAllListData();
    super.initState();
  }

  void addAllListData() {
    listViews.add(getAppBarUI());

    listViews.add(
      TitleView(
        titleTxt: "! استخراج دفتر التربتيك",
        subTxt: 'more',
      ),
    );

    listViews.add(
      WorkoutView(),
    );

    listViews.add(
      AreaListView(),
    );

    listViews.add(SizedBox(
      height: 80,
    ));
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
