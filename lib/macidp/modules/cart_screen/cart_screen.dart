import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:macidp/macidp/app_cubit/app_cubit.dart';
import 'package:macidp/macidp/app_cubit/app_states.dart';
import 'package:macidp/macidp/layout/shop_layout.dart';
import 'package:macidp/macidp/models/products_model.dart';
import 'package:macidp/macidp/newscreens/app_theme.dart';
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
        backgroundColor: AppTheme.background,
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
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          children: [
                            Row(
                              children: [
                                Text("${getLang(context, "CART_TITLE")} "),
                                Text("${AppCubit.get(context).totalPrice}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    )),
                                Text(" ${getLang(context, "SAR")} ",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    )),
                              ],
                            ),
                            Expanded(
                              child: TextButton(
                                  child:
                                      Text("${getLang(context, "CART_PAYNOW")}",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          )),
                                  onPressed:
                                      // AppCubit.get(context).totalPrice <= 0?
                                      null
                                  // : () {
                                  //     AppCubit.get(context)
                                  //         .makeCheckoutsRequest(
                                  //             widget.product, context);
                                  //   },
                                  ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      ConditionalBuilder(
                          condition: AppCubit.get(context).cartItems.isNotEmpty,
                          builder: (context) => ListView.separated(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (context, index) => buildCartItem(
                                    AppCubit.get(context).cartItems[index]),
                                separatorBuilder: (context, index) => Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: myDivider(),
                                ),
                                itemCount:
                                    AppCubit.get(context).cartItems.length,
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

  buildCartItem(Products product) {
    return GestureDetector(
      onTap: () {
        // navigateTo(context, ProductDetails(product));
      },
      child: Card(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              // Expanded(
              //   flex: 3,
              //   child: Container(
              //       height: 100,
              //       width: 100,
              //       child: Image(
              //         image: NetworkImage(product.images[0].src),
              //         fit: BoxFit.cover,
              //       )),
              // ),
              Expanded(
                flex: 3,
                child: Container(
                  child: Text(
                    "${product.name}",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    Text(
                      "${product.price} ${getLang(context, "SAR")}",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: product.price == product.regularPrice
                              ? Colors.grey[600]
                              : buttonsColor),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: GestureDetector(
                    onTap: () {
                      AppCubit.get(context).removeCart(product).then((value) {
                        CacheHelper.saveData(
                                key: 'cart', list: AppCubit.get(context).cart)
                            .then((value) {
                          AppCubit.get(context).getCartItems(context);
                        });
                      });
                    },
                    child: Column(
                      children: [
                        Text("حذف", style: TextStyle(color: Colors.red)),
                        Icon(
                          CupertinoIcons.clear_circled,
                          color: Colors.red,
                          size: 25,
                        ),
                      ],
                    )),
                flex: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
