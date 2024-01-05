import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:macidp/macidp/app_cubit/app_cubit.dart';
import 'package:macidp/macidp/app_cubit/app_states.dart';
import 'package:macidp/macidp/layout/shop_layout.dart';
import 'package:macidp/macidp/models/my_external.dart';
import 'package:macidp/macidp/models/products_model.dart';
import 'package:macidp/macidp/shared/colors.dart';
import 'package:macidp/macidp/shared/components/applocale.dart';
import 'package:macidp/macidp/shared/components/components.dart';
import 'package:macidp/macidp/shared/network/local/cache_helper.dart';

class CartScreen extends StatefulWidget {
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(listener: (context, state) {
      // if(state is AppSuccessGetCart){
      //   Navigator.pop(context);
      // }
    }, builder: (context, state) {
      return Scaffold(
        backgroundColor: whiteColor,
        body: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: [
                Container(
                  child: getAppBarUI(context),
                ),
                if (state is AppLoadingGetCart)
                  LinearProgressIndicator(
                    color: buttonsColor,
                    backgroundColor: Colors.grey,
                  ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      // TODO
                      // Container(
                      //   width: MediaQuery.of(context).size.width,
                      //   child:
                      //    Row(
                      //     children: [
                      //       Row(
                      //         children: [
                      //           Text("${getLang(context, "CART_TITLE")} "),
                      //           Text("${AppCubit.get(context).totalPrice}",
                      //               style: TextStyle(
                      //                 fontWeight: FontWeight.bold,
                      //                 fontSize: 18,
                      //               )),
                      //           Text(" ${getLang(context, "SAR")} ",
                      //               style: TextStyle(
                      //                 fontWeight: FontWeight.bold,
                      //                 fontSize: 16,
                      //               )),
                      //         ],
                      //       ),
                      //       Expanded(
                      //         child: TextButton(
                      //             child:
                      //                 Text("${getLang(context, "CART_PAYNOW")}",
                      //                     style: TextStyle(
                      //                       fontWeight: FontWeight.bold,
                      //                       fontSize: 16,
                      //                     )),
                      //             onPressed:
                      //                 // AppCubit.get(context).totalPrice <= 0?
                      //                 null
                      //             // : () {
                      //             //     AppCubit.get(context)
                      //             //         .makeCheckoutsRequest(
                      //             //             widget.product, context);
                      //             //   },
                      //             ),
                      //       ),
                      //     ],
                      //   ),

                      // ),
                      SizedBox(
                        height: 15,
                      ),

                      ConditionalBuilder(
                          condition: AppCubit.get(context)
                              .myExternal
                              .licenseOrders!
                              .isNotEmpty,
                          builder: (context) => Column(
                                children: [
                                  ListView.separated(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) =>
                                        buildCartItem(AppCubit.get(context)
                                            .myExternal
                                            .licenseOrders![index]),
                                    separatorBuilder: (context, index) =>
                                        Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: SizedBox(
                                        height: 5,
                                      ),
                                    ),
                                    itemCount: AppCubit.get(context)
                                        .myExternal
                                        .licenseOrders!
                                        .length,
                                  ),
                                  SizedBox(
                                    height: 100,
                                  ),
                                ],
                              ),
                          fallback: (context) => Center(
                                child: Icon(CupertinoIcons.cart_badge_minus,
                                    size: 100, color: Colors.grey[400]),
                              ))
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  buildCartItem(LicenseOrders externalProduct) {
    return GestureDetector(
      onTap: () {
        // navigateTo(context, ProductDetails(product));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              height: 3,
              color: externalProduct.status == "completed"
                  ? Colors.green
                  : (externalProduct.status == "rejected"
                      ? Colors.red
                      : Colors.orange),
            ),
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                        height: 120,
                        width: 120,
                        child: Image(
                          image: NetworkImage(
                              "https://mobile.macxbackupxdata.space/${externalProduct.personalPhotoUrl}"),
                          fit: BoxFit.cover,
                        )),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Text(
                                  "${externalProduct.fullName}",
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Column(
                                  children: [
                                    Text(
                                      "${externalProduct.sourceOfLocalLicenseCountry}",
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                          color: Colors.grey[600]),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Text(
                                "${DateFormat.yMMMd().format(DateTime.parse(externalProduct.birthDate!))}",
                                style: TextStyle(
                                    fontSize: 18, color: Colors.grey[600]),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Text(
                                "${getLang(context, "LICENSE_TYPE")}",
                                style: TextStyle(
                                    fontSize: 16, color: Colors.grey[600]),
                              ),
                              Text(
                                "${externalProduct.licenseType!.first == 3 ? "${getLang(context, "THREE_YEARS")}" : (externalProduct.licenseType!.first == 2 ? "${getLang(context, "TWO_YEARS")}" : "${getLang(context, "ONE_YEAR")}")}",
                                style: TextStyle(
                                    fontSize: 16, color: Colors.grey[600]),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Expanded(
                  //   child: GestureDetector(
                  //       onTap: () {
                  //         AppCubit.get(context).removeCart(product).then((value) {
                  //           CacheHelper.saveData(
                  //                   key: 'cart', list: AppCubit.get(context).cart)
                  //               .then((value) {
                  //             AppCubit.get(context).getCartItems(context);
                  //           });
                  //         });
                  //       },
                  //       child: Column(
                  //         children: [
                  //           Text("حذف", style: TextStyle(color: Colors.red)),
                  //           Icon(
                  //             CupertinoIcons.clear_circled,
                  //             color: Colors.red,
                  //             size: 25,
                  //           ),
                  //         ],
                  //       )),
                  //   flex: 1,
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
