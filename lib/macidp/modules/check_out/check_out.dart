import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:country_state_city_picker/country_state_city_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:macidp/macidp/app_cubit/app_cubit.dart';
import 'package:macidp/macidp/app_cubit/app_states.dart';
import 'package:macidp/macidp/shared/colors.dart';
import 'package:macidp/macidp/shared/components/components.dart';

class CheckOut extends StatefulWidget {

  @override
  State<CheckOut> createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {

  var formKey = GlobalKey<FormState>();

  var fNameController = TextEditingController();

  var lNameController = TextEditingController();

  var streetController = TextEditingController();

  var cityController = TextEditingController();

  var postcodeController = TextEditingController();

  var phoneController = TextEditingController();

  var emailController = TextEditingController();

  String? countryValue;
  String? stateValue;
  String? cityValue;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state){},
      builder: (context, state){
        return Scaffold(
          body: SingleChildScrollView(
            child: SafeArea(
              child: Column(
                children: [
                  Container(
                    height: 60,
                    child: Row(
                      children: [
                        IconButton(onPressed: (){
                          Navigator.pop(context);
                        }, icon: Icon(CupertinoIcons.back,size: 30,)),
                        Spacer(),
                        Image.asset("assets/images/logo.png",width: 180,),
                        Spacer(),
                        SizedBox(width: 25,)
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          ClipRRect(
                            child: Container(
                              color: Colors.grey[300],
                              height: 50,
                              width: double.infinity,
                              child: Center(child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                child: Row(
                                  children: [
                                    Text(" فقط لا غير ",style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                                    Text(" ر.س ",style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: buttonsColor),),
                                    Text("سوف تدفع ",style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                                  ],
                                ),
                              )),
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          SizedBox(height: 10,),
                          defaultTxtForm(controller: fNameController, type: TextInputType.text, validate: (val){
                            if(val!.isEmpty){
                              return "";
                            }
                            return null;
                          }, label: "الاسم الاول"),
                          SizedBox(height: 10,),
                          defaultTxtForm(controller: lNameController, type: TextInputType.text, validate: (val){
                            if(val!.isEmpty){
                              return "";
                            }
                            return null;
                          }, label: "الاسم الاخير"),
                          SizedBox(height: 10,),
                          defaultTxtForm(controller: streetController, type: TextInputType.text, validate: (val){
                            if(val!.isEmpty){
                              return "";
                            }
                            return null;
                          }, label: "عنوان الشارع"),
                          SizedBox(height: 10,),
                          SelectState(
                            onCountryChanged: (value) {
                              setState(() {
                                countryValue = value;
                              });
                            },
                            onStateChanged:(value) {
                              setState(() {
                                stateValue = value;
                              });
                            },
                            onCityChanged:(value) {
                              setState(() {
                                cityValue = value;
                              });
                            },
                          ),
                          // defaultTxtForm(controller: cityController, type: TextInputType.text, validate: (val){
                          //   if(val!.isEmpty){
                          //     return "";
                          //   }
                          // }, label: "City"),
                          SizedBox(height: 10,),
                          defaultTxtForm(controller: postcodeController, type: TextInputType.number, validate: (val){
                            if(val!.isEmpty){
                              return "";
                            }
                            return null;
                          }, label: "الرمز البريدي"),
                          SizedBox(height: 10,),
                          defaultTxtForm(controller: phoneController, type: TextInputType.number, validate: (val){
                            if(val!.isEmpty){
                              return "";
                            }
                            return null;
                          }, label: "الهاتف"),
                          SizedBox(height: 10,),
                          defaultTxtForm(controller: emailController, type: TextInputType.text, validate: (val){
                            if(val!.isEmpty){
                              return "";
                            }
                            return null;
                          }, label: "البريد الالكتروني"),
                          SizedBox(height: 10,),
                          ConditionalBuilder(
                            condition: false,
                            builder: (context) => Center(child: CircularProgressIndicator(color: defaultColor,)),
                            fallback: (context) => defaultButton(function: (){
                            }, text: "Order now !")
                          ),


                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      } ,
    );
  }
}
