import 'package:flutter/material.dart';
import 'package:macidp/main.dart';

class GlassView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(
              left: 24, right: 24, top: 0, bottom: 24),
          child: Stack(
            clipBehavior: Clip.none,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Container(
                  decoration: BoxDecoration(
                    color: HexColor("#D7E0F9"),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8.0),
                        bottomLeft: Radius.circular(8.0),
                        bottomRight: Radius.circular(8.0),
                        topRight: Radius.circular(8.0)),
                    // boxShadow: <BoxShadow>[
                    //   BoxShadow(
                    //       color: FitnessAppTheme.grey.withOpacity(0.2),
                    //       offset: Offset(1.1, 1.1),
                    //       blurRadius: 10.0),
                    // ],
                  ),
                  child: Column(
                    children: <Widget>[
                      Row(children: [
                        Expanded(child: SizedBox()),
                        Expanded(child: Image.asset("assets/images/spon1.png",scale: 2,)),
                        Expanded(child: Image.asset("assets/images/spon2.png",scale: 2,)),
                        Expanded(child: Image.asset("assets/images/spon3.png",scale: 2,)),
                        Expanded(child: Image.asset("assets/images/spon4.png",scale: 2,)),
                        Expanded(child: SizedBox())
                      ],),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
