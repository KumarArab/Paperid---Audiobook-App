import 'dart:async';

import 'package:audiobook/services/authentication_service.dart';
import 'package:audiobook/ui/widgets/raised_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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

  checkIfEmailVerified() async {
    print("verifying");
    await firebaseUser.reload();
    if (firebaseUser.emailVerified) {
      if (timer != null) timer.cancel();
      setState(() {
        _isVerifying = false;
        _isVerified = true;
      });
    }
  }

  @override
  void dispose() {
    if (timer != null) timer.cancel();
    print("disposed");
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    email = new TextEditingController(text: firebaseUser.email);
    checkIfEmailVerified();
    super.didChangeDependencies();
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
                      print("All good");
                      context.read<AuthenticaitonService>().verifyEmail();
                      timer = Timer.periodic(Duration(seconds: 3), (timer) {
                        checkIfEmailVerified();
                      });
                    }
                  },
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
                  color: Colors.white.withOpacity(0.4),
                  child: Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      backgroundColor: Colors.black,
                    ),
                  ),
                )
              : SizedBox()
        ],
      ),
    );
  }
}
