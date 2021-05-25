import 'package:flutter/material.dart';
import 'package:audiobook/utils/appTheme.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

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

  showSuccessToast(String text) {}
}
