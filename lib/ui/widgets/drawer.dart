import 'dart:async';

import 'package:audiobook/main.dart';
import 'package:audiobook/services/authentication_service.dart';
import 'package:audiobook/services/database.dart';
import 'package:audiobook/ui/screens/Onboarding/username.dart';
import 'package:audiobook/ui/screens/Onboarding/verify_email.dart';
import 'package:audiobook/utils/constants.dart';
import 'package:audiobook/utils/size_config.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class FDrawer extends StatefulWidget {
  @override
  _FDrawerState createState() => _FDrawerState();
}

class _FDrawerState extends State<FDrawer> {
  bool isVerifying = false;
  bool isVerified = false;
  Timer timer;
  String name = "";

  @override
  void initState() {
    context.read<AuthenticaitonService>().checkEmailVerified().then((value) {
      if (value == "success") {
        setState(() {
          isVerified = true;
        });
      }
    });
    name = context.read<AuthenticaitonService>().currentUser.username;
    super.initState();
  }

  @override
  void dispose() {
    if (timer != null) timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AuthenticaitonService user = context.read<AuthenticaitonService>();
    return Drawer(
      elevation: 0,
      child: Container(
        child: Column(
          children: [
            SizedBox(
              height: kToolbarHeight,
            ),
            drawerHeader(context, user),
            Expanded(
              child: drawerBody(context),
            ),
            drawerFooter(context),
          ],
        ),
      ),
    );
  }

  Widget drawerHeader(BuildContext context, AuthenticaitonService user) {
    return Container(
      height: SizeConfig.height * 0.2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: SizeConfig.width * 0.2,
            width: SizeConfig.width * 0.2,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                  image: CachedNetworkImageProvider(
                    //   user.currentUser.photoUrl ??
                    "https://image.freepik.com/free-vector/kid-world-book-day_24908-59754.jpg",
                  ),
                  fit: BoxFit.cover),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                name,
                style: Theme.of(context).textTheme.headline5.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
              ),
              SizedBox(
                width: 10,
              ),
              isVerified
                  ? Icon(Icons.verified, color: Theme.of(context).primaryColor)
                  : SizedBox(),
            ],
          ),
        ],
      ),
    );
  }

  Widget drawerBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: Column(
        children: [
          ListTile(
            leading: Icon(Icons.account_circle_rounded),
            title: Text("Get a username"),
            onTap: () => Navigator.push(
                context, MaterialPageRoute(builder: (ctx) => Username())),
          ),
          // isVerified
          //     ? SizedBox()
          //     :
          ListTile(
            leading:
                //  isVerifying
                //     ? CircularProgressIndicator(
                //         strokeWidth: 2,
                //       )
                //     :
                Icon(
              Icons.verified_rounded,
            ),
            title: Text("Verify your email"),
            onTap: () => Navigator.push(
                context, MaterialPageRoute(builder: (ctx) => VerifyEmail())),
            // onTap: () {
            //   setState(() {
            //     isVerifying = true;
            //   });
            //   context.read<AuthenticaitonService>().verifyEmail();
            //   timer = Timer.periodic(Duration(seconds: 3), (timer) {
            //     print("verifying");
            //     context
            //         .read<AuthenticaitonService>()
            //         .checkEmailVerified()
            //         .then((value) {
            //       if (value == "success") {
            //         if (timer != null) timer.cancel();
            //         setState(() {
            //           isVerifying = false;
            //           isVerified = true;
            //         });
            //       }
            //     });
            //   });
            // },
          ),
          ListTile(
            leading: Icon(Icons.bar_chart_rounded),
            title: Text("Activity"),
          ),
          ListTile(
              leading: SvgPicture.asset("assets/svgs/crown.svg",
                  height: 20, width: 20),
              title: Text("Become Premium")),
          ListTile(
            leading: SvgPicture.asset("assets/svgs/settings.svg",
                height: 20, width: 20),
            title: Text("Settings"),
          ),
          ListTile(
            leading: SvgPicture.asset("assets/svgs/library.svg",
                height: 20, width: 20),
            title: Text("Recommed a book"),
          ),
          SizedBox(
            height: 40,
          ),
          ListTile(
            leading: Icon(Icons.star_border_rounded),
            title: Text("Rate Paperid"),
          ),
          ListTile(
            leading: Icon(Icons.fence_rounded),
            title: Text("Feedback"),
          ),
          SizedBox(
            height: 40,
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text("Log Out"),
            onTap: () => context
                .read<AuthenticaitonService>()
                .signOut()
                .then(
                  (value) => Navigator.pushNamedAndRemoveUntil(context,
                      AuthenticationWrapper.routeName, (route) => false),
                )
                .then(
                  (value) => Navigator.pop(context),
                ),
          ),
        ],
      ),
    );
  }

  Widget drawerFooter(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset(
          kAppLogoColoured,
          height: 50,
        ),
        SizedBox(
          height: 10,
        ),
        Text("Version 0.0.1"),
        SizedBox(height: 40)
      ],
    );
  }
}
