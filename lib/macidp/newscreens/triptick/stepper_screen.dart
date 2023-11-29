import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:macidp/macidp/app_cubit/app_cubit.dart';
import 'package:macidp/macidp/app_cubit/app_states.dart';
import 'package:macidp/macidp/shared/colors.dart';
import 'package:macidp/macidp/shared/components/components.dart';

class StepperScreen extends StatelessWidget {
  int step = 0;
  StepperScreen(this.step);

  var formKey = GlobalKey<FormState>();
  static var nameController = TextEditingController();
  static var idController = TextEditingController();
  static var passportController = TextEditingController();
  static var inAdressController = TextEditingController();
  static var outAdressController = TextEditingController();
  static var inPhoneController = TextEditingController();
  static var outPhoneController = TextEditingController();

  static var carNumberController = TextEditingController();
  static var carBrandController = TextEditingController();
  static var carModelController = TextEditingController();
  static var sitsNumberController = TextEditingController();
  static var creationYearController = TextEditingController();
  static var weightController = TextEditingController();
  static var sylenderController = TextEditingController();
  static var hoursesController = TextEditingController();
  static var engineNumberController = TextEditingController();
  static var chassisNumberController = TextEditingController();

  static var toolsController = TextEditingController();
  static var addController = TextEditingController();
  static var moneyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (step == 0) {
      return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  defaultTxtForm(
                      controller: nameController,
                      type: TextInputType.name,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return "";
                        }
                        return null;
                      },
                      label: "الاسم بالكامل",
                      prefix: Icons.person_outline),
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
                              width: 1), //border of dropdown button
                          borderRadius: BorderRadius.circular(
                              10), //border raiuds of dropdown button
                          boxShadow: <BoxShadow>[
                            //apply shadow on Dropdown button
                            BoxShadow(
                                color: Color.fromRGBO(
                                    0, 0, 0, 0.57), //shadow for button
                                blurRadius: 5) //blur radius of shadow
                          ]),
                      child: Center(
                        child: DropdownButton(
                            value: AppCubit.get(context).dropdCountry,
                            items: AppCubit.get(context).country.map((e) {
                              return DropdownMenuItem(
                                value: e,
                                child: Text(e),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              AppCubit.get(context)
                                  .changeDropdownCountry(newValue);
                            }),
                      ),
                    ),
                  ),
                  const SizedBox(
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
                              width: 1), //border of dropdown button
                          borderRadius: BorderRadius.circular(
                              10), //border raiuds of dropdown button
                          boxShadow: <BoxShadow>[
                            //apply shadow on Dropdown button
                            BoxShadow(
                                color: Color.fromRGBO(
                                    0, 0, 0, 0.57), //shadow for button
                                blurRadius: 5) //blur radius of shadow
                          ]),
                      child: Center(
                        child: DropdownButton(
                            value: AppCubit.get(context).dropdNationality,
                            items: AppCubit.get(context).nationality.map((e) {
                              return DropdownMenuItem(
                                value: e,
                                child: Text(e),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              AppCubit.get(context)
                                  .changeDropdownNationality(newValue);
                            }),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  defaultTxtForm(
                      controller: idController,
                      type: TextInputType.number,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return "";
                        }
                        return null;
                      },
                      label: "رقم الهوية",
                      prefix: CupertinoIcons.creditcard),
                  SizedBox(
                    height: 15,
                  ),
                  defaultTxtForm(
                      controller: passportController,
                      type: TextInputType.text,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return "";
                        }
                        return null;
                      },
                      label: "رقم جواز السفر",
                      prefix: CupertinoIcons.book),
                  SizedBox(
                    height: 15,
                  ),
                  defaultTxtForm(
                      controller: inAdressController,
                      type: TextInputType.text,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return "";
                        }
                        return null;
                      },
                      label: "العنوان بالسعودية",
                      prefix: CupertinoIcons.home),
                  SizedBox(
                    height: 15,
                  ),
                  defaultTxtForm(
                      controller: outAdressController,
                      type: TextInputType.text,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return "";
                        }
                        return null;
                      },
                      label: "العنوان خارج السعودية",
                      prefix: CupertinoIcons.house_alt),
                  SizedBox(
                    height: 15,
                  ),
                  defaultTxtForm(
                      controller: inPhoneController,
                      type: TextInputType.phone,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return "";
                        }
                        return null;
                      },
                      label: "الهاتف بالسعودية",
                      prefix: CupertinoIcons.phone),
                  SizedBox(
                    height: 15,
                  ),
                  defaultTxtForm(
                      controller: outPhoneController,
                      type: TextInputType.phone,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return "";
                        }
                        return null;
                      },
                      label: "الهاتف خارج السعودية",
                      prefix: CupertinoIcons.phone_arrow_up_right),
                  SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ),
          );
        },
      );
    }
    if (step == 1) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                width: double.infinity,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                      color: Colors.white, //background color of dropdown button
                      border: Border.all(
                          color: buttonsColor,
                          width: 1), //border of dropdown button
                      borderRadius: BorderRadius.circular(
                          10), //border raiuds of dropdown button
                      boxShadow: <BoxShadow>[
                        //apply shadow on Dropdown button
                        BoxShadow(
                            color: Color.fromRGBO(
                                0, 0, 0, 0.57), //shadow for button
                            blurRadius: 5) //blur radius of shadow
                      ]),
                  child: Center(
                    child: DropdownButton(
                        value: AppCubit.get(context).signCountryDrop,
                        items: AppCubit.get(context).signCountry.map((e) {
                          return DropdownMenuItem(
                            value: e,
                            child: Text(e),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          AppCubit.get(context)
                              .changeDropdownSignCountry(newValue);
                        }),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              defaultTxtForm(
                  controller: carNumberController,
                  type: TextInputType.text,
                  validate: (value) {
                    if (value!.isEmpty) {
                      return "";
                    }
                    return null;
                  },
                  label: "رقم لوحات السيارة",
                  prefix: CupertinoIcons.car_detailed),
              SizedBox(
                height: 15,
              ),
              Container(
                width: double.infinity,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                      color: Colors.white, //background color of dropdown button
                      border: Border.all(
                          color: buttonsColor,
                          width: 1), //border of dropdown button
                      borderRadius: BorderRadius.circular(
                          10), //border raiuds of dropdown button
                      boxShadow: <BoxShadow>[
                        //apply shadow on Dropdown button
                        BoxShadow(
                            color: Color.fromRGBO(
                                0, 0, 0, 0.57), //shadow for button
                            blurRadius: 5) //blur radius of shadow
                      ]),
                  child: Center(
                    child: DropdownButton(
                        value: AppCubit.get(context).dropdPanelType,
                        items: AppCubit.get(context).panelTypes.map((e) {
                          return DropdownMenuItem(
                            value: e,
                            child: Text(e),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          AppCubit.get(context)
                              .changeDropdownPanelType(newValue);
                        }),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Text("تاريخ انتهاء تسجيل المركبة"),
              SizedBox(
                height: 5,
              ),
              GestureDetector(
                onTap: () {
                  showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime(DateTime.now().year + 10),
                  ).then((value) {
                    AppCubit.get(context).changeVehicleLicenseExpiryDate(value);
                  });
                },
                child: Container(
                  width: double.infinity,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                        color:
                            Colors.white, //background color of dropdown button
                        border: Border.all(
                            color: buttonsColor,
                            width: 1), //border of dropdown button
                        borderRadius: BorderRadius.circular(
                            10), //border raiuds of dropdown button
                        boxShadow: <BoxShadow>[
                          //apply shadow on Dropdown button
                          BoxShadow(
                              color: Color.fromRGBO(
                                  0, 0, 0, 0.57), //shadow for button
                              blurRadius: 5) //blur radius of shadow
                        ]),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                                "${AppCubit.get(context).vehicleLicenseExpiryDate}"),
                            SizedBox(
                              width: 10,
                            ),
                            Icon(CupertinoIcons.calendar_badge_plus),
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
              defaultTxtForm(
                  controller: carBrandController,
                  type: TextInputType.text,
                  validate: (value) {
                    if (value!.isEmpty) {
                      return "";
                    }
                    return null;
                  },
                  label: "ماركة السيارة",
                  prefix: Icons.car_repair),
              SizedBox(
                height: 15,
              ),
              defaultTxtForm(
                  controller: carModelController,
                  type: TextInputType.text,
                  validate: (value) {
                    if (value!.isEmpty) {
                      return "";
                    }
                    return null;
                  },
                  label: "موديل السيارة",
                  prefix: Icons.numbers),
              SizedBox(
                height: 15,
              ),
              Container(
                width: double.infinity,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                      color: Colors.white, //background color of dropdown button
                      border: Border.all(
                          color: buttonsColor,
                          width: 1), //border of dropdown button
                      borderRadius: BorderRadius.circular(
                          10), //border raiuds of dropdown button
                      boxShadow: <BoxShadow>[
                        //apply shadow on Dropdown button
                        BoxShadow(
                            color: Color.fromRGBO(
                                0, 0, 0, 0.57), //shadow for button
                            blurRadius: 5) //blur radius of shadow
                      ]),
                  child: Center(
                    child: DropdownButton(
                        value: AppCubit.get(context).dropdCarType,
                        items: AppCubit.get(context).carTypes.map((e) {
                          return DropdownMenuItem(
                            value: e,
                            child: Text(e),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          AppCubit.get(context).changeDropdownCarType(newValue);
                        }),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              defaultTxtForm(
                  controller: sitsNumberController,
                  type: TextInputType.number,
                  validate: (value) {
                    if (value!.isEmpty) {
                      return "";
                    }
                    return null;
                  },
                  label: "عدد المقاعد",
                  prefix: Icons.chair_alt_outlined),
              SizedBox(
                height: 15,
              ),
              Text("سنة الصنع"),
              SizedBox(
                height: 5,
              ),
              GestureDetector(
                onTap: () {
                  showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  ).then((value) {
                    AppCubit.get(context).changeVehicleManufactureDate(value);
                  });
                },
                child: Container(
                  width: double.infinity,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                        color:
                            Colors.white, //background color of dropdown button
                        border: Border.all(
                            color: buttonsColor,
                            width: 1), //border of dropdown button
                        borderRadius: BorderRadius.circular(
                            10), //border raiuds of dropdown button
                        boxShadow: <BoxShadow>[
                          //apply shadow on Dropdown button
                          BoxShadow(
                              color: Color.fromRGBO(
                                  0, 0, 0, 0.57), //shadow for button
                              blurRadius: 5) //blur radius of shadow
                        ]),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                                "${AppCubit.get(context).vehicleManufactureDate}"),
                            SizedBox(
                              width: 10,
                            ),
                            Icon(CupertinoIcons.calendar_badge_plus),
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
              defaultTxtForm(
                  controller: weightController,
                  type: TextInputType.number,
                  validate: (value) {
                    if (value!.isEmpty) {
                      return "";
                    }
                    return null;
                  },
                  label: "الوزن",
                  prefix: Icons.balance),
              SizedBox(
                height: 15,
              ),
              defaultTxtForm(
                  controller: sylenderController,
                  type: TextInputType.number,
                  validate: (value) {
                    if (value!.isEmpty) {
                      return "";
                    }
                    return null;
                  },
                  label: "عدد السليندر",
                  prefix: Icons.factory_outlined),
              SizedBox(
                height: 15,
              ),
              defaultTxtForm(
                  controller: hoursesController,
                  type: TextInputType.number,
                  validate: (value) {
                    if (value!.isEmpty) {
                      return "";
                    }
                    return null;
                  },
                  label: "عدد الاحصنة",
                  prefix: Icons.run_circle_outlined),
              SizedBox(
                height: 15,
              ),
              Container(
                width: double.infinity,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                      color: Colors.white, //background color of dropdown button
                      border: Border.all(
                          color: buttonsColor,
                          width: 1), //border of dropdown button
                      borderRadius: BorderRadius.circular(
                          10), //border raiuds of dropdown button
                      boxShadow: <BoxShadow>[
                        //apply shadow on Dropdown button
                        BoxShadow(
                            color: Color.fromRGBO(
                                0, 0, 0, 0.57), //shadow for button
                            blurRadius: 5) //blur radius of shadow
                      ]),
                  child: Center(
                    child: DropdownButton(
                        value: AppCubit.get(context).dropdCarColor,
                        items: AppCubit.get(context).CarColors.map((e) {
                          return DropdownMenuItem(
                            value: e,
                            child: Text(e),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          AppCubit.get(context)
                              .changeDropdownCarColor(newValue);
                        }),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Expanded(
                    child: RadioListTile(
                        activeColor: buttonsColor,
                        title: Text("قماش"),
                        value: "fabric",
                        groupValue: AppCubit.get(context).material,
                        onChanged: (value) {
                          AppCubit.get(context).material = value.toString();
                          print(AppCubit.get(context).material);
                          AppCubit.get(context).changeMaterialRadio();
                        }),
                  ),
                  Expanded(
                    child: RadioListTile(
                        activeColor: buttonsColor,
                        title: Text("جلد"),
                        value: "leather",
                        groupValue: AppCubit.get(context).material,
                        onChanged: (value) {
                          AppCubit.get(context).material = value.toString();
                          print(AppCubit.get(context).material);
                          AppCubit.get(context).changeMaterialRadio();
                        }),
                  ),
                ],
              ),
              defaultTxtForm(
                  controller: engineNumberController,
                  type: TextInputType.text,
                  validate: (value) {
                    if (value!.isEmpty) {
                      return "";
                    }
                    return null;
                  },
                  label: "رقم المحرك",
                  prefix: CupertinoIcons.number),
              SizedBox(
                height: 15,
              ),
              defaultTxtForm(
                  controller: chassisNumberController,
                  type: TextInputType.text,
                  validate: (value) {
                    if (value!.isEmpty) {
                      return "";
                    }
                    return null;
                  },
                  label: "رقم الشاسية",
                  prefix: CupertinoIcons.car),
              SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      );
    } else {
      return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: CheckboxListTile(
                            title: Text("تكييف"),
                            value: AppCubit.get(context).isAir,
                            onChanged: (newValue) {
                              AppCubit.get(context).changeAirRadioCheckBox();
                              AppCubit.get(context).isAir = newValue!;
                            }),
                      ),
                      Expanded(
                        child: CheckboxListTile(
                            title: Text("راديو"),
                            value: AppCubit.get(context).isRadio,
                            onChanged: (newValue) {
                              AppCubit.get(context).isRadio = newValue!;
                              AppCubit.get(context).changeAirRadioCheckBox();
                            }),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: Text("عدد الاطارات الاحتياطية"),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: RadioListTile(
                            activeColor: buttonsColor,
                            title: Text("لا"),
                            value: "0",
                            groupValue: AppCubit.get(context).wheels,
                            onChanged: (value) {
                              AppCubit.get(context).wheels = value.toString();
                              print(AppCubit.get(context).wheels);
                              AppCubit.get(context).changeWheelRadio();
                            }),
                      ),
                      Expanded(
                        child: RadioListTile(
                            activeColor: buttonsColor,
                            title: Text("1"),
                            value: "1",
                            groupValue: AppCubit.get(context).wheels,
                            onChanged: (value) {
                              AppCubit.get(context).wheels = value.toString();
                              print(AppCubit.get(context).wheels);
                              AppCubit.get(context).changeWheelRadio();
                            }),
                      ),
                      Expanded(
                        child: RadioListTile(
                            activeColor: buttonsColor,
                            title: Text("2"),
                            value: "2",
                            groupValue: AppCubit.get(context).wheels,
                            onChanged: (value) {
                              AppCubit.get(context).wheels = value.toString();
                              print(AppCubit.get(context).wheels);
                              AppCubit.get(context).changeWheelRadio();
                            }),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  defaultTxtForm(
                      controller: toolsController,
                      type: TextInputType.text,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return "";
                        }
                        return null;
                      },
                      label: "المعدات",
                      prefix: CupertinoIcons.wrench),
                  SizedBox(
                    height: 15,
                  ),
                  defaultTxtForm(
                      controller: addController,
                      type: TextInputType.text,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return "";
                        }
                        return null;
                      },
                      label: "اضافات اخرى",
                      prefix: CupertinoIcons.add_circled),
                  SizedBox(
                    height: 15,
                  ),
                  defaultTxtForm(
                      controller: moneyController,
                      type: TextInputType.number,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return "";
                        }
                        return null;
                      },
                      label: "قيمة السيارة",
                      prefix: CupertinoIcons.money_dollar),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Card(
                        child: Column(
                          children: [
                            Text("نسخة تسجيل المركبة"),
                            IconButton(
                              icon: Icon(
                                  AppCubit.get(context).carCopyImage == null
                                      ? Icons.upload
                                      : Icons.check),
                              onPressed: () {
                                AppCubit.get(context).getCarCopyImage();
                              },
                            ),
                          ],
                        ),
                      )),
                      Expanded(
                          child: Card(
                        child: Column(
                          children: [
                            Text("صورة جواز السفر"),
                            IconButton(
                              icon: Icon(
                                  AppCubit.get(context).passportImage == null
                                      ? Icons.upload
                                      : Icons.check),
                              onPressed: () {
                                AppCubit.get(context).getPassportImage();
                              },
                            ),
                          ],
                        ),
                      )),
                      Expanded(
                          child: Card(
                        child: Column(
                          children: [
                            Text("صورة الهوية المحلية"),
                            IconButton(
                              icon: Icon(
                                  AppCubit.get(context).localIdImage == null
                                      ? Icons.upload
                                      : Icons.check),
                              onPressed: () {
                                AppCubit.get(context).getlocalIdImage();
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
                ],
              ),
            ),
          );
        },
      );
    }
  }
}