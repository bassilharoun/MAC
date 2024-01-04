import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hyperpay_plugin/flutter_hyperpay.dart';
import 'package:hyperpay_plugin/model/ready_ui.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:macidp/const.dart';
import 'package:macidp/macidp/constance/config.dart';
import 'package:macidp/macidp/layout/shop_layout.dart';
import 'package:macidp/macidp/models/products_model.dart';
import 'package:macidp/macidp/models/user_model.dart';
import 'package:macidp/macidp/modules/cart_screen/cart_screen.dart';
import 'package:macidp/macidp/newscreens/IDP_screen/IDP_screen.dart';
import 'package:macidp/macidp/newscreens/triptick/triptick_screen.dart';
import 'package:macidp/macidp/newscreens/user/user_screen.dart';
import 'package:macidp/macidp/payment/conf.dart';
import 'package:http/http.dart' as http;
import 'package:macidp/macidp/shared/components/components.dart';
import 'package:macidp/macidp/shared/network/local/cache_helper.dart';
import 'package:html/parser.dart' show parse;
import 'package:macidp/main.dart';

import 'app_states.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialStates());

  static AppCubit get(context) => BlocProvider.of(context);

  bool isDark = false;

  List<Widget> screens = [
    IDPScreen(),
    TriptickScreen(),
    CartScreen(),
    NewUserScreen(),
  ];

  UserModel? userModel;

  void getUserData() {
    emit(AppGetUserLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .get()
        .then((value) async {
      print(value.data());
      userModel = UserModel.fromJson(value.data());
      await getMyLicenses();
      emit(AppGetUserSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(AppGetUserErrorState());
    });
  }

  int currentIndex = 0;

  void changeBottom(int index, context) {
    currentIndex = index;
    if (index == 2) {
      getCartItems(context);
    }
    emit(AppChangeScreenState());
  }

  loading() {
    emit(AppLoadingState());
  }

  List<Products> products = [];
  Future<List<Products>> getProducts(context) async {
    products = [];
    idpProducts = [];
    triptickProducts = [];
    emit(AppLoadingHomeDataState());
    if (MyApp.of(context)!.getLocale().languageCode == "ar") {
      try {
        String url = Config.url +
            Config.productsUrl +
            "?consumer_key=${Config.key}&consumer_secret=${Config.secret}";
        var response = await Dio().get(url,
            options: Options(
                headers: {HttpHeaders.contentTypeHeader: "application/json"}));
        if (response.statusCode == 200) {
          products =
              (response.data as List).map((e) => Products.fromJson(e)).toList();
          seperateProducts(context);
          print(response.data);
          emit(AppSuccessHomeDataState());
        }
      } on DioError catch (e) {
        print(e.response);
      }
    } else {
      try {
        String url = Config.englishUrl +
            Config.productsUrl +
            "?consumer_key=${Config.key}&consumer_secret=${Config.secret}";
        var response = await Dio().get(url,
            options: Options(
                headers: {HttpHeaders.contentTypeHeader: "application/json"}));
        if (response.statusCode == 200) {
          products =
              (response.data as List).map((e) => Products.fromJson(e)).toList();
          seperateProducts(context);
          print(response.data);
          emit(AppSuccessHomeDataState());
        }
      } on DioError catch (e) {
        print(e.response);
      }
    }

    // print(data[4].images[0].src);
    return products;
  }

  List<Products> idpProducts = [];
  List<Products> triptickProducts = [];

  void seperateProducts(context) {
    products.forEach((element) {
      if (element.categories[0].name == 'idl') {
        idpProducts.add(element);
        print("idpProducts++++++++++++++++++++++++++");
        print(element.price);
      } else if (element.categories[0].name == 'triptik') {
        triptickProducts.add(element);
      }
    });
  }

  void sortIdpProducts(context) {
    idpProducts.sort((a, b) => 200.compareTo(b.price!));
  }

  String? dropdNationality = "اختر الجنسية";

  var nationality = [
    "اختر الجنسية",
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

  String? dropdDriving = "اختر دولة مصدر القيادة المحلية";

  var driving = [
    "اختر دولة مصدر القيادة المحلية",
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

  String? signCountryDrop = "بلد التسجيل";

  var signCountry = [
    "بلد التسجيل",
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

  String? dropdYourCountry = "اختر الدولة";

  var yourCountry = [
    "اختر الدولة",
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

  String? dropBlood = "اختر فصيلة الدم";

  var bloods = [
    "اختر فصيلة الدم",
    "A-",
    "A+",
    "B-",
    "B+",
    "AB-",
    "AB+",
    "O-",
    "O+",
  ];

  String? dropBranch = "فرع جدة";

  var branch = [
    "فرع جدة",
    "فرع الدمام",
    "فرع البطحاء",
    "فرع السليمانية",
  ];

  String? dropdPanelType = "اختر نوع اللوحة";

  var panelTypes = [
    "اختر نوع اللوحة",
    "تجاري",
    "شخصي",
  ];
  changeDropdownPanelType(String? newValue) {
    dropdPanelType = newValue;
    emit(AppChangeDropdown());
  }

  String? dropdCarType = "sedan";

  var carTypes = [
    "sedan",
    "station1",
    "station",
    "jeep",
    "Saloon",
    "Saloon Box",
    "Jeep Box",
    "Pickup",
    "Trilla",
    "Ras",
    "refrigerator",
    "motor cycle",
    "Van",
    "Coupe",
    "SPORT",
  ];
  changeDropdownCarType(String? newValue) {
    dropdCarType = newValue;
    emit(AppChangeDropdown());
  }

  String? dropdCarColor = "Red";

  var CarColors = [
    "Red",
    "Blue",
    "Green",
    "Yellow",
    "Purple",
    "Orange",
    "Pink",
    "Brown",
    "Black",
    "White",
    "Gray",
    "Cyan",
    "Magenta",
    "Lime",
    "Teal",
    "Indigo",
    "Maroon",
    "Navy",
    "Olive",
    "Aquamarine",
    "Turquoise",
    "Silver",
    "Gold",
    "Violet",
    "Beige",
    "Tan",
    "Coral",
    "Salmon",
    "Lavender",
    "Periwinkle",
    "Mauve",
    "Crimson",
    "Azure",
    "Chartreuse",
    "Plum",
    "Slate",
    "Sienna",
    "Khaki",
    "Mint",
    "Tangerine",
    "Aqua",
    "Steel",
    "Orchid",
    "Tomato",
    "Raspberry",
    "Moccasin",
    "Honeydew",
    "Peach",
    "Turquoise"
  ];
  changeDropdownCarColor(String? newValue) {
    dropdCarColor = newValue;
    emit(AppChangeDropdown());
  }

  changeDropdownNationality(String? newValue) {
    dropdNationality = newValue;
    emit(AppChangeDropdown());
  }

  changeDropdownDriving(String? newValue) {
    dropdDriving = newValue;
    emit(AppChangeDropdown());
  }

  changeDropdownCountry(String? newValue) {
    dropdCountry = newValue;
    emit(AppChangeDropdown());
  }

  changeDropdownSignCountry(String? newValue) {
    signCountryDrop = newValue;
    emit(AppChangeDropdown());
  }

  changeDropdownYourCountry(String? newValue) {
    dropdYourCountry = newValue;
    emit(AppChangeDropdown());
  }

  changeDropdownBranch(String? newValue) {
    dropBranch = newValue;
    emit(AppChangeDropdown());
  }

  changeDropdownBlood(String? newValue) {
    dropBlood = newValue;
    emit(AppChangeDropdown());
  }

  DateTime birthDate = DateTime.now();
  changeBirthdate(DateTime? newValue) {
    birthDate = newValue!;
    emit(AppChangeDropdown());
  }

  DateTime vehicleLicenseExpiryDate = DateTime.now();
  changeVehicleLicenseExpiryDate(DateTime? newValue) {
    vehicleLicenseExpiryDate = newValue!;
    emit(AppChangeDropdown());
  }

  DateTime vehicleManufactureDate = DateTime.now();
  changeVehicleManufactureDate(DateTime? newValue) {
    vehicleManufactureDate = newValue!;
    emit(AppChangeDropdown());
  }

  changeRadio() {
    emit(AppChangeRadioState());
  }

  changeCheckBox() {
    emit(AppChangeCheckBoxState());
  }

  bool isAir = false;
  bool isRadio = false;
  changeAirRadioCheckBox() {
    emit(AppChangeCheckBoxState());
  }

  String wheels = "0";
  changeWheelRadio() {
    emit(AppChangeRadioState());
  }

  String material = "fabric";
  changeMaterialRadio() {
    emit(AppChangeRadioState());
  }

  dynamic profileImage;
  var picker1 = ImagePicker();

  Future<void> getProfileImage() async {
    final pickedFile = await picker1.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(AppPassportPickedSuccessState());
    } else {
      print('No image selected');
      emit(AppPassportPickedErrorState());
    }
  }

  dynamic licenceImage;
  var picker2 = ImagePicker();

  Future<void> getLicenceImage() async {
    final pickedFile = await picker3.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      licenceImage = File(pickedFile.path);
      emit(AppPassportPickedSuccessState());
    } else {
      print('No image selected');
      emit(AppPassportPickedErrorState());
    }
  }

  dynamic passportImage;
  var picker3 = ImagePicker();

  Future<void> getPassportImage() async {
    final pickedFile = await picker2.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      passportImage = File(pickedFile.path);
      emit(AppPassportPickedSuccessState());
    } else {
      print('No image selected');
      emit(AppPassportPickedErrorState());
    }
  }

  dynamic carCopyImage;
  var picker11 = ImagePicker();

  Future<void> getCarCopyImage() async {
    final pickedFile = await picker11.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      carCopyImage = File(pickedFile.path);
      emit(AppPassportPickedSuccessState());
    } else {
      print('No image selected');
      emit(AppPassportPickedErrorState());
    }
  }

  dynamic localIdImage;
  var picker33 = ImagePicker();

  Future<void> getlocalIdImage() async {
    final pickedFile = await picker33.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      localIdImage = File(pickedFile.path);
      emit(AppPassportPickedSuccessState());
    } else {
      print('No image selected');
      emit(AppPassportPickedErrorState());
    }
  }

  late FlutterHyperPay flutterHyperPay;
  setupPayment() {
    flutterHyperPay = FlutterHyperPay(
      shopperResultUrl:
          InAppPaymentSetting.shopperResultUrl, // return back to app
      paymentMode: PaymentMode.live, // test or live
      lang: InAppPaymentSetting.getLang(),
    );
  }

  payRequestNowReadyUI({
    required List<String> brandsName,
    required String checkoutId,
    required BuildContext context,
    required Products product,
    required String productType,
    required String? fullName,
    required String? nationalityCountry,

    //license
    int? gender,
    DateTime? birthDate,
    int? bloodType,
    int? licenseDuration,
    int? licenseType,
    String? passportTextId,
    String? sourceOfLocalLicenseCountry,
    File? personalPhoto,
    File? localDrivingLicense,
    File? passport,

    //triptick
    String? residenceCountry,
    String? governmentalId,
    String? passportId,
    String? address1,
    String? address2,
    String? phoneNumber1,
    String? phoneNumber2,
    int? extraDriversCount,
    String? vehicleRegistrationCountry,
    String? vehicleNumber,
    int? vehicleLicenseType,
    DateTime? vehicleLicenseExpiryDate,
    String? vehicleBrand,
    String? vehicleModel,
    int? vehicleTypeId,
    int? vehiclePassengersCount,
    DateTime? vehicleManufactureDate,
    int? vehicleWeight,
    int? slenderType,
    int? horsePower,
    String? vehicleColor,
    int? upholsteryType,
    String? vehicleEngineId,
    String? vehicleCoverId,
    bool? airConditionerAvailable,
    bool? radioAvailable,
    int? spareTiresNumber,
    String? equipment,
    String? plugins,
    int? vehiclePrice,
    File? vehicleRegistrationCopyDocument,
    File? passportDocument,
    File? personalGovernmentalIdentityDocument,
  }) async {
    setupPayment();
    PaymentResultData paymentResultData;
    paymentResultData = await flutterHyperPay.readyUICards(
      readyUI: ReadyUI(
          brandsName: ["VISA", "MASTER", "MADA", "STC_PAY", "APPLEPAY"],
          checkoutId: checkoutId,
          merchantIdApplePayIOS: InAppPaymentSetting.merchantId, // applepay
          countryCodeApplePayIOS: InAppPaymentSetting.countryCode, // applePay
          companyNameApplePayIOS: "Test Co", // applePay
          themColorHexIOS: "#000000", // FOR IOS ONLY
          setStorePaymentDetailsMode:
              true // store payment details for future use
          ),
    );
    // print(paymentResultData.paymentResult.name);
    if (paymentResultData.paymentResult == PaymentResult.success) {
      addToCart("${product.id!}");
      if (productType == "license") {
        orderLicense(
                context,
                fullName!,
                gender!,
                birthDate!,
                bloodType!,
                licenseDuration!,
                licenseType!,
                passportTextId!,
                nationalityCountry!,
                sourceOfLocalLicenseCountry!,
                personalPhoto!,
                localDrivingLicense!,
                passport!,
                true)
            .then((value) {
          navigateAndFinish(context, ShopLayout());
          showToast(text: "تم ارسال طلبك بنجاح!", state: ToastStates.SUCCESS);
        });
      } else if (productType == "triptick") {
        orderTriptick(
          context,
          fullName!,
          residenceCountry!,
          nationalityCountry!,
          governmentalId!,
          passportId!,
          address1!,
          address2!,
          phoneNumber1!,
          phoneNumber2!,
          extraDriversCount!,
          vehicleRegistrationCountry!,
          vehicleNumber!,
          vehicleLicenseType!,
          vehicleLicenseExpiryDate!,
          vehicleBrand!,
          vehicleModel!,
          vehicleTypeId!,
          vehiclePassengersCount!,
          vehicleManufactureDate!,
          vehicleWeight!,
          slenderType!,
          horsePower!,
          vehicleColor!,
          upholsteryType!,
          vehicleEngineId!,
          vehicleCoverId!,
          airConditionerAvailable!,
          radioAvailable!,
          spareTiresNumber!,
          equipment!,
          plugins!,
          vehiclePrice!,
          vehicleRegistrationCopyDocument!,
          passportDocument!,
          personalGovernmentalIdentityDocument!,
          true,
        ).then((value) {
          navigateAndFinish(context, ShopLayout());
          showToast(text: "تم ارسال طلبك بنجاح!", state: ToastStates.SUCCESS);
        });
      }
    } else if (paymentResultData.paymentResult == PaymentResult.noResult) {
      showToast(text: "تم الغاء العملية", state: ToastStates.WARNING);
      addToCart("${product.id!}");
    } else if (paymentResultData.paymentResult == PaymentResult.error) {
      showToast(
          text: "حدث خطأ ما برجاء المحاولة لاحقا", state: ToastStates.ERROR);
      addToCart("${product.id!}");
    } else if (paymentResultData.paymentResult == PaymentResult.sync) {
      addToCart("${product.id!}");
      if (productType == "license") {
        orderLicense(
                context,
                fullName!,
                gender!,
                birthDate!,
                bloodType!,
                licenseDuration!,
                licenseType!,
                passportTextId!,
                nationalityCountry!,
                sourceOfLocalLicenseCountry!,
                personalPhoto!,
                localDrivingLicense!,
                passport!,
                false)
            .then((value) {
          navigateAndFinish(context, ShopLayout());
          showToast(
              text: "طلب الرخصة قيد المراجعة", state: ToastStates.WARNING);
        });
      } else if (productType == "triptick") {
        orderTriptick(
          context,
          fullName!,
          residenceCountry!,
          nationalityCountry!,
          governmentalId!,
          passportId!,
          address1!,
          address2!,
          phoneNumber1!,
          phoneNumber2!,
          extraDriversCount!,
          vehicleRegistrationCountry!,
          vehicleNumber!,
          vehicleLicenseType!,
          vehicleLicenseExpiryDate!,
          vehicleBrand!,
          vehicleModel!,
          vehicleTypeId!,
          vehiclePassengersCount!,
          vehicleManufactureDate!,
          vehicleWeight!,
          slenderType!,
          horsePower!,
          vehicleColor!,
          upholsteryType!,
          vehicleEngineId!,
          vehicleCoverId!,
          airConditionerAvailable!,
          radioAvailable!,
          spareTiresNumber!,
          equipment!,
          plugins!,
          vehiclePrice!,
          vehicleRegistrationCopyDocument!,
          passportDocument!,
          personalGovernmentalIdentityDocument!,
          false,
        ).then((value) {
          navigateAndFinish(context, ShopLayout());
          showToast(
              text: "طلب التريبتيك قيد المراجعة", state: ToastStates.WARNING);
        });
      }
    }
    print(paymentResultData.paymentResult);
  }

  // getCheckOut(context, Products product) async {
  // final url =
  //     Uri.parse('https://dev.hyperpay.com/hyperpay-demo/getcheckoutid.php');
  // final response = await http.get(url);
  // if (response.statusCode == 200) {
  //   print(response.body);
  //   print("Status code" + "${response.statusCode}");
  // payRequestNowReadyUI(
  //     //Todo
  //     checkoutId: "DF44F4BDF0DDAAECB7D08A69D6F4581D.prod02-vm-tx13",
  //     brandsName: ["VISA", "MASTER", "MADA", "PAYPAL", "STC_PAY", "APPLEPAY"],
  //     context: context);
  // }
  // else {

  // print(response.body.toString());
  // addToCart(product).then((value) {
  // CacheHelper.removeData(key: 'cart').then((value) {
  //   CacheHelper.saveData(key: 'cart', list: cart).then((value) {
  // ShopCubit.get(context).cart = CacheHelper.getData(key: 'cart');
  //   getCart(context);
  //   print(cart);
  //   print("+++++++++++++++++++++++++++++++");
  // });
  //   });
  // });

  // }
  // }

  Future<void> makeLicenseCheckoutsRequest(
    Products product,
    BuildContext context,
    String fullName,
    int gender,
    DateTime birthDate,
    int bloodType,
    int licenseDuration,
    int licenseType,
    String passportTextId,
    String nationalityCountry,
    String sourceOfLocalLicenseCountry,
    File personalPhoto,
    File localDrivingLicense,
    File passport,
  ) async {
    String url = 'https://oppwa.com//v1/checkouts';
    String authorization =
        'Bearer OGFjZGE0Yzg4MzNiMmNlOTAxODMzYjg2YjMwMDA2Zjh8d0VOcWtKOTlTbQ==';

    Map<String, String> headers = {
      'Authorization': authorization,
      'Content-Type': 'application/x-www-form-urlencoded',
    };

    Map<String, String> body = {
      'entityId': '8acda4c8833b2ce901833b877605070a',
      'amount':
          "${int.parse(product.price) - (int.parse(product.price) * dis) / 100}",
      'currency': 'SAR',
      'paymentType': 'DB',
    };

    try {
      var response =
          await http.post(Uri.parse(url), headers: headers, body: body);

      if (response.statusCode == 200) {
        print('Request successful: ${response.body}');
        payRequestNowReadyUI(
          checkoutId: json.decode(response.body)['id'],
          brandsName: [
            "VISA",
            "MASTER",
            "MADA",
            "PAYPAL",
            "STC_PAY",
            "APPLEPAY"
          ],
          productType: "license",
          context: context,
          product: product,
          fullName: fullName,
          gender: gender,
          birthDate: birthDate,
          bloodType: bloodType,
          licenseDuration: licenseDuration,
          licenseType: licenseType,
          passportTextId: passportTextId,
          nationalityCountry: nationalityCountry,
          sourceOfLocalLicenseCountry: sourceOfLocalLicenseCountry,
          personalPhoto: personalPhoto,
          localDrivingLicense: localDrivingLicense,
          passport: passport,
        );

        getPaymentStatus(json.decode(response.body)['id']);
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception: $e');
    }
  }

  Future<void> makeTriptickCheckoutsRequest(
    Products product,
    BuildContext context,
    String fullName,
    String residenceCountry,
    String nationalityCountry,
    String governmentalId,
    String passportId,
    String address1,
    String address2,
    String phoneNumber1,
    String phoneNumber2,
    int extraDriversCount,
    String vehicleRegistrationCountry,
    String vehicleNumber,
    int vehicleLicenseType,
    DateTime vehicleLicenseExpiryDate,
    String vehicleBrand,
    String vehicleModel,
    int vehicleTypeId,
    int vehiclePassengersCount,
    DateTime vehicleManufactureDate,
    int vehicleWeight,
    int slenderType,
    int horsePower,
    String vehicleColor,
    int upholsteryType,
    String vehicleEngineId,
    String vehicleCoverId,
    bool airConditionerAvailable,
    bool radioAvailable,
    int spareTiresNumber,
    String equipment,
    String plugins,
    int vehiclePrice,
    File vehicleRegistrationCopyDocument,
    File passportDocument,
    File personalGovernmentalIdentityDocument,
  ) async {
    String url = 'https://oppwa.com//v1/checkouts';
    String authorization =
        'Bearer OGFjZGE0Yzg4MzNiMmNlOTAxODMzYjg2YjMwMDA2Zjh8d0VOcWtKOTlTbQ==';

    Map<String, String> headers = {
      'Authorization': authorization,
      'Content-Type': 'application/x-www-form-urlencoded',
    };

    Map<String, String> body = {
      'entityId': '8acda4c8833b2ce901833b877605070a',
      'amount':
          "${int.parse(product.price) - (int.parse(product.price) * dis) / 100}",
      'currency': 'SAR',
      'paymentType': 'DB',
    };

    try {
      var response =
          await http.post(Uri.parse(url), headers: headers, body: body);

      if (response.statusCode == 200) {
        print('Request successful: ${response.body}');
        payRequestNowReadyUI(
          checkoutId: json.decode(response.body)['id'],
          brandsName: ["VISA", "MASTER", "MADA", "STC_PAY", "APPLEPAY"],
          context: context,
          product: product,
          productType: "triptick",
          fullName: fullName,
          nationalityCountry: nationalityCountry,
          residenceCountry: residenceCountry,
          governmentalId: governmentalId,
          passportId: passportId,
          address1: address1,
          address2: address2,
          phoneNumber1: phoneNumber1,
          phoneNumber2: phoneNumber2,
          extraDriversCount: 0,
          vehicleRegistrationCountry: vehicleRegistrationCountry,
          vehicleNumber: vehicleNumber,
          vehicleLicenseType: vehicleLicenseType,
          vehicleLicenseExpiryDate: vehicleLicenseExpiryDate,
          vehicleBrand: vehicleBrand,
          vehicleModel: vehicleModel,
          vehicleTypeId: vehicleTypeId,
          vehiclePassengersCount: vehiclePassengersCount,
          vehicleManufactureDate: vehicleManufactureDate,
          vehicleWeight: vehicleWeight,
          slenderType: slenderType,
          horsePower: horsePower,
          vehicleColor: vehicleColor,
          upholsteryType: upholsteryType,
          vehicleEngineId: vehicleEngineId,
          vehicleCoverId: vehicleCoverId,
          airConditionerAvailable: airConditionerAvailable,
          radioAvailable: radioAvailable,
          spareTiresNumber: spareTiresNumber,
          equipment: equipment,
          plugins: plugins,
          vehiclePrice: vehiclePrice,
          vehicleRegistrationCopyDocument: vehicleRegistrationCopyDocument,
          passportDocument: passportDocument,
          personalGovernmentalIdentityDocument:
              personalGovernmentalIdentityDocument,
        );

        getPaymentStatus(json.decode(response.body)['id']);
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception: $e');
    }
  }

  void getPaymentStatus(String id) async {
    String url =
        'https://oppwa.com//v1/checkouts/$id/payment?entityId=8acda4c8833b2ce901833b877605070a';
    String authorization =
        'Bearer OOGFjZGE0Yzg4MzNiMmNlOTAxODMzYjg2YjMwMDA2Zjh8d0VOcWtKOTlTbQ==';

    Map<String, String> headers = {
      'Authorization': authorization,
    };

    try {
      var response = await http.get(Uri.parse(url), headers: headers);

      if (response.statusCode == 200) {
        print('Payment status get success: ${response.body}');
      } else {
        print('Payment status faild: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception: $e');
    }
  }

  List<String>? cart = [];
  dynamic cartCache = [];
  Future<void> addToCart(String productId) async {
    print(productId);
    cart!.add(productId);
    showToast(text: "تمت الاضافة الى العربة", state: ToastStates.SUCCESS);
    emit(AppAddToCart());
  }

  Future getCart(context) async {
    try {
      showDialog(
          context: context,
          builder: (_) => Container(
                child: Center(
                  child: Lottie.asset(
                    'assets/lotties/loading.json',
                  ),
                ),
              ));
      cartCache = CacheHelper.getData(key: 'cart');
      for (int i = 0; i < cartCache!.length; i++) {
        cart!.add(cartCache![i]);
        print(cart);
        print("--------------------------");
      }
    } catch (e) {
      print(e);
    }
  }

  List<Products> cartItems = [];
  Future getCartItems(context) async {
    emit(AppLoadingGetCart());
    cartItems = [];
    for (int i = 0; i < cart!.length; i++) {
      try {
        showDialog(
            context: context,
            builder: (_) => Container(
                  child: Center(
                    child: Lottie.asset(
                      'assets/lotties/loading.json',
                    ),
                  ),
                ));
        String url = Config.url +
            Config.productsUrl +
            "/${cart![i]}" +
            "?consumer_key=${Config.key}&consumer_secret=${Config.secret}";
        var response = await Dio().get(url,
            options: Options(
                headers: {HttpHeaders.contentTypeHeader: "application/json"}));
        if (response.statusCode == 200) {
          cartItems.add(Products.fromJson(response.data));
          print(cartItems[i].name);
          Navigator.pop(context);
        }
      } on DioError catch (e) {
        print(e.response);
      }
    }
    getCartAmount();
    emit(AppSuccessGetCart());
  }

  double totalPrice = 0;
  getCartAmount() {
    totalPrice = 0;
    for (int i = 0; i < cartItems.length; i++) {
      totalPrice = totalPrice + double.parse("${cartItems[i].price!}");
    }
  }

  Future removeCart(Products product) async {
    print(product.id);
    cart!.remove("${product.id}");
    print(cart);
    print("remove from cart");
    showToast(text: "تمت الازالة من العربة", state: ToastStates.SUCCESS);
    emit(AppRemoveFromCart());
  }

  Products? product;
  Future getOneProduct(context, Products product) async {
    emit(AppLoadingGetOneProduct());
    try {
      showDialog(
          context: context,
          builder: (_) => Container(
                child: Center(
                  child: Lottie.asset(
                    'assets/lotties/loading.json',
                  ),
                ),
              ));
      String url = Config.url +
          Config.productsUrl +
          "/${product.id}" +
          "?consumer_key=${Config.key}&consumer_secret=${Config.secret}";
      var response = await Dio().get(url,
          options: Options(
              headers: {HttpHeaders.contentTypeHeader: "application/json"}));
      if (response.statusCode == 200) {
        product = Products.fromJson(response.data);
        print(response.data);
        emit(AppSuccessGetOneProduct());
      }
    } on DioError catch (e) {
      print(e.response);
      emit(AppErrorGetOneProduct());
    }
    return product;
  }

  Future orderLicense(
    context,
    String fullName,
    int gender,
    DateTime birthDate,
    int bloodType,
    int licenseDuration,
    int licenseType,
    String passportTextId,
    String nationalityCountry,
    String sourceOfLocalLicenseCountry,
    File personalPhoto,
    File localDrivingLicense,
    File passport,
    bool isPaid,
  ) async {
    print("Start Order License");
    emit(AppLoadingOrderLicense());
    var formData = FormData.fromMap({
      "FullName": fullName,
      "Gander": gender,
      "BirthDate": birthDate,
      "BloodType": bloodType,
      "LicenseDuration": licenseDuration,
      "LicenseType": licenseType,
      "PassportTextId": passportTextId,
      "NationalityCountry": nationalityCountry,
      "SourceOfLocalLicenseCountry": sourceOfLocalLicenseCountry,
      "PersonalPhoto": await MultipartFile.fromFile(
        profileImage.path,
        filename: profileImage.path.split('/').last,
      ),
      "LocalDrivingLicense": await MultipartFile.fromFile(
        licenceImage.path,
        filename: licenceImage.path.split('/').last,
      ),
      "Passport": await MultipartFile.fromFile(
        passportImage.path,
        filename: passportImage.path.split('/').last,
      ),
      "ExternalUserId": userModel!.uId,
      "IsPaid": isPaid,
    });
    try {
      String url = Config.orderUrl + "License";
      var response = await Dio().post(url,
          data: formData,
          options: Options(
              headers: {HttpHeaders.contentTypeHeader: "application/json"}));
      if (response.statusCode == 200) {
        print(response.data);
        emit(AppSuccessOrderLicense());
      }
    } on DioError catch (e) {
      print(e);
      emit(AppErrorOrderLicense());
    }
  }

  Future orderTriptick(
    context,
    String fullName,
    String residenceCountry,
    String nationalityCountry,
    String governmentalId,
    String passportId,
    String address1,
    String address2,
    String phoneNumber1,
    String phoneNumber2,
    int extraDriversCount,
    String vehicleRegistrationCountry,
    String vehicleNumber,
    int vehicleLicenseType,
    DateTime vehicleLicenseExpiryDate,
    String vehicleBrand,
    String vehicleModel,
    int vehicleTypeId,
    int vehiclePassengersCount,
    DateTime vehicleManufactureDate,
    int vehicleWeight,
    int slenderType,
    int horsePower,
    String vehicleColor,
    int upholsteryType,
    String vehicleEngineId,
    String vehicleCoverId,
    bool airConditionerAvailable,
    bool radioAvailable,
    int spareTiresNumber,
    String equipment,
    String plugins,
    int vehiclePrice,
    // int currencyType,
    File vehicleRegistrationCopyDocument,
    File passportDocument,
    File personalGovernmentalIdentityDocument,
    bool isPaid,
  ) async {
    print("Start Order License");
    emit(AppLoadingOrderTriptick());
    var formData = FormData.fromMap({
      "FullName": fullName, //1
      "ResidenceCountry": residenceCountry, //2
      "NationalityCountry": nationalityCountry, //3
      "GovernmentalId": governmentalId, //4
      "PassportId": passportId, //5
      "Address1": address1, //6
      "Address2": address2, //7
      "PhoneNumber1": phoneNumber1, //8
      "PhoneNumber2": phoneNumber2, //9
      "ExtraDriversCount": 0, //10
      "VehicleRegistrationCountry": vehicleRegistrationCountry, //11
      "VehicleNumber": vehicleNumber, //12
      "VehicleLicenseType": vehicleLicenseType, //13
      "VehicleLicenseExpiryDate": vehicleLicenseExpiryDate, //14
      "VehicleBrand": vehicleBrand, //15
      "VehicleModel": vehicleModel, //16
      "VehicleTypeId": vehicleTypeId, //17
      "VehiclePassengersCount": vehiclePassengersCount, //18
      "VehicleManufactureDate": vehicleManufactureDate, //19
      "VehicleWeight": vehicleWeight, //20
      "SlenderType": slenderType, //21
      "HorsePower": horsePower, //22
      "VehicleColor": vehicleColor, //23
      "UpholsteryType": upholsteryType, //24
      "VehicleEngineId": vehicleEngineId, //25
      "VehicleCoverId": vehicleCoverId, //26
      "AirConditionerAvailable": true, //27 problem
      "RadioAvailable": true, //28 problem
      "SpareTiresNumber": spareTiresNumber, //29
      "Equipment": equipment, //30
      "Plugins": plugins, //31
      "VehiclePrice": vehiclePrice, //32
      "CurrencyType": 0, //33
      "VehicleRegistrationCopyDocument": await MultipartFile.fromFile(
        //34
        carCopyImage.path,
        filename: carCopyImage.path.split('/').last,
      ),
      "PassportDocument": await MultipartFile.fromFile(
        //35
        passportImage.path,
        filename: passportImage.path.split('/').last,
      ),
      "PersonalGovernmentalIdentityDocument": await MultipartFile.fromFile(
        //36
        localIdImage.path,
        filename: localIdImage.path.split('/').last,
      ),
      "ExternalUserId": userModel!.uId, //37
      "IsPaid": isPaid, //38
    });
    try {
      String url = Config.orderUrl + "TripTick";
      var response = await Dio().post(url,
          data: formData,
          options: Options(
              headers: {HttpHeaders.contentTypeHeader: "application/json"}));
      if (response.statusCode == 200) {
        print(response.data);
        emit(AppSuccessOrderTriptick());
      } else {
        print(response.data);
      }
    } on DioError catch (e) {
      print(e);
      emit(AppErrorOrderTriptick());
    }
  }

  List<String> extractTextFromLiElements(String html) {
    List<String> textList = [];
    var document = parse(html);
    var liElements = document.querySelectorAll('li');

    liElements.forEach((li) {
      textList.add(li.text.trim());
    });

    return textList;
  }

// coupons
  List coupons = [];
  int dis = 0;
  bool copExist = false;
  getCoupon(String coupon) {
    copExist = false;
    coupons = [];
    emit(AppCouponLoadingState());
    FirebaseFirestore.instance.collection("coupons").get().then((value) {
      value.docs.forEach((element) {
        if (element.id == coupon) {
          emit(AppCouponDoneState());
          showToast(text: "Coupon Done", state: ToastStates.SUCCESS);
          dis = int.parse(element.data()["discount"]);
          copExist = true;
        } else {
          emit(AppCouponErrorState());
          showToast(text: "not exist", state: ToastStates.ERROR);
        }
      });
    });
    print(dis);
    print("==========================================================");
  }

  // get issued lisences from firebase
  List<String> myLicenses = [];
  Future getMyLicenses() async {
    myLicenses = [];
    emit(AppGetMyLicensesLoadingState());
    try {
      FirebaseFirestore.instance
          .collection("issued")
          .doc("${userModel!.uId}")
          .get()
          .then((value) {
        if (value.data() != null) {
          value.data()!.forEach((key, value) {
            myLicenses.add("$value");
            print(key);
            print(value);
            emit(AppGetMyLicensesDoneState());
          });
        } else {
          emit(AppGetMyLicensesErrorState());
        }
      });
    } catch (e) {
      emit(AppGetMyLicensesErrorState());
    }
  }

  int initShipping = 0;
  void changeInitShipping(int shipping) {
    initShipping = shipping;
    emit(AppchangeInitShipping());
  }
}
