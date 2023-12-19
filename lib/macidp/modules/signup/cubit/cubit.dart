import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:macidp/const.dart';
import 'package:macidp/macidp/models/user_model.dart';
import 'package:macidp/macidp/modules/signup/cubit/states.dart';

class AppSignupCubit extends Cubit<AppSignupStates> {
  AppSignupCubit() : super(AppSignupInitialState());

  static AppSignupCubit get(context) => BlocProvider.of(context);

  void userSignup(
      {required String email,
      required String name,
      required String phone,
      required String password}) async {
    emit(AppSignupLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) async {
      print(value.user!.email);
      print(value.user!.uid);
      await uploadProfileImage().then((val) {
        userCreate(
            email: email,
            name: name,
            phone: phone,
            uId: value.user!.uid,
            profImg: val,
            country: dropdCountry!);
        uId = value.user!.uid;
      });
    }).catchError((error) {
      emit(AppSignupErrorState(error));
    });
  }

  void userCreate({
    required String email,
    required String name,
    required String phone,
    required String uId,
    required String profImg,
    required String country,
  }) async {
    UserModel model = UserModel(
      name: name,
      email: email,
      phone: phone,
      uId: uId,
      image: profImg,
      country: country,
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toMap())
        .then((value) {
      emit(AppCreateUserSuccessState());
    }).catchError((error) {
      emit(AppCreateUserErrorState(error.toString()));
    });
  }

  dynamic profileImage;
  var picker = ImagePicker();

  Future<void> getProfileImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(AppProfileImagePickedSuccessState());
    } else {
      print('No image selected');
      emit(AppProfileImagePickedErrorState());
    }
  }

  Future<String> uploadProfileImage() async {
    String imgUrl = '';
    emit(AppUserUpdateLoadingState());
    await firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage)
        .then((value) async {
      imgUrl = await value.ref.getDownloadURL();
      print(imgUrl);
    }).catchError((error) {
      emit(AppUploadProfileImageErrorState());
    });
    return imgUrl;
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(AppChangePasswordVisibilitySignupState());
  }

  String? dropdCountry = "اختر دولة الاقامة";

  var country = [
    "اختر دولة الاقامة",
    "الجزائر",
    "مصر",
    "المغرب",
    "تونس",
    "ليبيا",
    "السودان",
    "العراق",
    "الأردن",
    "لبنان",
    "فلسطين",
    "سوريا",
    "اليمن",
    "السعودية",
    "الإمارات العربية المتحدة",
    "قطر",
    "البحرين",
    "عمان",
    "الكويت",
    "الجزر القمر",
    "جيبوتي",
    "موريتانيا",
    "الصومال",
    "الصحراء الغربية",
    "السلطنة",
    "العمق",
    "البلقان",
    "الأندلس",
    "الصين",
    "الهند",
    "روسيا",
    "البرازيل",
    "كندا",
    "أستراليا",
    "اليابان",
    "كوريا الجنوبية",
    "كوريا الشمالية",
    "إنجلترا",
    "فرنسا",
    "ألمانيا",
    "إيطاليا",
    "إسبانيا",
    "البرتغال",
    "هولندا",
    "بلجيكا",
    "النمسا",
    "سويسرا",
    "السويد",
    "النرويج",
    "دنمارك",
    "فنلندا",
  ];

  changeDropdownCountry(String? newValue) {
    dropdCountry = newValue;
    emit(AppSignupChangeDropdown());
  }
}
