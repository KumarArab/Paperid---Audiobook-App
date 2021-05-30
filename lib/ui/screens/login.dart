import 'package:audiobook/services/authentication_service.dart';
import 'package:audiobook/ui/widgets/button.dart';
import 'package:audiobook/ui/widgets/textbox.dart';
import 'package:audiobook/utils/appTheme.dart';
import 'package:audiobook/utils/constants.dart';
import 'package:audiobook/utils/size_config.dart';
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
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldMessengerKey,
      body: SafeArea(
        child: Container(
            width: SizeConfig.width,
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: kToolbarHeight,
                ),
                Center(
                  child: Text("Login",
                      style: Theme.of(context).textTheme.headline3.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          )),
                ),
                Spacer(flex: 1),
                TextBox(
                  isObsecure: false,
                  label: "Username",
                  controller: email,
                ),
                TextBox(
                  isObsecure: true,
                  label: "Password",
                  controller: password,
                ),
                Link(
                    text: "Forgot Password?",
                    color: Theme.of(context).hintColor),
                SizedBox(height: 20),
                Button(
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
                      print(email.text);
                      print(password.text);
                      context
                          .read<AuthenticaitonService>()
                          .signIn(email.text, password.text)
                          .then((value) {
                        if (value == "success") {
                          Fluttertoast.showToast(
                              msg: "Log in success",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.green,
                              textColor: Colors.white,
                              fontSize: 16.0);
                          //Navigator.pushReplacementNamed(context, '/home');
                        } else {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(SnackBar(content: Text(value)));
                        }
                      });
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
                TextButton(
                  onPressed: () {
                    context.read<AuthenticaitonService>().login().then((value) {
                      if (value == "success") {
                        scaffoldMessengerKey.currentState.showSnackBar(
                            SnackBar(content: Text("Signed in successfully")));

                        //Navigator.pushReplacementNamed(context, '/home');
                      } else {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: Text(value)));
                      }
                    });
                  },
                  child: Container(
                    height: 60,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Theme.of(context).canvasColor,
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
                SizedBox(height: 10),
                Spacer(flex: 2),
              ],
            )),
      ),
    );
  }
}

class Link extends StatelessWidget {
  final String text;
  final Color color;

  Link({this.text, this.color});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.subtitle1.copyWith(color: color),
    );
  }
}
