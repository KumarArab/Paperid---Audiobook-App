import 'package:audiobook/main.dart';
import 'package:audiobook/services/authentication_service.dart';
import 'package:audiobook/services/homedata.dart';
import 'package:audiobook/ui/screens/home.dart';
import 'package:audiobook/ui/widgets/book.dart';
import 'package:audiobook/ui/widgets/button.dart';
import 'package:audiobook/utils/appTheme.dart';
import 'package:audiobook/utils/size_config.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserProfile extends StatelessWidget {
  static const String routeName = "/userProfile";

  @override
  Widget build(BuildContext context) {
    AuthenticaitonService user = context.read<AuthenticaitonService>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme().primaryColor,
        elevation: 0,
        bottomOpacity: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.logout,
              color: Colors.white,
            ),
            onPressed: () => context
                .read<AuthenticaitonService>()
                .signOut()
                .then((value) => Navigator.pushNamedAndRemoveUntil(context,
                    AuthenticationWrapper.routeName, (route) => false)),
          ),
        ],
      ),
      body: Container(
        alignment: Alignment.bottomCenter,
        decoration: BoxDecoration(
          color: AppTheme().primaryColor,
        ),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.93,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              Positioned(
                bottom: 0,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.83,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Color(0xfffff8ee),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.05,
                      left: 30,
                      right: 30,
                    ),
                    child: Column(
                      children: [
                        Text(
                          user.currentUser.name,
                          style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: SizeConfig.width * 0.2,
                          child: Button(
                              child: Text(
                                "Edit",
                              ),
                              onPressed: () {}),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(
                            top: 10,
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    "TOTAL READS",
                                    style: kTitleStyle,
                                  ),
                                  Text(
                                    "FAVOURITES",
                                    style: kTitleStyle,
                                  ),
                                  Text(
                                    "REVIEWS",
                                    style: kTitleStyle,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    "127",
                                    style: kSubtitleStyle,
                                  ),
                                  Text(
                                    "83",
                                    style: kSubtitleStyle,
                                  ),
                                  Text(
                                    "47",
                                    style: kSubtitleStyle,
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.only(
                              top: 20,
                              left: 20,
                              right: 20,
                            ),
                            alignment: Alignment.bottomCenter,
                            child: ListView.builder(
                              itemBuilder: (ctx, i) => Container(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                margin: EdgeInsets.symmetric(vertical: 10),
                                height: SizeConfig.height * 0.5,
                                child: Book(
                                  coverUrl:
                                      context.read<HomeData>().books[i].cover,
                                ),
                              ),
                              itemCount: context.read<HomeData>().books.length,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                height: SizeConfig.width * 0.35,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: CachedNetworkImage(
                    imageUrl: user.currentUser.photoUrl,
                    placeholder: (context, url) => Icon(Icons.error),
                    fit: BoxFit.cover,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

final kTitleStyle = TextStyle(
  fontSize: 20,
  color: Colors.grey,
  fontWeight: FontWeight.w700,
);

final kSubtitleStyle = TextStyle(
  fontSize: 26,
  color: Colors.black,
  fontWeight: FontWeight.w700,
);
