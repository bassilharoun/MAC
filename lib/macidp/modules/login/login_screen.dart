import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:macidp/macidp/app_cubit/app_cubit.dart';
import 'package:macidp/macidp/layout/shop_layout.dart';
import 'package:macidp/macidp/modules/login/cubit/cubit.dart';
import 'package:macidp/macidp/modules/login/cubit/states.dart';
import 'package:macidp/macidp/modules/signup/signup_screen.dart';
import 'package:macidp/macidp/shared/colors.dart';
import 'package:macidp/macidp/shared/components/components.dart';
import 'package:macidp/macidp/shared/network/local/cache_helper.dart';

class LoginScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();

  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppLoginCubit(),
      child: BlocConsumer<AppLoginCubit, AppLoginStates>(
        listener: (context, state) {
          if (state is AppLoginErrorState) {
            showToast(text: state.error, state: ToastStates.ERROR);
          }
          if (state is AppLoginSuccessState) {
            AppCubit.get(context).getUserData();
            CacheHelper.saveData(key: 'uId', value: state.uId).then((value) {
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
                        Image.asset("assets/images/logo.png"),
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          'تسجيل الدخول',
                          style: Theme.of(context)
                              .textTheme
                              .headline3!
                              .copyWith(color: defaultColor),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        defaultTxtForm(
                            controller: emailController,
                            type: TextInputType.emailAddress,
                            validate: (value) {
                              if (value!.isEmpty) {
                                return "Your email can't be empty !";
                              }
                            },
                            label: 'البريد الالكتروني',
                            prefix: Icons.email_outlined),
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
                            onSubmit: (value) {
                              if (formKey.currentState!.validate()) {}
                            },
                            label: 'كلمة المرور',
                            isPassword: AppLoginCubit.get(context).isPassword,
                            prefix: Icons.lock_open_outlined,
                            suffix: AppLoginCubit.get(context).suffix,
                            onSuffixPressed: () {
                              AppLoginCubit.get(context)
                                  .changePasswordVisibility();
                            }),
                        SizedBox(
                          height: 15,
                        ),
                        ConditionalBuilder(
                          condition: state is! AppLoginLoadingState,
                          builder: (context) => defaultButton(
                              function: () {
                                if (formKey.currentState!.validate()) {
                                  AppLoginCubit.get(context).userLogin(
                                      email: emailController.text,
                                      password: passwordController.text);
                                }
                              },
                              text: 'تسجيل الدخول'),
                          fallback: (context) => Center(
                              child: CircularProgressIndicator(
                            color: defaultColor,
                          )),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't have an account ?",
                              style: TextStyle(fontSize: 16),
                            ),
                            defaultTextButton(
                                function: () {
                                  navigateTo(context, SignupScreen());
                                },
                                text: 'Signup'),
                          ],
                        )
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
