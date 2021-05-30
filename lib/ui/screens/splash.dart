import 'package:audiobook/utils/appTheme.dart';
import 'package:audiobook/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Container(
        height: SizeConfig.height,
        width: SizeConfig.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppTheme().primaryColor, AppTheme().secondaryColor],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        alignment: Alignment.center,
        child: SvgPicture.asset(
          'assets/svgs/logo.svg',
        ),
      ),
    );
  }
}
