import 'package:audiobook/ui/screens/Onboarding/onboard.dart';
import 'package:audiobook/utils/appTheme.dart';
import 'package:audiobook/utils/constants.dart';
import 'package:audiobook/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Splash extends StatelessWidget {
  static const routName = '/splash';
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Container(
        height: SizeConfig.height,
        width: SizeConfig.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xff4274fe), Color(0xff9571F6)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        alignment: Alignment.center,
        child: GestureDetector(
          onTap: () => Navigator.push(
              context, MaterialPageRoute(builder: (ctx) => Onboard())),
          child: SvgPicture.asset(
            kAppLogoWhite,
          ),
        ),
      ),
    );
  }
}
