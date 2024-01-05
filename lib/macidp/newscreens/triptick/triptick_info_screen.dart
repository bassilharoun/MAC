import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:macidp/macidp/app_cubit/app_cubit.dart';
import 'package:macidp/macidp/app_cubit/app_states.dart';
import 'package:macidp/macidp/models/products_model.dart';
import 'package:macidp/macidp/newscreens/license%20details/license_app_theme.dart';
import 'package:macidp/macidp/newscreens/license%20details/license_data.dart';
import 'package:macidp/macidp/newscreens/triptick/stepper_screen.dart';
import 'package:macidp/macidp/shared/colors.dart';
import 'package:macidp/macidp/shared/components/applocale.dart';
import 'package:macidp/main.dart';
import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/cupertino.dart';

class TriptickInfoScreen extends StatefulWidget {
  final index;
  Products product;
  TriptickInfoScreen(this.index, this.product);
  @override
  _TriptickInfoScreenState createState() => _TriptickInfoScreenState();
}

class _TriptickInfoScreenState extends State<TriptickInfoScreen> {
  int activeStep = 0;
  int activeStep2 = 0;
  double progress = 0.2;
  var couponController = TextEditingController();

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

    initState() {
      super.initState();
    }

    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        print("object");
        print(widget.product.price);
        return Scaffold(
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: Padding(
            padding: const EdgeInsets.only(left: 16, bottom: 16, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Container(
                    height: 50,
                    child: activeStep != 2
                        ? ElevatedButton(
                            onPressed: () {
                              setState(() {});
                              activeStep = activeStep + 1;
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: buttonsColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                            ),
                            child: Text(
                              "${getLang(context, "NEXT")}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                          )
                        : ElevatedButton(
                            onPressed: (cubit.dropdCountry ==
                                        "اختر دولة الاقامة" ||
                                    cubit.dropdNationality == "اختر الجنسية" ||
                                    cubit.localIdImage == null ||
                                    cubit.passportImage == null ||
                                    cubit.carCopyImage == null)
                                ? null
                                : () {
                                    // if (StepperSformKey.currentState!.validate()) {
                                    print(widget.product.name);
                                    print(widget.product.price);
                                    // AppCubit.get(context)
                                    //     .getCheckOut(context, widget.product);
                                    // }
                                    AppCubit.get(context)
                                        .makeTriptickCheckoutsRequest(
                                      widget.product,
                                      context,
                                      StepperScreen.nameController.text,
                                      cubit.dropdCountry!,
                                      cubit.dropdNationality!,
                                      StepperScreen.idController.text,
                                      StepperScreen.passportController.text,
                                      StepperScreen.inAdressController.text,
                                      StepperScreen.outAdressController.text,
                                      StepperScreen.inPhoneController.text,
                                      StepperScreen.outPhoneController.text,
                                      0,
                                      cubit.signCountryDrop!,
                                      StepperScreen.carNumberController.text,
                                      cubit.panelTypes
                                          .indexOf(cubit.dropdPanelType!),
                                      cubit.vehicleLicenseExpiryDate,
                                      StepperScreen.carBrandController.text,
                                      StepperScreen.carModelController.text,
                                      cubit.carTypes
                                              .indexOf(cubit.dropdCarType!) +
                                          1,
                                      int.parse(StepperScreen
                                          .sitsNumberController.text),
                                      cubit.vehicleManufactureDate,
                                      int.parse(
                                          StepperScreen.weightController.text),
                                      int.parse(StepperScreen
                                          .sylenderController.text),
                                      int.parse(
                                          StepperScreen.hoursesController.text),
                                      cubit.dropdCarColor!,
                                      cubit.material == "fabric" ? 1 : 2,
                                      StepperScreen.engineNumberController.text,
                                      StepperScreen
                                          .chassisNumberController.text,
                                      cubit.isAir,
                                      cubit.isRadio,
                                      int.parse(cubit.wheels),
                                      StepperScreen.toolsController.text,
                                      StepperScreen.addController.text,
                                      int.parse(
                                          StepperScreen.moneyController.text),
                                      cubit.carCopyImage!,
                                      cubit.passportImage!,
                                      cubit.localIdImage!,
                                    );
                                    print(StepperScreen.nameController.text);
                                    print(cubit.dropdCountry);
                                    print(cubit.dropdNationality);
                                    print(StepperScreen.idController.text);
                                    print(
                                        StepperScreen.passportController.text);
                                    print(
                                        StepperScreen.inAdressController.text);
                                    print(
                                        StepperScreen.outAdressController.text);
                                    print(StepperScreen.inPhoneController.text);
                                    print(
                                        StepperScreen.outPhoneController.text);
                                    print(0);
                                    print(cubit.signCountryDrop);
                                    print(
                                        StepperScreen.carNumberController.text);
                                    print(cubit.panelTypes
                                        .indexOf(cubit.dropdPanelType!));
                                    print(cubit.vehicleLicenseExpiryDate);
                                    print(
                                        StepperScreen.carBrandController.text);
                                    print(
                                        StepperScreen.carModelController.text);
                                    print(cubit.carTypes
                                            .indexOf(cubit.dropdCarType!) +
                                        1);
                                    print(int.parse(StepperScreen
                                        .sitsNumberController.text));
                                    print(cubit.vehicleManufactureDate);
                                    print(int.parse(
                                        StepperScreen.weightController.text));
                                    print(int.parse(
                                        StepperScreen.sylenderController.text));
                                    print(int.parse(
                                        StepperScreen.hoursesController.text));
                                    print(cubit.dropdCarColor);
                                    print(cubit.material == "fabric" ? 1 : 2);
                                    print(StepperScreen
                                        .engineNumberController.text);
                                    print(StepperScreen
                                        .chassisNumberController.text);
                                    print(cubit.isAir);
                                    print(cubit.isRadio);
                                    print(int.parse(cubit.wheels));
                                    print(StepperScreen.toolsController.text);
                                    print(StepperScreen.addController.text);
                                    print(int.parse(
                                        StepperScreen.moneyController.text));
                                    print(cubit.carCopyImage);
                                    print(cubit.passportImage);
                                    print(cubit.localIdImage);
                                  },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: buttonsColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                            ),
                            child: Text(
                              "${getLang(context, "TRIPTICK_INFO_ORDER_TRIPTICK")}",
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
              child: Column(
                children: [
                  Container(
                    color: whiteColor,
                    child: AppBar(
                      backgroundColor: whiteColor,
                      leading: InkWell(
                        child: Icon(
                          Icons.arrow_back_ios,
                        ),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                      title: Material(
                        color: Colors.transparent,
                        child: Row(
                          children: [
                            Spacer(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  AppCubit.get(context)
                                      .triptickProducts[widget.index]
                                      .name!,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 22,
                                    letterSpacing: 0.27,
                                    color: LicenseAppTheme.darkerText,
                                  ),
                                ),
                                Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text(
                                                  '${getLang(context, "ENTER_COUPON")}'),
                                              content: TextField(
                                                controller: couponController,
                                                onChanged: (value) {
                                                  // Store your value here
                                                },
                                                decoration: InputDecoration(
                                                    hintText:
                                                        "${getLang(context, "COUPON")}"),
                                              ),
                                              actions: [
                                                TextButton(
                                                  child: Text(
                                                      '${getLang(context, "SUBMIT")}'),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                    AppCubit.get(context)
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
                                        padding: const EdgeInsets.all(4.0),
                                        child: Row(
                                          children: [
                                            Text(
                                              "${getLang(context, "COUPON")}",
                                              style: TextStyle(
                                                  color: Colors.green,
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
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      "${int.parse(AppCubit.get(context).triptickProducts[widget.index].price) - (int.parse(AppCubit.get(context).triptickProducts[widget.index].price) * AppCubit.get(context).dis) / 100} ${getLang(context, "SAR")}",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w200,
                                        fontSize: 18,
                                        letterSpacing: 0.27,
                                        color: buttonsColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(
                      color: whiteColor,
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
                            SizedBox(
                              height: 30,
                            ),
                            EasyStepper(
                              activeStep: activeStep,
                              activeStepBorderColor: lightColor,
                              finishedStepBackgroundColor: lightColor,
                              lineStyle: LineStyle(
                                lineLength: 100,
                                lineThickness: 6,
                                lineSpace: 4,
                                lineType: LineType.normal,
                                defaultLineColor: Colors.blueGrey.shade300,
                                finishedLineColor: lightColor,
                                progress: progress,
                                progressColor: lightColor,
                              ),
                              borderThickness: 10,
                              internalPadding: 15,
                              loadingAnimation: 'assets/lotties/progresss.json',
                              steps: [
                                EasyStep(
                                  icon: Icon(CupertinoIcons.person),
                                  title:
                                      '${getLang(context, "TRIPTICK_INFO_STEPPER_PERSONAL")}',
                                  lineText:
                                      '${getLang(context, "TRIPTICK_INFO_STEPPER_PERSONAL_INFO")}',
                                ),
                                EasyStep(
                                  icon: Icon(CupertinoIcons.car_detailed),
                                  title:
                                      '${getLang(context, "TRIPTICK_INFO_STEPPER_CAR")}',
                                  lineText:
                                      '${getLang(context, "TRIPTICK_INFO_STEPPER_CAR_INFO")}',
                                ),
                                EasyStep(
                                  icon: Icon(CupertinoIcons.doc),
                                  title:
                                      '${getLang(context, "TRIPTICK_INFO_STEPPER_ADDITIONAL")}',
                                  lineText: '',
                                ),
                              ],
                              onStepReached: (index) =>
                                  setState(() => activeStep = index),
                            ),
                            StepperScreen(activeStep),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 80),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget getTimeBoxUI(String text1, String color) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: LicenseAppTheme.nearlyWhite,
          borderRadius: const BorderRadius.all(Radius.circular(16.0)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: LicenseAppTheme.grey.withOpacity(0.2),
                offset: const Offset(1.1, 1.1),
                blurRadius: 8.0),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              text1,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
                letterSpacing: 0.27,
                color: HexColor(color),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
