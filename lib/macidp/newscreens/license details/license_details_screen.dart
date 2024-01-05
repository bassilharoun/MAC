import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:macidp/macidp/app_cubit/app_cubit.dart';
import 'package:macidp/macidp/app_cubit/app_states.dart';
import 'package:macidp/macidp/models/products_model.dart';
import 'package:macidp/macidp/shared/colors.dart';
import 'package:macidp/macidp/shared/components/applocale.dart';
import 'package:macidp/macidp/shared/components/components.dart';
import 'package:macidp/macidp/shared/validators.dart';
import 'package:macidp/main.dart';
import 'package:string_validator/string_validator.dart';

// import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'license_app_theme.dart';

class CourseInfoScreen extends StatefulWidget {
  final index;
  final Products product;
  CourseInfoScreen(this.index, this.product);
  @override
  _CourseInfoScreenState createState() => _CourseInfoScreenState();
}

class _CourseInfoScreenState extends State<CourseInfoScreen>
    with TickerProviderStateMixin {
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var oneController = TextEditingController();
  var towController = TextEditingController();
  var threeController = TextEditingController();
  var fourController = TextEditingController();
  var fiveController = TextEditingController();
  var passportController = TextEditingController();
  var couponController = TextEditingController();
  bool isChecked = false;
  bool agreeTerms = false;
  String gender = 'male';

  String? country;

  List<String> categories = [
    "Motorcycle",
    "Car",
    "Over 7000 lbs",
    "Over 8 seats",
  ];

  List<String> shipping = [
    "Shipping",
    "Branch",
  ];
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  int initCategory = 0;

  @override
  Widget build(BuildContext context) {
    var cubit = AppCubit.get(context);
    bool validateToOrder() {
      var cubit = AppCubit.get(context);
      if (cubit.dropBlood != "اختر فصيلة الدم" &&
          cubit.dropdCountry != "اختر دولة الاقامة" &&
          cubit.dropdDriving != "اختر دولة مصدر القيادة المحلية" &&
          cubit.dropdNationality != "اختر الجنسية" &&
          cubit.profileImage != null &&
          cubit.passportImage != null &&
          cubit.licenceImage != null) {
        return true;
      } else {
        return false;
      }
    }

    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          key: scaffoldKey,
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: Padding(
            padding: const EdgeInsets.only(left: 16, bottom: 16, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Container(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: (agreeTerms == false ||
                              cubit.dropdCountry == "اختر دولة الاقامة" ||
                              cubit.dropdDriving ==
                                  "اختر دولة مصدر القيادة المحلية" ||
                              cubit.dropdNationality == "اختر الجنسية" ||
                              cubit.profileImage == null ||
                              cubit.passportImage == null ||
                              cubit.licenceImage == null)
                          ? null
                          : () {
                              if (formKey.currentState!.validate()) {
                                // AppCubit.get(context).getCheckOut(context, AppCubit.get(context).products[widget.index]);
                                // scaffoldKey.currentState?.showBottomSheet((context) => Container(
                                //   height: 500,
                                //       child: Column(
                                //         mainAxisAlignment: MainAxisAlignment.center,
                                //           crossAxisAlignment: CrossAxisAlignment.center,
                                //           children: [
                                //         Container(
                                //       height: 130,
                                //       child: Expanded(
                                //         child: GridView.builder(
                                //           gridDelegate:
                                //           SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
                                //           itemBuilder: (context, index) => GestureDetector(
                                //             onTap: (){
                                //               initShipping = index ;
                                //               AppCubit.get(context).changeRadio();
                                //               setState(() {});
                                //             },
                                //             child: Card(
                                //                 elevation: 5,
                                //                 shadowColor: HexColor(license[widget.index].startColor),
                                //                 child: Center(
                                //                   child: Text(
                                //                     "${shipping[index]}",
                                //                     style: TextStyle(fontSize: 16,color: initShipping == index ? Colors.white : Colors.black),
                                //                   ),
                                //                 ),
                                //                 color: initShipping == index ? HexColor(license[widget.index].endColor) : Colors.white
                                //             ),
                                //           ),
                                //           itemCount: 2,
                                //         ),
                                //       ),
                                //         ),
                                //           ]),
                                //     ));

                                showModalBottomSheet(
                                    isScrollControlled: true,
                                    context: context,
                                    builder: (context) {
                                      return Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        AppCubit.get(context)
                                                            .changeInitShipping(
                                                                0);
                                                      },
                                                      child: Container(
                                                        height: 60,
                                                        width: 60,
                                                        child: Card(
                                                            elevation: 5,
                                                            shadowColor:
                                                                buttonsColor,
                                                            child: Center(
                                                              child: Text(
                                                                "${getLang(context, "LICENCE_INFO_SHIPPING")}",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    color: AppCubit.get(context).initShipping ==
                                                                            0
                                                                        ? Colors
                                                                            .white
                                                                        : Colors
                                                                            .black),
                                                              ),
                                                            ),
                                                            color: AppCubit.get(
                                                                            context)
                                                                        .initShipping ==
                                                                    0
                                                                ? buttonsColor
                                                                : Colors.white),
                                                      ),
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        AppCubit.get(context)
                                                            .changeInitShipping(
                                                                1);
                                                      },
                                                      child: Container(
                                                        height: 60,
                                                        width: 60,
                                                        child: Card(
                                                            elevation: 5,
                                                            shadowColor:
                                                                buttonsColor,
                                                            child: Center(
                                                              child: Text(
                                                                "${getLang(context, "LICENCE_INFO_BRANCH")}",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    color: AppCubit.get(context).initShipping ==
                                                                            1
                                                                        ? Colors
                                                                            .white
                                                                        : Colors
                                                                            .black),
                                                              ),
                                                            ),
                                                            color: AppCubit.get(
                                                                            context)
                                                                        .initShipping ==
                                                                    1
                                                                ? buttonsColor
                                                                : Colors.white),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    "${getLang(context, "YOU_WILL_PAY")} ${(int.parse(widget.product.price) - (int.parse(widget.product.price) * AppCubit.get(context).dis) / 100)} ${getLang(context, "SAR")}",
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      showDialog(
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
                                                          return AlertDialog(
                                                            title: Text(
                                                                '${getLang(context, "ENTER_COUPON")}'),
                                                            content: TextField(
                                                              controller:
                                                                  couponController,
                                                              onChanged:
                                                                  (value) {
                                                                // Store your value here
                                                              },
                                                              decoration:
                                                                  InputDecoration(
                                                                      hintText:
                                                                          "${getLang(context, "COUPON")}"),
                                                            ),
                                                            actions: [
                                                              TextButton(
                                                                child: Text(
                                                                    '${getLang(context, "SUBMIT")}'),
                                                                onPressed: () {
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                  AppCubit.get(
                                                                          context)
                                                                      .getCoupon(
                                                                          couponController
                                                                              .text);
                                                                  // Add your submission logic here
                                                                },
                                                              ),
                                                            ],
                                                          );
                                                        },
                                                      );
                                                    },
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              6.0),
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                            "${getLang(context, "COUPON")}",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .green,
                                                                fontSize: 12),
                                                          ),
                                                          Icon(
                                                            Icons.add,
                                                            color: Colors.green,
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 15,
                                              ),
                                              if (AppCubit.get(context)
                                                      .initShipping ==
                                                  0) ...[
                                                Column(
                                                  children: [
                                                    Container(
                                                      width: double.infinity,
                                                      child: DecoratedBox(
                                                        decoration:
                                                            BoxDecoration(
                                                                color: Colors
                                                                    .white, //background color of dropdown button
                                                                border: Border.all(
                                                                    color:
                                                                        buttonsColor,
                                                                    width:
                                                                        1), //border of dropdown button
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10), //border raiuds of dropdown button
                                                                boxShadow: <BoxShadow>[
                                                              //apply shadow on Dropdown button
                                                              BoxShadow(
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          0,
                                                                          0,
                                                                          0,
                                                                          0.57), //shadow for button
                                                                  blurRadius:
                                                                      5) //blur radius of shadow
                                                            ]),
                                                        child: Center(
                                                          child: DropdownButton(
                                                              value: AppCubit.get(
                                                                      context)
                                                                  .dropdYourCountry,
                                                              items: AppCubit.get(
                                                                      context)
                                                                  .yourCountry
                                                                  .map((e) {
                                                                return DropdownMenuItem(
                                                                  value: e,
                                                                  child:
                                                                      Text(e),
                                                                );
                                                              }).toList(),
                                                              onChanged: (String?
                                                                  newValue) {
                                                                AppCubit.get(
                                                                        context)
                                                                    .changeDropdownYourCountry(
                                                                        newValue);
                                                              }),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 15,
                                                    ),
                                                    defaultTxtForm(
                                                        controller:
                                                            oneController,
                                                        type:
                                                            TextInputType.name,
                                                        validate: (value) {
                                                          if (value!.isEmpty) {
                                                            return "";
                                                          }
                                                          return null;
                                                        },
                                                        label:
                                                            "${getLang(context, "LICENCE_INFO_STREET_NAME")}",
                                                        prefix: CupertinoIcons
                                                            .home),
                                                    SizedBox(
                                                      height: 15,
                                                    ),
                                                    defaultTxtForm(
                                                        controller:
                                                            towController,
                                                        type:
                                                            TextInputType.name,
                                                        validate: (value) {
                                                          if (value!.isEmpty) {
                                                            return "";
                                                          }
                                                          return null;
                                                        },
                                                        label:
                                                            "${getLang(context, "LICENCE_INFO_NEIGHBORHOOD")}",
                                                        prefix: CupertinoIcons
                                                            .person_2),
                                                    SizedBox(
                                                      height: 15,
                                                    ),
                                                    defaultTxtForm(
                                                        controller:
                                                            threeController,
                                                        type:
                                                            TextInputType.name,
                                                        validate: (value) {
                                                          if (value!.isEmpty) {
                                                            return "";
                                                          }
                                                          return null;
                                                        },
                                                        label:
                                                            "${getLang(context, "LICENCE_INFO_BUILDING_NUMBER")}",
                                                        prefix: CupertinoIcons
                                                            .building_2_fill),
                                                    SizedBox(
                                                      height: 15,
                                                    ),
                                                    defaultTxtForm(
                                                        controller:
                                                            fourController,
                                                        type:
                                                            TextInputType.name,
                                                        validate: (value) {
                                                          if (value!.isEmpty) {
                                                            return "";
                                                          }
                                                          return null;
                                                        },
                                                        label:
                                                            "${getLang(context, "LICENCE_INFO_POSTAL_CODE")}",
                                                        prefix: Icons
                                                            .inbox_outlined),
                                                    SizedBox(
                                                      height: 15,
                                                    ),
                                                    defaultTxtForm(
                                                        controller:
                                                            fiveController,
                                                        type:
                                                            TextInputType.name,
                                                        validate: (value) {
                                                          if (value!.isEmpty) {
                                                            return "";
                                                          }
                                                          return null;
                                                        },
                                                        label:
                                                            "${getLang(context, "LICENCE_INFO_CITY")}",
                                                        prefix: Icons
                                                            .location_city),
                                                  ],
                                                ),
                                              ],
                                              if (AppCubit.get(context)
                                                      .initShipping ==
                                                  1) ...[
                                                Container(
                                                  width: double.infinity,
                                                  child: DecoratedBox(
                                                    decoration: BoxDecoration(
                                                        color: Colors
                                                            .white, //background color of dropdown button
                                                        border: Border.all(
                                                            color: buttonsColor,
                                                            width:
                                                                1), //border of dropdown button
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                10), //border raiuds of dropdown button
                                                        boxShadow: <BoxShadow>[
                                                          //apply shadow on Dropdown button
                                                          BoxShadow(
                                                              color: Color.fromRGBO(
                                                                  0,
                                                                  0,
                                                                  0,
                                                                  0.57), //shadow for button
                                                              blurRadius:
                                                                  5) //blur radius of shadow
                                                        ]),
                                                    child: Center(
                                                      child: DropdownButton(
                                                          value: AppCubit.get(
                                                                  context)
                                                              .dropBranch,
                                                          items: AppCubit.get(
                                                                  context)
                                                              .branch
                                                              .map((e) {
                                                            return DropdownMenuItem(
                                                              value: e,
                                                              child: Text(e),
                                                            );
                                                          }).toList(),
                                                          onChanged: (String?
                                                              newValue) {
                                                            AppCubit.get(
                                                                    context)
                                                                .changeDropdownBranch(
                                                                    newValue);
                                                          }),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                              SizedBox(
                                                height: 15,
                                              ),
                                              defaultButton(
                                                  function: () {
                                                    // AppCubit.get(context).getCheckOut(
                                                    //     context,
                                                    //     AppCubit.get(context)
                                                    //         .products[widget.index]);
                                                    print(widget.product.name);
                                                    print(widget.product.price);

                                                    AppCubit.get(context)
                                                        .makeLicenseCheckoutsRequest(
                                                            widget.product,
                                                            context,
                                                            nameController.text,
                                                            gender == "male"
                                                                ? 1
                                                                : -1,
                                                            AppCubit.get(
                                                                    context)
                                                                .birthDate,
                                                            AppCubit.get(
                                                                    context)
                                                                .bloods
                                                                .indexOf(AppCubit
                                                                        .get(
                                                                            context)
                                                                    .dropBlood!),
                                                            widget.index + 1,
                                                            initCategory + 1,
                                                            passportController
                                                                .text,
                                                            AppCubit.get(
                                                                    context)
                                                                .dropdNationality!,
                                                            AppCubit.get(
                                                                    context)
                                                                .dropdDriving!,
                                                            AppCubit.get(
                                                                    context)
                                                                .profileImage!,
                                                            AppCubit.get(
                                                                    context)
                                                                .licenceImage!,
                                                            AppCubit.get(
                                                                    context)
                                                                .passportImage!);
                                                    // AppCubit.get(context).orderLicense(
                                                    //     context,
                                                    //     "باسل هارون",
                                                    //     1,
                                                    //     "18, 6, 2002",
                                                    //     4,
                                                    //     1,
                                                    //     1,
                                                    //     "passportTextId",
                                                    //     "nationalityCountry",
                                                    //     "sourceOfLocalLicenseCountry",
                                                    //     AppCubit.get(context)
                                                    //         .profileImage,
                                                    //     AppCubit.get(context)
                                                    //         .licenceImage,
                                                    //     AppCubit.get(context)
                                                    //         .passportImage,
                                                    //     true);
                                                  },
                                                  text:
                                                      "${getLang(context, "LICENCE_INFO_CHECKOUT")}"),
                                            ]),
                                      );
                                    });

                                // showBottomSheet(
                                //     context: context,
                                //     builder: (context) => StatefulBuilder(
                                //           builder: (context, setState) {

                                //           },
                                //         ));
                              }
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: buttonsColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                      ),
                      child: Text(
                        "${getLang(context, "LICENCE_INFO_ORDER_LICENCE")}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          body: SingleChildScrollView(
            child: Container(
              color: buttonsColor,
              child: Column(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      color: LicenseAppTheme.nearlyWhite,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(32.0),
                          topRight: Radius.circular(32.0)),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            color: LicenseAppTheme.grey.withOpacity(0.2),
                            offset: const Offset(1.1, 1.1),
                            blurRadius: 10.0),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8, right: 8),
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(
                                  top: MediaQuery.of(context).padding.top),
                              child: SizedBox(
                                width: AppBar().preferredSize.height,
                                height: AppBar().preferredSize.height,
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(
                                        AppBar().preferredSize.height),
                                    child: Icon(
                                      Icons.arrow_back_ios,
                                      color: LicenseAppTheme.nearlyBlack,
                                    ),
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 18, right: 16),
                              child: Text(
                                "${widget.product.name}",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 22,
                                  letterSpacing: 0.27,
                                  color: LicenseAppTheme.darkerText,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 16, right: 16, top: 16),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    "${int.parse(widget.product.price) - (int.parse(widget.product.price) * AppCubit.get(context).dis) / 100} ${getLang(context, "SAR")}",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w200,
                                      fontSize: 22,
                                      letterSpacing: 0.27,
                                      color: buttonsColor,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Spacer(),
                                  Container(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          '5.0',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w200,
                                            fontSize: 22,
                                            letterSpacing: 0.27,
                                            color: LicenseAppTheme.grey,
                                          ),
                                        ),
                                        Icon(
                                          Icons.star,
                                          color: buttonsColor,
                                          size: 24,
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Form(
                                key: formKey,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    defaultTxtForm(
                                        controller: nameController,
                                        type: TextInputType.name,
                                        onChanged: (txt) {
                                          if (formKey.currentState!
                                              .validate()) {}
                                        },
                                        validate: (value) {
                                          if (value!.isEmpty) {
                                            return "";
                                          }
                                          if (!isEnglish(value)) {
                                            return "Please enter only letters or spaces.";
                                          }
                                          return null;
                                        },
                                        label:
                                            "${getLang(context, "LICENCE_INFO_FULLNAME")}",
                                        prefix: Icons.person_outline),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Text(
                                        "${getLang(context, "LICENCE_INFO_BIRTHDATE")}"),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    //create a date picker
                                    GestureDetector(
                                      onTap: () {
                                        showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime(1900),
                                          lastDate: DateTime.now(),
                                        ).then((value) {
                                          AppCubit.get(context)
                                              .changeBirthdate(value);
                                        });
                                      },
                                      child: Container(
                                        width: double.infinity,
                                        child: DecoratedBox(
                                          decoration: BoxDecoration(
                                              color: Colors
                                                  .white, //background color of dropdown button
                                              border: Border.all(
                                                  color: buttonsColor,
                                                  width:
                                                      1), //border of dropdown button
                                              borderRadius: BorderRadius.circular(
                                                  10), //border raiuds of dropdown button
                                              boxShadow: <BoxShadow>[
                                                //apply shadow on Dropdown button
                                                BoxShadow(
                                                    color: Color.fromRGBO(
                                                        0,
                                                        0,
                                                        0,
                                                        0.57), //shadow for button
                                                    blurRadius:
                                                        5) //blur radius of shadow
                                              ]),
                                          child: Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(16.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                      "${AppCubit.get(context).birthDate}"),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Icon(CupertinoIcons
                                                      .calendar_badge_plus),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Container(
                                      width: double.infinity,
                                      child: DecoratedBox(
                                        decoration: BoxDecoration(
                                            color: Colors
                                                .white, //background color of dropdown button
                                            border: Border.all(
                                                color: buttonsColor,
                                                width:
                                                    1), //border of dropdown button
                                            borderRadius: BorderRadius.circular(
                                                10), //border raiuds of dropdown button
                                            boxShadow: <BoxShadow>[
                                              //apply shadow on Dropdown button
                                              BoxShadow(
                                                  color: Color.fromRGBO(0, 0, 0,
                                                      0.57), //shadow for button
                                                  blurRadius:
                                                      5) //blur radius of shadow
                                            ]),
                                        child: Center(
                                          child: DropdownButton(
                                              value: AppCubit.get(context)
                                                  .dropBlood,
                                              items: AppCubit.get(context)
                                                  .bloods
                                                  .map((e) {
                                                return DropdownMenuItem(
                                                  value: e,
                                                  child: Text(e),
                                                );
                                              }).toList(),
                                              onChanged: (String? newValue) {
                                                AppCubit.get(context)
                                                    .changeDropdownBlood(
                                                        newValue);
                                              }),
                                        ),
                                      ),
                                    ),

                                    SizedBox(
                                      height: 15,
                                    ),
                                    defaultTxtForm(
                                        controller: passportController,
                                        type: TextInputType.text,
                                        onChanged: (txt) {
                                          if (formKey.currentState!
                                              .validate()) {}
                                        },
                                        validate: (value) {
                                          if (value!.isEmpty) {
                                            return "";
                                          }
                                          if (!isAlphanumeric(value)) {
                                            return "Please enter only letters or spaces.";
                                          }
                                          return null;
                                        },
                                        label:
                                            "${getLang(context, "LICENCE_INFO_PASSPORT_NUMBER")}",
                                        prefix: Icons.book_outlined),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Container(
                                      width: double.infinity,
                                      child: DecoratedBox(
                                        decoration: BoxDecoration(
                                            color: Colors
                                                .white, //background color of dropdown button
                                            border: Border.all(
                                                color: buttonsColor,
                                                width:
                                                    1), //border of dropdown button
                                            borderRadius: BorderRadius.circular(
                                                10), //border raiuds of dropdown button
                                            boxShadow: <BoxShadow>[
                                              //apply shadow on Dropdown button
                                              BoxShadow(
                                                  color: Color.fromRGBO(0, 0, 0,
                                                      0.57), //shadow for button
                                                  blurRadius:
                                                      5) //blur radius of shadow
                                            ]),
                                        child: Center(
                                          child: DropdownButton(
                                              value: AppCubit.get(context)
                                                  .dropdNationality,
                                              items: AppCubit.get(context)
                                                  .nationality
                                                  .map((e) {
                                                return DropdownMenuItem(
                                                  value: e,
                                                  child: Text(e),
                                                );
                                              }).toList(),
                                              onChanged: (String? newValue) {
                                                AppCubit.get(context)
                                                    .changeDropdownNationality(
                                                        newValue);
                                              }),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Container(
                                      width: double.infinity,
                                      child: DecoratedBox(
                                        decoration: BoxDecoration(
                                            color: Colors
                                                .white, //background color of dropdown button
                                            border: Border.all(
                                                color: buttonsColor,
                                                width:
                                                    1), //border of dropdown button
                                            borderRadius: BorderRadius.circular(
                                                10), //border raiuds of dropdown button
                                            boxShadow: <BoxShadow>[
                                              //apply shadow on Dropdown button
                                              BoxShadow(
                                                  color: Color.fromRGBO(0, 0, 0,
                                                      0.57), //shadow for button
                                                  blurRadius:
                                                      5) //blur radius of shadow
                                            ]),
                                        child: Center(
                                          child: DropdownButton(
                                              value: AppCubit.get(context)
                                                  .dropdDriving,
                                              items: AppCubit.get(context)
                                                  .driving
                                                  .map((e) {
                                                return DropdownMenuItem(
                                                  value: e,
                                                  child: Text(e),
                                                );
                                              }).toList(),
                                              onChanged: (String? newValue) {
                                                AppCubit.get(context)
                                                    .changeDropdownDriving(
                                                        newValue);
                                              }),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Container(
                                      width: double.infinity,
                                      child: DecoratedBox(
                                        decoration: BoxDecoration(
                                            color: Colors
                                                .white, //background color of dropdown button
                                            border: Border.all(
                                                color: buttonsColor,
                                                width:
                                                    1), //border of dropdown button
                                            borderRadius: BorderRadius.circular(
                                                10), //border raiuds of dropdown button
                                            boxShadow: <BoxShadow>[
                                              //apply shadow on Dropdown button
                                              BoxShadow(
                                                  color: Color.fromRGBO(0, 0, 0,
                                                      0.57), //shadow for button
                                                  blurRadius:
                                                      5) //blur radius of shadow
                                            ]),
                                        child: Center(
                                          child: DropdownButton(
                                              value: AppCubit.get(context)
                                                  .dropdCountry,
                                              items: AppCubit.get(context)
                                                  .country
                                                  .map((e) {
                                                return DropdownMenuItem(
                                                  value: e,
                                                  child: Text(e),
                                                );
                                              }).toList(),
                                              onChanged: (String? newValue) {
                                                AppCubit.get(context)
                                                    .changeDropdownCountry(
                                                        newValue);
                                              }),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    // Ok
                                    Row(
                                      children: [
                                        Expanded(
                                          child: RadioListTile(
                                              activeColor: buttonsColor,
                                              title: Text(
                                                  "${getLang(context, "LICENCE_INFO_MALE")}"),
                                              value: "male",
                                              groupValue: gender,
                                              onChanged: (value) {
                                                gender = value.toString();
                                                print(gender);
                                                AppCubit.get(context)
                                                    .changeRadio();
                                              }),
                                        ),
                                        Expanded(
                                          child: RadioListTile(
                                              activeColor: buttonsColor,
                                              title: Text(
                                                  "${getLang(context, "LICENCE_INFO_FEMALE")}"),
                                              value: "female",
                                              groupValue: gender,
                                              onChanged: (value) {
                                                gender = value.toString();
                                                print(gender);
                                                AppCubit.get(context)
                                                    .changeRadio();
                                              }),
                                        ),
                                      ],
                                    ),

                                    Container(
                                      height: 130,
                                      child: GridView.builder(
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 4),
                                        itemBuilder: (context, index) =>
                                            GestureDetector(
                                          onTap: () {
                                            initCategory = index;
                                            setState(() {});
                                          },
                                          child: Card(
                                              elevation: 5,
                                              shadowColor: buttonsColor,
                                              child: Center(
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      "${categories[index]}",
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          color: initCategory ==
                                                                  index
                                                              ? Colors.white
                                                              : Colors.black),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              color: initCategory == index
                                                  ? buttonsColor
                                                  : Colors.white),
                                        ),
                                        itemCount: 4,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                            child: Card(
                                          child: Column(
                                            children: [
                                              Text(
                                                  "${getLang(context, "LICENCE_INFO_PROFILE_PICTURE")}"),
                                              IconButton(
                                                icon: Icon(AppCubit.get(context)
                                                            .profileImage ==
                                                        null
                                                    ? Icons.upload
                                                    : Icons.check),
                                                onPressed: () {
                                                  AppCubit.get(context)
                                                      .getProfileImage();
                                                },
                                              ),
                                            ],
                                          ),
                                        )),
                                        Expanded(
                                            child: Card(
                                          child: Column(
                                            children: [
                                              Text(
                                                  "${getLang(context, "LICENCE_INFO_LICENCE_PICTURE")}"),
                                              IconButton(
                                                icon: Icon(AppCubit.get(context)
                                                            .licenceImage ==
                                                        null
                                                    ? Icons.upload
                                                    : Icons.check),
                                                onPressed: () {
                                                  AppCubit.get(context)
                                                      .getLicenceImage();
                                                },
                                              ),
                                            ],
                                          ),
                                        )),
                                        Expanded(
                                            child: Card(
                                          child: Column(
                                            children: [
                                              Text(
                                                  "${getLang(context, "LICENCE_INFO_PASSPORT_PICTURE")}"),
                                              IconButton(
                                                icon: Icon(AppCubit.get(context)
                                                            .passportImage ==
                                                        null
                                                    ? Icons.upload
                                                    : Icons.check),
                                                onPressed: () {
                                                  AppCubit.get(context)
                                                      .getPassportImage();
                                                },
                                              ),
                                            ],
                                          ),
                                        )),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 12.0),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Checkbox(
                                              activeColor: buttonsColor,
                                              value: agreeTerms,
                                              onChanged: (value) {
                                                agreeTerms = !agreeTerms;
                                                AppCubit.get(context)
                                                    .changeCheckBox();
                                                print(agreeTerms);
                                              }),
                                          Expanded(
                                            child: Container(
                                                child: Text(
                                                    "${getLang(context, "LICENCE_INFO_AGREE_TERMS")}")),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 100,
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
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

bool isEnglish(String text) {
  // Regular expression to match only English alphabets
  RegExp english = RegExp(r'^[a-zA-Z ]+$');

  // Check if the string matches the English pattern
  return english.hasMatch(text);
}
