import 'package:audiobook/utils/appTheme.dart';
import 'package:audiobook/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class FAppBar extends StatelessWidget {
  final bool isAction;
  FAppBar({@required this.isAction});

  final Shader papeGradient = LinearGradient(
    colors: <Color>[AppTheme().blueColor, AppTheme().purpleColor],
  ).createShader(new Rect.fromLTWH(0.0, 0.0, 100.0, 70.0));

  final Shader ridGradient = LinearGradient(
    colors: <Color>[AppTheme().orangeColor, AppTheme().tertiaryColor],
  ).createShader(new Rect.fromLTWH(0.0, 0.0, 10.0, 5.0));

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kToolbarHeight * 1.2,
      width: SizeConfig.width,
      padding: EdgeInsets.symmetric(horizontal: 20),
      color: Colors.white,
      child: Row(
        children: [
          Text.rich(TextSpan(
              text: "Pape",
              style: TextStyle(
                fontSize: 32,
                //color: AppTheme().primaryColor,
                fontWeight: FontWeight.w600,
                letterSpacing: 2,
                foreground: new Paint()..shader = papeGradient,
              ),
              children: [
                TextSpan(
                  text: "rid",
                  style: TextStyle(
                    fontSize: 32,
                    // color: AppTheme().tertiaryColor,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 2,
                    foreground: new Paint()..shader = ridGradient,
                  ),
                )
              ])),
          Spacer(),
          isAction
              ? GestureDetector(
                  onTap: () {
                    Scaffold.of(context).openDrawer();
                  },
                  child: SvgPicture.asset(
                    "assets/svgs/settings.svg",
                    color: AppTheme().primaryColor,
                  ),
                )
              : SizedBox()
        ],
      ),
    );
  }
}
