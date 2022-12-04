import 'package:audiobook/services/authentication_service.dart';
import 'package:audiobook/services/database.dart';
import 'package:audiobook/ui/widgets/raised_button.dart';
import 'package:audiobook/ui/widgets/textbox.dart';
import 'package:audiobook/utils/appTheme.dart';
import 'package:audiobook/utils/size_config.dart';
import 'package:audiobook/utils/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class SignUp extends StatefulWidget {
  static const String routeName = "/signup";

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController name = new TextEditingController();
  final TextEditingController email = new TextEditingController();
  final TextEditingController password = new TextEditingController();
  final TextEditingController cpassword = new TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
            height: SizeConfig.height,
            width: SizeConfig.width,
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: kToolbarHeight,
                ),
                Spacer(),
                SvgPicture.asset(
                  "assets/svgs/logo.svg",
                  height: SizeConfig.height * 0.05,
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      "Signup",
                      style: Theme.of(context).textTheme.headline3.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                            vertical: SizeConfig.width * 0.02),
                        child: TextFormField(
                          controller: name,
                          cursorColor: Colors.black,
                          keyboardType: TextInputType.text,
                          validator: (val) {
                            if (val == null || val == "") {
                              return "Please enter your sweet name";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              labelText: "Name",
                              prefixIcon: Icon(Icons.account_circle_rounded)),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            vertical: SizeConfig.width * 0.02),
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
                      Container(
                        padding: EdgeInsets.symmetric(
                            vertical: SizeConfig.width * 0.02),
                        child: TextFormField(
                          controller: password,
                          cursorColor: Colors.black,
                          obscureText: true,
                          keyboardType: TextInputType.text,
                          validator: (val) {
                            if (val == null || val == "") {
                              return "Please enter the password";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              labelText: "password",
                              prefixIcon: Icon(Icons.security_rounded)),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            vertical: SizeConfig.width * 0.02),
                        child: TextFormField(
                          controller: cpassword,
                          cursorColor: Colors.black,
                          obscureText: true,
                          keyboardType: TextInputType.text,
                          validator: (val) {
                            if (val == null || val == "") {
                              return "Please enter the password";
                            } else if (cpassword.text != password.text) {
                              return "password does not match";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              labelText: "Confirm password",
                              prefixIcon: Icon(Icons.confirmation_num_rounded)),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                FRaisedButton(
                    child:
                        Provider.of<AuthenticaitonService>(context).isSigningUp
                            ? CircularProgressIndicator()
                            : Text(
                                "Sign Up",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6
                                    .copyWith(color: Colors.white),
                              ),
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        FocusScope.of(context).unfocus();
                        context
                            .read<AuthenticaitonService>()
                            .signUp(name.text, email.text, password.text)
                            .then((value) {
                          if (value == "success") {
                            SnackToast()
                                .showSuccessToast("Signed up successfully");
                            Navigator.pop(context);
                          } else {
                            SnackToast().showErrorToast("Oops! $value");
                          }
                        });
                      }
                    }),
                SizedBox(height: 16),
                Container(
                  width: SizeConfig.width,
                  child: Wrap(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "By Signing up, I agree all the",
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1
                            .copyWith(color: Theme.of(context).hintColor),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          "terms and conditions",
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1
                              .copyWith(color: AppTheme().primaryColor),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Spacer(flex: 2),
              ],
            )),
      ),
    );
  }
}
