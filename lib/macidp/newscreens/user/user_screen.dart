import 'package:flutter/material.dart';
import 'package:macidp/macidp/app_cubit/app_cubit.dart';
import 'package:macidp/macidp/newscreens/app_theme.dart';
import 'package:u_credit_card/u_credit_card.dart';

class UserScreen extends StatefulWidget {
  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => Profile3()),
            // );
          },
          child: Icon(
            Icons.menu,
            color: Colors.white,
            size: 24,
          ),
        ),
        title: Text(
          "الملف الشخصي",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: <Widget>[
          Center(
            child: Image.network(
              "${AppCubit.get(context).userModel!.image}",
              fit: BoxFit.cover,
              width: size.width,
              height: size.height,
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: size.height * 0.5,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: size.height - 100,
                    padding: EdgeInsets.symmetric(
                      horizontal: 16,
                    ),
                    decoration: BoxDecoration(
                        color: AppTheme.background,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(25),
                        )),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(
                            top: 32,
                            bottom: 16,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  CircleAvatar(
                                    radius: 28,
                                    backgroundImage: NetworkImage(
                                        "${AppCubit.get(context).userModel!.image}"),
                                  ),
                                  SizedBox(
                                    width: 12,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        "${AppCubit.get(context).userModel!.name}",
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 4,
                                      ),
                                      Text(
                                        "غير معرف",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          color: Colors.grey[200],
                        ),
                        Container(
                          height: 64,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Container(
                                width: 110,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      "الطلبات المعلقة",
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 12,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 4,
                                    ),
                                    Text(
                                      "0",
                                      style: TextStyle(
                                        color: Colors.black87,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: 110,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      "الطلبات المكتملة",
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 12,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 4,
                                    ),
                                    Text(
                                      "0",
                                      style: TextStyle(
                                        color: Colors.black87,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: 110,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      "الطلبات الملغية",
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 12,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 4,
                                    ),
                                    Text(
                                      "0",
                                      style: TextStyle(
                                        color: Colors.black87,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          color: Colors.grey[200],
                        ),
                        Text(
                          "الرخص المتاحة",
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          height: 200,
                          child: ListView.builder(
                              padding: EdgeInsets.all(8),
                              physics: BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemCount: 2,
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                    height: 200,
                                    width: 300,
                                    margin: EdgeInsets.symmetric(horizontal: 4),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: AssetImage(
                                              "assets/images/webp.png"),
                                        )));
                              }),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        // Text(
                        //   "البطاقات البنكية المحفوظة",
                        //   style: TextStyle(
                        //     color: Colors.black87,
                        //     fontSize: 16,
                        //     fontWeight: FontWeight.bold,
                        //   ),
                        // ),
                        // Container(
                        //   height: 210,
                        //   child: ListView.builder(
                        //       padding: EdgeInsets.all(8),
                        //       physics: BouncingScrollPhysics(),
                        //       scrollDirection: Axis.horizontal,
                        //       itemCount: 2,
                        //       itemBuilder: (BuildContext context, int index) {
                        //         return buildPaymentCard(
                        //             paymentCards[index]["cardNumber"],
                        //             paymentCards[index]["cardHolderName"],
                        //             paymentCards[index]["topLeftColor"],
                        //             paymentCards[index]["bottomRightColor"],
                        //             paymentCards[index]["creditCardType"]);
                        //       }),
                        // ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Map> paymentCards = [
    {
      "cardHolderName": 'Abdulrahman',
      "cardNumber": '1234 5678 9012 3456',
      "validThru": '10/24',
      "creditCardType": CreditCardType.visa,
      "topLeftColor": Colors.blue,
      "bottomRightColor": Colors.blue,
    },
    {
      "cardHolderName": 'Abdulrahman',
      "cardNumber": '5555 5678 9012 6789',
      "validThru": '10/24',
      "creditCardType": CreditCardType.mastercard,
      "topLeftColor": Colors.black,
      "bottomRightColor": const Color.fromARGB(255, 53, 53, 53),
    },
  ];

  Widget buildPaymentCard(String cardNumber, String name, Color topLeftColor,
      Color bottomRightColor, CreditCardType creditCardType) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: CreditCardUi(
        cardHolderFullName: '$name',
        cardNumber: '$cardNumber',
        validThru: '10/24',
        creditCardType: creditCardType,
        topLeftColor: topLeftColor,
        bottomRightColor: bottomRightColor,
      ),
    );
  }
}
