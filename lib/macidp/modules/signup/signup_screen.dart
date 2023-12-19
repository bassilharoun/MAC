import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:macidp/const.dart';
import 'package:macidp/macidp/app_cubit/app_cubit.dart';
import 'package:macidp/macidp/layout/shop_layout.dart';
import 'package:macidp/macidp/modules/signup/cubit/cubit.dart';
import 'package:macidp/macidp/modules/signup/cubit/states.dart';
import 'package:macidp/macidp/shared/colors.dart';
import 'package:macidp/macidp/shared/components/applocale.dart';
import 'package:macidp/macidp/shared/components/components.dart';
import 'package:macidp/macidp/shared/network/local/cache_helper.dart';

class SignupScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppSignupCubit(),
      child: BlocConsumer<AppSignupCubit, AppSignupStates>(
        listener: (context, state) {
          if (state is AppCreateUserSuccessState) {
            AppCubit.get(context).getUserData();
            CacheHelper.saveData(key: 'uId', value: uId).then((value) {
              navigateAndFinish(context, ShopLayout());
            });
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${getLang(context, "SIGNUP")}',
                          style: Theme.of(context)
                              .textTheme
                              .headline3!
                              .copyWith(color: defaultColor),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          '${getLang(context, "SIGNUP_AGRRE_TERMS")}',
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    color: Colors.grey[500],
                                  ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        defaultTxtForm(
                            controller: nameController,
                            type: TextInputType.name,
                            validate: (value) {
                              if (value!.isEmpty) {
                                return "What\'s your name !";
                              }
                            },
                            label: '${getLang(context, "SIGNUP_FULLNAME")}',
                            prefix: Icons.person),
                        SizedBox(
                          height: 15,
                        ),
                        defaultTxtForm(
                            controller: phoneController,
                            type: TextInputType.phone,
                            validate: (value) {
                              if (value!.isEmpty) {
                                return "We need your phone !";
                              }
                            },
                            label: '${getLang(context, "SIGNUP_PHONE")}',
                            prefix: Icons.phone_iphone_outlined),
                        SizedBox(
                          height: 15,
                        ),
                        defaultTxtForm(
                            controller: emailController,
                            type: TextInputType.emailAddress,
                            validate: (value) {
                              if (value!.isEmpty) {
                                return "Your email can't be empty !";
                              }
                            },
                            label: '${getLang(context, "SIGNUP_EMAIL")}',
                            prefix: Icons.email_outlined),
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
                                  value:
                                      AppSignupCubit.get(context).dropdCountry,
                                  items: AppSignupCubit.get(context)
                                      .country
                                      .map((e) {
                                    return DropdownMenuItem(
                                      value: e,
                                      child: Text(e),
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    AppSignupCubit.get(context)
                                        .changeDropdownCountry(newValue);
                                  }),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        defaultTxtForm(
                            controller: passwordController,
                            type: TextInputType.visiblePassword,
                            validate: (value) {
                              if (value!.isEmpty) {
                                return "Password is too short !";
                              }
                            },
                            onSubmit: (value) {},
                            label: '${getLang(context, "SIGNUP_PASSWORD")}',
                            isPassword: AppSignupCubit.get(context).isPassword,
                            prefix: Icons.lock_open_outlined,
                            suffix: AppSignupCubit.get(context).suffix,
                            onSuffixPressed: () {
                              AppSignupCubit.get(context)
                                  .changePasswordVisibility();
                            }),
                        SizedBox(
                          height: 15,
                        ),
                        Center(
                          child: InkWell(
                            onTap: () {
                              AppSignupCubit.get(context).getProfileImage();
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                color: Colors.grey[200],
                                height: 150,
                                width: 150,
                                child:
                                    AppSignupCubit.get(context).profileImage ==
                                            null
                                        ? Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                  "${getLang(context, "SIGNUP_PROFILE_PICTURE")}"),
                                              Icon(
                                                Icons.add_a_photo_outlined,
                                                size: 50,
                                              ),
                                            ],
                                          )
                                        : Image.file(AppSignupCubit.get(context)
                                            .profileImage!),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ConditionalBuilder(
                          condition: state is! AppSignupLoadingState,
                          builder: (context) => defaultButton(
                            function: () {
                              if (formKey.currentState!.validate()) {
                                if (AppSignupCubit.get(context).profileImage !=
                                        null &&
                                    AppSignupCubit.get(context).dropdCountry !=
                                        "اختر دولة الاقامة") {
                                  AppSignupCubit.get(context).userSignup(
                                      name: nameController.text,
                                      phone: phoneController.text,
                                      email: emailController.text,
                                      password: passwordController.text);
                                }
                              }
                            },
                            text: '${getLang(context, "SIGNUP")}',
                          ),
                          fallback: (context) => Center(
                              child: CircularProgressIndicator(
                            color: buttonsColor,
                          )),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
