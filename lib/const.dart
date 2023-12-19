import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:macidp/macidp/app_cubit/app_cubit.dart';
import 'package:macidp/macidp/models/user_model.dart';
import 'package:macidp/macidp/modules/login/login_screen.dart';
import 'package:macidp/macidp/shared/components/components.dart';
import 'package:macidp/macidp/shared/network/local/cache_helper.dart';

dynamic uId ;
Locale myLocale = window.locale;

void signOut(context){
  CacheHelper.removeData(key: 'uId').then((value) {
    if(value){
      uId = '';
      AppCubit.get(context).userModel = UserModel.fromJson({});
      navigateAndFinish(context, LoginScreen());
    }
  });
}