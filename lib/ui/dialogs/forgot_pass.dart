import 'package:audiobook/services/authentication_service.dart';
import 'package:audiobook/ui/widgets/raised_button.dart';
import 'package:audiobook/utils/size_config.dart';
import 'package:audiobook/utils/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class ForgotPass extends StatefulWidget {
  @override
  _ForgotPassState createState() => _ForgotPassState();
}

class _ForgotPassState extends State<ForgotPass> {
  final TextEditingController email = new TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Wrap(
        children: [
          Column(
            children: [
              SvgPicture.asset(
                "assets/svgs/logo.svg",
                height: SizeConfig.height * 0.05,
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    "Reset Password",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline4.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
              ),
              Text("We'll send you a reset password link to this email"),
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
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 8,
              ),
              FRaisedButton(
                  child: context.read<AuthenticaitonService>().isResettingPass
                      ? CircularProgressIndicator()
                      : Expanded(
                          child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            "Send me the link",
                            style: Theme.of(context)
                                .textTheme
                                .headline6
                                .copyWith(color: Colors.white),
                          ),
                        )),
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      FocusScope.of(context).unfocus();

                      context
                          .read<AuthenticaitonService>()
                          .requestPassReset(email.text.trim())
                          .then((value) {
                        if (value == "success") {
                          Navigator.pop(context);
                          SnackToast()
                              .showSuccessToast("Link sent Successfully");
                          //Navigator.pushReplacementNamed(context, '/home');
                        } else {
                          SnackToast().showErrorToast("Snap! $value");
                        }
                      });
                    }
                  }),
            ],
          )
        ],
      ),
    );
  }
}
