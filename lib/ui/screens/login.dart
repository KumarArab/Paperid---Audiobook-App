import 'package:audiobook/services/authentication_service.dart';
import 'package:audiobook/services/google_signin_service.dart';
import 'package:audiobook/ui/widgets/textbox.dart';
import 'package:audiobook/utils/size_config.dart';
import 'package:audiobook/utils/style.dart';
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
            children: [
              Spacer(flex: 1),
              Text("Sign In", style: Theme.of(context).textTheme.headline1),
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
              Link(text: "Forgot Password?", color: Color(0xffAAAAAA)),
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
              TextButton(
                onPressed: () {
                  context.read<AuthenticaitonService>().login();
                },
                child: Container(
                  height: 60,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Style.backgroundColor,
                  ),
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset("assets/svgs/google.svg",
                          height: 20, width: 20),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Sign in with Google",
                        style: Theme.of(context).textTheme.button.copyWith(
                              color: Colors.black,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 50),
              Link(text: "Don't have an account?", color: Color(0xffAAAAAA)),
              SizedBox(height: 10),
              Link(text: "Sign up", color: Colors.black),
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
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: Theme.of(context).textTheme.subtitle1.copyWith(color: color),
          ),
          Spacer()
        ],
      ),
    );
  }
}

class LoginOption extends StatelessWidget {
  final String text;
  final Color color;

  LoginOption({this.text, this.color});
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Style.backgroundColor,
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          style: Theme.of(context).textTheme.button.copyWith(
                color: color,
              ),
        ),
      ),
    );
  }
}

class Button extends StatelessWidget {
  final String text;
  final Function onPressed;
  Button({@required this.text, @required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 70,
      decoration: BoxDecoration(
        color: Color(0xff455A6F),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
