import 'package:audiobook/ui/widgets/flat_button.dart';
import 'package:audiobook/ui/widgets/raised_button.dart';
import 'package:flutter/material.dart';

class Genres extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.all(20),
            child: Row(
              children: [
                Expanded(
                  child: FRaisedButton(
                    child: Text(
                      "Fiction",
                      style: Theme.of(context).textTheme.headline6.copyWith(
                          color: Colors.white, fontWeight: FontWeight.w500),
                    ),
                    onPressed: () {},
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: FFlatButton(
                    onTap: () {},
                    text: "Non-Fiction",
                  ),
                ),
                // Container(
                //   height: 60,
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(15),
                //     color: Theme.of(context).primaryColor.withOpacity(0.3),
                //   ),
                //   alignment: Alignment.center,
                //   child: Text(
                //     "Sign in with Google",
                //     style: Theme.of(context)
                //         .textTheme
                //         .headline6
                //         .copyWith(color: Colors.black),
                //   ),
                // )
              ],
            ),
          )
        ],
      ),
    );
  }
}
