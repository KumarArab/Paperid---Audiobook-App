import 'package:audiobook/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:audiobook/utils/appTheme.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';

class SnackToast {
  showErrorToast(String text) {
    return Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: AppTheme().primaryColor,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  showSuccessToast(String text) {
    return Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: AppTheme().mulledWineColor,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  showLoadingAsset() {
    return Image.asset(
      "assets/images/loading.gif",
      width: SizeConfig.width * 0.4,
    );
  }
}
