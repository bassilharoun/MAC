import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:macidp/macidp/shared/colors.dart';

void navigateTo(context, widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
    context, MaterialPageRoute(builder: (context) => widget), (route) => false);

Widget defaultTxtForm({
  required TextEditingController controller,
  required TextInputType type,
  Function(String)? onSubmit,
  VoidCallback? onTap,
  Function(String)? onChanged,
  required String? Function(String?)? validate,
  required String label,
  IconData? prefix,
  IconData? suffix = null,
  bool isPassword = false,
  bool isClickable = true,
  VoidCallback? onSuffixPressed,
}) =>
    TextFormField(
      validator: validate,
      obscureText: isPassword,
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(prefix),
        labelStyle: TextStyle(fontSize: 16),
        suffixIcon: GestureDetector(
          child: Icon(suffix),
          onTap: onSuffixPressed,
        ),
        border: OutlineInputBorder(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(8.0),
            bottomLeft: Radius.circular(8.0),
            bottomRight: Radius.circular(8.0),
            topRight: Radius.circular(50.0),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: buttonsColor),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(8.0),
            bottomLeft: Radius.circular(8.0),
            bottomRight: Radius.circular(8.0),
            topRight: Radius.circular(50.0),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: buttonsColor),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(8.0),
            bottomLeft: Radius.circular(8.0),
            bottomRight: Radius.circular(8.0),
            topRight: Radius.circular(50.0),
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(8.0),
            bottomLeft: Radius.circular(8.0),
            bottomRight: Radius.circular(8.0),
            topRight: Radius.circular(50.0),
          ),
        ),
      ),
      keyboardType: type,
      enabled: isClickable,
      onFieldSubmitted: onSubmit,
      onChanged: onChanged,
      onTap: onTap,
    );

Widget defaultButton({
  Color background = buttonsColor,
  Color txtColor = Colors.white,
  required VoidCallback function,
  required String text,
  bool isUpperCase = true,
}) =>
    Container(
      width: double.infinity,
      child: MaterialButton(
        height: 35,
        onPressed: function,
        child: Text(
          text,
          style: TextStyle(color: txtColor, fontSize: 16),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: background,
      ),
    );

Widget defaultTextButton({
  required VoidCallback function,
  required String text,
  Color color = defaultColor,
}) =>
    TextButton(
        onPressed: function,
        child: Text(
          text.toUpperCase(),
          style: TextStyle(
              color: color, fontSize: 16, fontWeight: FontWeight.bold),
        ));

void showToast({
  required String text,
  required ToastStates state,
}) =>
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: chooseToastColor(state),
        textColor: Colors.white,
        fontSize: 16.0);

enum ToastStates { SUCCESS, ERROR, WARNING }

Color? chooseToastColor(ToastStates state) {
  Color? color;
  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green[500];
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.yellow;
      break;
  }
  return color;
}

Widget myDivider() => Container(
      width: double.infinity,
      height: 1,
      color: Colors.grey[300],
    );

Widget buildListItem(model, context, {bool isOldPrice = true}) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          color: Colors.white,
          height: 120,
          child: Row(
            children: [
              Container(
                height: 120,
                width: 120,
                child: Stack(
                  children: [
                    Image(
                      image: NetworkImage(model.image),
                    ),
                    Row(
                      children: [
                        if (model.discount != 0 && isOldPrice)
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            color: Colors.red[300],
                            child: Text(
                              'OFFER !',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        Spacer(),
                        IconButton(onPressed: () {}, icon: Icon(
                            // ShopCubit.get(context).fav[model.id]!
                            Icons.favorite))
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        model.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Row(
                        children: [
                          Spacer(),
                          if (model.discount != 0 && isOldPrice)
                            Text(
                              '\$ ${model.oldPrice}',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                  decoration: TextDecoration.lineThrough),
                            ),
                          if (model.discount == 0 && isOldPrice)
                            Text(
                              '',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                  decoration: TextDecoration.lineThrough),
                            )
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'Price',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 16, color: Colors.grey[600]),
                          ),
                          Spacer(),
                          Text(
                            '\$ ${model.price}',
                            style: TextStyle(fontSize: 16, color: defaultColor),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
