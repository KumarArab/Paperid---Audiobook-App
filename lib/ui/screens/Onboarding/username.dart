import 'package:audiobook/services/authentication_service.dart';
import 'package:audiobook/services/database.dart';
import 'package:audiobook/ui/widgets/raised_button.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class Username extends StatefulWidget {
  @override
  _UsernameState createState() => _UsernameState();
}

class _UsernameState extends State<Username> {
  TextEditingController email = TextEditingController();

  final regex = RegExp(r"^(?=[a-zA-Z0-9._]{4,20}$)(?!.*[_.]{2})[^_.].*[^_.]$");
  bool isValid;
  bool isLoading = false;
  void validate(String value) {
    setState(() {
      isLoading = true;
      if (value == "" || value == null)
        isValid = null;
      else if (regex.hasMatch(value)) {
        FDatabase().isUsernameAvailable(value).then((value) => isValid = value);
      } else
        isValid = false;
      isLoading = false;
    });
  }

  Widget showResult() {
    if (isLoading) {
      return CircularProgressIndicator(
        strokeWidth: 2,
      );
    } else if (isValid == true)
      return Text("${email.text} is available",
          style: TextStyle(color: Colors.green));
    else if (isValid == false)
      return Text("${email.text} is invalid username",
          style: TextStyle(color: Colors.red));
    return SizedBox();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Enter your username",
              style: Theme.of(context).textTheme.headline4.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
            SizedBox(
              height: 24,
            ),
            Container(
              padding: EdgeInsets.only(top: 30, bottom: 10),
              child: TextFormField(
                controller: email,
                cursorColor: Colors.black,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: "username",
                  prefixIcon: Icon(Icons.account_circle_rounded),
                ),
                onChanged: (value) {
                  validate(value);
                },
              ),
            ),
            Padding(
                padding: EdgeInsets.only(bottom: 24, left: 8),
                child: showResult()),
            FRaisedButton(
              child: Text(
                "Set username",
                style: Theme.of(context).textTheme.headline5.copyWith(
                      color: Colors.white,
                    ),
              ),
              onPressed: () {
                // setState(() {
                //   _isVerifying = true;
                // });
                print("All good");
              },
            ),
            SizedBox(
              height: 24,
            ),
            // _isVerified
            //     ? Icon(Icons.verified, color: Colors.green)
            //     : SizedBox(),
          ],
        ),
      ),
    );
  }
}
