import 'dart:async';

import 'package:audiobook/services/authentication_service.dart';
import 'package:audiobook/ui/widgets/raised_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class VerifyEmail extends StatefulWidget {
  static const routeName = '/verifyEmail';
  @override
  _VerifyEmailState createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  User firebaseUser;
  TextEditingController email;
  final _formKey = GlobalKey<FormState>();
  Timer timer;
  bool _isVerifying = false;
  bool _isVerified = false;
  bool isGmailVerifying = false;

  @override
  void dispose() {
    if (timer != null) timer.cancel();
    print("disposed");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    firebaseUser = context.watch<User>();

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Enter your email",
                  style: Theme.of(context).textTheme.headline4.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
                SizedBox(
                  height: 24,
                ),
                Form(
                  key: _formKey,
                  child: Container(
                    padding: EdgeInsets.only(top: 30, bottom: 10),
                    child: TextFormField(
                      controller: email,
                      cursorColor: Colors.black,
                      keyboardType: TextInputType.text,
                      validator: (val) {
                        if (val == null || val == "") {
                          return "Please enter an email";
                        } else if (!RegExp(
                                r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                            .hasMatch(val)) {
                          return "Enter a valid email";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          labelText: "email",
                          prefixIcon: Icon(Icons.email_rounded)),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 24),
                  child: Text(
                      "We'll send you a confirmation link. click on the link to verify your account"),
                ),
                FRaisedButton(
                  child: Text(
                    "Verify my email",
                    style: Theme.of(context).textTheme.headline5.copyWith(
                          color: Colors.white,
                        ),
                  ),
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      setState(() {
                        _isVerifying = true;
                      });
                      // context.read<AuthenticaitonService>().verifyEmail();
                      // timer = Timer.periodic(Duration(seconds: 3), (timer) {
                      //   checkIfEmailVerified();
                      // });

                      context.read<AuthenticaitonService>().verifyEmail();
                      timer = Timer.periodic(Duration(seconds: 3), (timer) {
                        print("verifying");
                        context
                            .read<AuthenticaitonService>()
                            .checkEmailVerified()
                            .then((value) {
                          if (value == "success") {
                            if (timer != null) timer.cancel();
                            setState(() {
                              _isVerifying = false;
                              _isVerified = true;
                            });
                          }
                        });
                      });
                    }
                  },
                ),
                Container(
                  padding: EdgeInsets.all(20),
                  child: Center(
                    child: Text(
                      "or",
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1
                          .copyWith(color: Colors.black),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isGmailVerifying = true;
                    });
                    context
                        .read<AuthenticaitonService>()
                        .verifyGmail()
                        .then((value) {
                      print(value);
                      setState(() {
                        isGmailVerifying = false;
                      });
                    });
                  },
                  child: Container(
                    height: 60,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Theme.of(context).primaryColor.withOpacity(0.1),
                    ),
                    alignment: Alignment.center,
                    child: isGmailVerifying
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset("assets/svgs/google.svg",
                                  height: 20, width: 20),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Verify with Google",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6
                                    .copyWith(color: Colors.black),
                              ),
                            ],
                          ),
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                _isVerified
                    ? Icon(Icons.verified, color: Colors.green)
                    : SizedBox(),
              ],
            ),
          ),
          _isVerifying
              ? Container(
                  color: Colors.white.withOpacity(0.5),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : SizedBox()
        ],
      ),
    );
  }
}
