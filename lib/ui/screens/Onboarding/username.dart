import 'package:audiobook/services/authentication_service.dart';
import 'package:audiobook/services/database.dart';
import 'package:audiobook/ui/screens/Onboarding/verify_email.dart';
import 'package:audiobook/ui/widgets/raised_button.dart';
import 'package:audiobook/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Username extends StatefulWidget {
  @override
  _UsernameState createState() => _UsernameState();
}

class _UsernameState extends State<Username> {
  TextEditingController email = TextEditingController();

  final regex = RegExp(r"^(?!\.)(?!.*\.$)(?!.*?\.\.)[a-z0-9.]{4,20}$");
  bool isValid;
  bool isLoading = false;
  bool isUpdating = false;
  bool isUpdated = false;
  void validate(String value) async {
    setState(() {
      isLoading = true;
    });
    if (value == "" || value == null)
      setState(() {
        isValid = null;
      });
    else if (regex.hasMatch(value)) {
      bool res =
          await FDatabase().isUsernameAvailable(value.replaceAll('.', '@'));
      setState(() {
        isValid = res;
      });
    } else {
      setState(() {
        isValid = false;
      });
    }
    setState(() {
      isLoading = false;
    });
  }

  Widget showResult() {
    if (isLoading) {
      return Container(
        height: 16,
        width: 16,
        child: CircularProgressIndicator(
          strokeWidth: 2,
        ),
      );
    } else if (isValid == true)
      return Text("${email.text} is available",
          style: TextStyle(color: Colors.green, fontWeight: FontWeight.w500));
    else if (isValid == false)
      return Text("${email.text} is not available",
          style: TextStyle(color: Colors.red, fontWeight: FontWeight.w500));
    return SizedBox(
      height: 16,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
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
                  child: Row(
                    children: [
                      Expanded(
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
                    ],
                  ),
                ),
                Container(
                    padding: EdgeInsets.only(bottom: 24, left: 8),
                    height: 40,
                    child: showResult()),
                FRaisedButton(
                  child: Text(
                    "Set username",
                    style: Theme.of(context).textTheme.headline5.copyWith(
                          color: Colors.white,
                        ),
                  ),
                  onPressed: () {
                    setState(() {
                      isUpdating = true;
                    });
                    print("All good");
                    String userId =
                        context.read<AuthenticaitonService>().currentUser.uid;
                    FDatabase()
                        .setUsername(email.text.replaceAll('.', '@'), userId)
                        .then((value) {
                      setState(() {
                        isUpdating = false;
                        isUpdated = true;
                        print(value);
                      });
                    });
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
          isUpdated
              ? Container(
                  color: Colors.white.withOpacity(0.8),
                  padding: EdgeInsets.all(SizeConfig.width * 0.25),
                  width: SizeConfig.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.verified_rounded,
                        color: Colors.green,
                        size: 50,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text("Username successfully updated"),
                      ),
                      FRaisedButton(
                          child: Text(
                            "Next",
                            style:
                                Theme.of(context).textTheme.headline5.copyWith(
                                      color: Colors.white,
                                    ),
                          ),
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (ctx) => VerifyEmail(),
                              ),
                            );
                          })
                    ],
                  ),
                )
              : SizedBox(),
        ],
      ),
    );
  }
}
