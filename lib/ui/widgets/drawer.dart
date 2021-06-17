import 'package:audiobook/main.dart';
import 'package:audiobook/services/authentication_service.dart';
import 'package:audiobook/utils/constants.dart';
import 'package:audiobook/utils/size_config.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class FDrawer extends StatelessWidget {
  AuthenticaitonService user;
  @override
  Widget build(BuildContext context) {
    user = context.read<AuthenticaitonService>();
    return Drawer(
      elevation: 0,
      child: Container(
        child: Column(
          children: [
            SizedBox(
              height: kToolbarHeight,
            ),
            drawerHeader(context),
            Expanded(
              child: drawerBody(context),
            ),
            drawerFooter(context),
          ],
        ),
      ),
    );
  }

  Widget drawerHeader(BuildContext context) {
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
                    user.currentUser.photoUrl ??
                        "https://image.freepik.com/free-vector/kid-world-book-day_24908-59754.jpg",
                  ),
                  fit: BoxFit.cover),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            user.currentUser.name,
            style: Theme.of(context).textTheme.headline5.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          )
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
              leading: Icon(Icons.bar_chart_rounded), title: Text("Activity")),
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
