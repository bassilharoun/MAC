import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:macidp/macidp/app_cubit/app_cubit.dart';
import 'package:macidp/macidp/app_cubit/app_states.dart';
import 'package:macidp/macidp/layout/shop_layout.dart';
import 'package:macidp/macidp/newscreens/ui_view/area_list_view.dart';
import 'package:macidp/macidp/newscreens/ui_view/running_view.dart';
import 'package:macidp/macidp/newscreens/ui_view/title_view.dart';
import 'package:macidp/macidp/newscreens/ui_view/workout_view.dart';
import 'package:macidp/macidp/shared/colors.dart';
import 'package:macidp/macidp/shared/components/applocale.dart';


class TriptickScreen extends StatefulWidget {
  @override
  _TriptickScreenState createState() => _TriptickScreenState();
}

class _TriptickScreenState extends State<TriptickScreen>
    with TickerProviderStateMixin {
  List<Widget> listViews = <Widget>[];

  @override
  void initState() {
    super.initState();
  }

  // void addAllListData() {
  //   listViews.add(getAppBarUI());
  //   listViews.add(
  //     TitleView(
  //       titleTxt: "${getLang(context, "TRIPTICK_TITLE")}",
  //       subTxt: 'more',
  //     ),
  //   );
  //   listViews.add(
  //     WorkoutView(),
  //   );
  //   listViews.add(
  //     AreaListView(),
  //   );
  //   listViews.add(SizedBox(
  //     height: 80,
  //   ));
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
      children: [
        getAppBarUI(context),
        TitleView(
          titleTxt: "${getLang(context, "TRIPTICK_TITLE")}",
          subTxt: 'more',
        ),
        WorkoutView(),
        AreaListView(),
        SizedBox(
          height: 80,
        )
      ],
    );
  }
}
