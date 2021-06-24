import 'package:audiobook/services/authentication_service.dart';
import 'package:audiobook/ui/dialogs/forgot_pass.dart';
import 'package:audiobook/ui/widgets/raised_button.dart';
import 'package:audiobook/ui/widgets/textbox.dart';
import 'package:audiobook/utils/appTheme.dart';
import 'package:audiobook/utils/constants.dart';
import 'package:audiobook/utils/size_config.dart';
import 'package:audiobook/utils/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  static const String routeName = "/login";

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController email = new TextEditingController();

  final TextEditingController password = new TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool showPass = false;

  void togglePass() => showPass = !showPass;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
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
                      "Login",
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
                              prefixIcon: Icon(Icons.email_rounded),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 30, bottom: 10),
                          child: TextFormField(
                            controller: password,
                            cursorColor: Colors.black,
                            obscureText: showPass,
                            keyboardType: TextInputType.text,
                            validator: (val) {
                              if (val == null || val == "") {
                                return "Please enter the password";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              labelText: "password",
                              prefixIcon: Icon(Icons.security_rounded),
                            ),
                          ),
                        ),
                      ],
                    )),
                Row(
                  children: [
                    Link(
                      text: "Forgot Password?",
                      color: Theme.of(context).primaryColor,
                      function: () => showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16)),
                          content: ForgotPass(),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                FRaisedButton(
                    child: context.read<AuthenticaitonService>().isSigningIn
                        ? CircularProgressIndicator()
                        : Text(
                            "Log in",
                            style: Theme.of(context)
                                .textTheme
                                .headline6
                                .copyWith(color: Colors.white),
                          ),
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        context
                            .read<AuthenticaitonService>()
                            .signIn(email.text, password.text)
                            .then((value) {
                          if (value == "success") {
                            SnackToast()
                                .showSuccessToast("Logged in Successfully");
                            //Navigator.pushReplacementNamed(context, '/home');
                          } else {
                            SnackToast().showErrorToast(value);
                          }
                        });
                      }
                    }),
                Container(
                  padding: EdgeInsets.only(top: 20),
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
                    context.read<AuthenticaitonService>().login().then((value) {
                      if (value == "success") {
                        SnackToast().showSuccessToast("Logged in successfully");

                        //Navigator.pushReplacementNamed(context, '/home');
                      } else {
                        SnackToast().showErrorToast("Snap! $value");
                      }
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
                    child: context.watch<AuthenticaitonService>().isGoogleLogin
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
                                "Sign in with Google",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6
                                    .copyWith(color: Colors.black),
                              ),
                            ],
                          ),
                  ),
                ),
                SizedBox(height: 50),
                Row(
                  children: [
                    Text(
                      "Don't have an account?",
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1
                          .copyWith(color: Theme.of(context).hintColor),
                    ),
                    TextButton(
                        onPressed: () =>
                            Navigator.pushNamed(context, '/signup'),
                        child: Text("Sign Up",
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1
                                .copyWith(color: AppTheme().primaryColor))),
                  ],
                ),
                SizedBox(height: 40),
                Spacer(flex: 2),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Link extends StatelessWidget {
  final String text;
  final Color color;
  final Function function;
  Link({@required this.text, @required this.color, @required this.function});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: function,
      child: Text(
        text,
        style: Theme.of(context).textTheme.subtitle1.copyWith(color: color),
      ),
    );
  }
}
