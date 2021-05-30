import 'dart:convert';

import 'package:audiobook/utils/appTheme.dart';
import 'package:audiobook/utils/size_config.dart';
import 'package:flutter/material.dart';

class Authors extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: kToolbarHeight,
            width: SizeConfig.width,
            margin: EdgeInsets.symmetric(vertical: 20),
            child: ListView.builder(
                itemCount: 26,
                scrollDirection: Axis.horizontal,
                itemBuilder: (ctx, i) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: CircleAvatar(
                      radius: 35,
                      backgroundColor: AppTheme().primaryColor.withOpacity(0.2),
                      child: Text(
                        String.fromCharCode(i + 65),
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}
