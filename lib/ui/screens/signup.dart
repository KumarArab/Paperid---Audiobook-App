import 'package:audiobook/services/authentication_service.dart';
import 'package:audiobook/services/database.dart';
import 'package:audiobook/ui/widgets/button.dart';
import 'package:audiobook/ui/widgets/textbox.dart';
import 'package:audiobook/utils/size_config.dart';
import 'package:flutter/material.dart';
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
                  child: Text("Sign Up",
                      style: Theme.of(context).textTheme.headline2)),
              Spacer(flex: 1),
              TextBox(
                isObsecure: false,
                label: "Name",
                controller: name,
              ),
              TextBox(
                isObsecure: false,
                label: "email",
                controller: email,
              ),
              TextBox(
                isObsecure: true,
                label: "Password",
                controller: password,
              ),
              TextBox(
                isObsecure: true,
                label: "Confirm Password",
                controller: cpassword,
              ),
              SizedBox(height: 20),
              Button(
                  child: Provider.of<AuthenticaitonService>(context).isSigningUp
                      ? CircularProgressIndicator()
                      : Text(
                          "Sign Up",
                          style: TextStyle(color: Colors.white),
                        ),
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    if (password.text == cpassword.text) {
                      context
                          .read<AuthenticaitonService>()
                          .signUp(name.text, email.text, password.text)
                          .then((value) {
                        if (value == "success") {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("Signed up successfully")));
                          Navigator.pop(context);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Oops! $value")));
                        }
                      });
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Passwords do not match!!"),
                      ));
                    }
                  }),
              SizedBox(height: 50),
              Row(
                children: [
                  Text(
                    "By Signing up, I agree all the ",
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1
                        .copyWith(color: Theme.of(context).hintColor),
                  ),
                  TextButton(
                      onPressed: () => FDatabase()
                          .getUserInfo("h1gzDK0tcXem4BQ4gJdwrc4xvZ33"),
                      child: Text("terms and conditions")),
                ],
              ),
              SizedBox(height: 10),
              Spacer(flex: 2),
            ],
          )),
    );
  }
}
