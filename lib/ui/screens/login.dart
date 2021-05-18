import 'package:audiobook/services/authentication_service.dart';
import 'package:audiobook/ui/widgets/button.dart';
import 'package:audiobook/ui/widgets/textbox.dart';
import 'package:audiobook/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class Login extends StatelessWidget {
  final TextEditingController email = new TextEditingController();
  final TextEditingController password = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
          height: SizeConfig.height,
          width: SizeConfig.width,
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Spacer(flex: 1),
              Center(
                  child: Text("Sign In",
                      style: Theme.of(context).textTheme.headline2)),
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
                  text: "Forgot Password?", color: Theme.of(context).hintColor),
              SizedBox(height: 20),
              Button(
                  text: "Login",
                  onPressed: () {
                    print(email.text);
                    print(password.text);
                    context
                        .read<AuthenticaitonService>()
                        .signIn(email.text, password.text);
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
                  context.read<AuthenticaitonService>().login();
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
                              style:
                                  Theme.of(context).textTheme.button.copyWith(
                                        color: Colors.black,
                                      ),
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
                  TextButton(onPressed: () {}, child: Text("Sign Up")),
                ],
              ),
              SizedBox(height: 10),
              Spacer(flex: 2),
            ],
          )),
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
