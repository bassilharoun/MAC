import 'package:flutter/material.dart';
import 'package:macidp/macidp/newscreens/app_theme.dart';

class TitleView extends StatelessWidget {
  final String? titleTxt;
  final String? subTxt;

  const TitleView(
      {Key? key,
      this.titleTxt,
      this.subTxt ,
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(left: 24, right: 24),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Text(
                titleTxt!,
                textAlign: TextAlign.left,
                style: const TextStyle(
                  fontFamily: AppTheme.fontName,
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                  letterSpacing: 0.5,
                  color: AppTheme.lightText,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
