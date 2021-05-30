import 'package:audiobook/utils/appTheme.dart';
import 'package:flutter/material.dart';

class ForYou extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.all(20),
            height: kToolbarHeight,
            child: Row(
              children: [
                Text(
                  "Currently Reading",
                  style: Theme.of(context).textTheme.headline5.copyWith(
                      fontWeight: FontWeight.w700, color: Colors.black),
                ),
                Spacer(),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    "View All",
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1
                        .copyWith(color: AppTheme().primaryColor),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
