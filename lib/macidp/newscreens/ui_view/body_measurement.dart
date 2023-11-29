import 'package:flutter/material.dart';
import 'package:macidp/macidp/newscreens/app_theme.dart';

class BodyMeasurementView extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          left: 24, right: 24, top: 16, bottom: 18),
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8.0),
              bottomLeft: Radius.circular(8.0),
              bottomRight: Radius.circular(8.0),
              topRight: Radius.circular(68.0)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: AppTheme.grey.withOpacity(0.2),
                offset: Offset(1.1, 1.1),
                blurRadius: 10.0),
          ],
        ),
        child: Column(
          children: <Widget>[
            Padding(
              padding:
                  const EdgeInsets.only(top: 16, left: 16, right: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 4, bottom: 8, top: 16),
                    child: Text(
                      'About Us',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: AppTheme.fontName,
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          letterSpacing: -0.1,
                          color: AppTheme.darkText),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                          child: Image.asset("assets/images/webp.png",scale: 3.4,)),
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 24, right: 24, top: 8, bottom: 8),
              child: Container(
                height: 2,
                decoration: BoxDecoration(
                  color: AppTheme.background,
                  borderRadius: BorderRadius.all(Radius.circular(4.0)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 14, right: 24, top: 8, bottom: 5),
              child: Text("Gives you quality services at the best prices.",style: TextStyle(fontWeight: FontWeight.bold),),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 24, right: 24, bottom: 16),
              child: Text("Since its establishment in 2005, the Middle East Automobile and Tourism Club has played a leading role in the development of motorsports in the Kingdom as the first Saudi club to obtain a license to hold car and motorcycle races (rallies) from the General Presidency of Youth Welfare, in addition to obtaining license No.",style: TextStyle(fontSize: 12),),
            ),
          ],
        ),
      ),
    );
  }
}
