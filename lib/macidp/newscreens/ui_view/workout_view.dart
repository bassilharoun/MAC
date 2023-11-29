import 'package:flutter/material.dart';
import 'package:macidp/main.dart';
import '../app_theme.dart';

class WorkoutView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 24, right: 24, top: 16, bottom: 18),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [AppTheme.nearlyDarkBlue, HexColor("#6F56E8")],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8.0),
              bottomLeft: Radius.circular(8.0),
              bottomRight: Radius.circular(8.0),
              topRight: Radius.circular(68.0)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: AppTheme.grey.withOpacity(0.6),
                offset: Offset(1.1, 1.1),
                blurRadius: 10.0),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'دفتر التريبتيك',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontFamily: AppTheme.fontName,
                  fontWeight: FontWeight.normal,
                  fontSize: 16,
                  letterSpacing: 0.0,
                  color: AppTheme.white,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  'دفتر التربتيك هو وثيقة ضرورية للسفر بسيارتك إلى دولة أُخرى دون مواجهة المشاكل الجمركية ؛ يعد دفتر التربتيك بالنسبة للسلطات الجمركية جواز سفر للمركبة ، حيث يجب عليك حمله معك عند السفر ، بالإضافة إلى جواز سفرك الخاص.',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontFamily: AppTheme.fontName,
                    fontWeight: FontWeight.normal,
                    fontSize: 14,
                    letterSpacing: 0.0,
                    color: Colors.grey[100],
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
