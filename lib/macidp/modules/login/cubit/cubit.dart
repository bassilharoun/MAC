import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:macidp/const.dart';
import 'package:macidp/macidp/modules/login/cubit/states.dart';

class AppLoginCubit extends Cubit<AppLoginStates>{
  AppLoginCubit() : super(AppLoginInitialState());

  static AppLoginCubit get(context) => BlocProvider.of(context);

  // LoginModel? loginModel ;
  
  void userLogin({
    required String email ,
    required String password
}){
    emit(AppLoginLoadingState());

    FirebaseAuth.instance.signInWithEmailAndPassword(email: email,
        password: password
    ).then((value) {
      print(value.user!.email);
      print(value.user!.uid);
      uId = value.user!.uid;
      emit(AppLoginSuccessState(value.user!.uid));
    }).catchError((error){
      emit(AppLoginErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined ;
  bool isPassword = true ;

  void changePasswordVisibility(){
    isPassword = !isPassword ;
    suffix = isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined ;
    emit(AppChangePasswordVisibilityState());
  }
}