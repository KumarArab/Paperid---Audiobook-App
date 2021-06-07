import 'package:audiobook/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextBox extends StatelessWidget {
  final String label;
  final bool isObsecure;
  final TextEditingController controller;
  final Function onChanged;
  final FocusNode focusNode;

  TextBox(
      {this.controller,
      this.isObsecure,
      this.label,
      this.onChanged,
      this.focusNode});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 30, bottom: 10),
      child: TextField(
        onChanged: (val) => onChanged(val),
        onTap: () {
          if (!focusNode.hasPrimaryFocus) {
            focusNode.unfocus();
          }
        },
        obscureText: isObsecure,
        controller: controller,
        cursorColor: Colors.black,
        focusNode: focusNode,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          labelText: label,
        ),
      ),
    );
  }
}
