import 'package:audiobook/main.dart';
import 'package:audiobook/utils/appTheme.dart';
import 'package:audiobook/utils/constants.dart';
import 'package:audiobook/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Onboard extends StatefulWidget {
  @override
  _OnboardState createState() => _OnboardState();
}

class _OnboardState extends State<Onboard> {
  int page = 1;
  PageController controller;
  ValueNotifier<double> _pageNotifier;
  @override
  void initState() {
    controller = PageController();
    controller.addListener(_pageListener);
    _pageNotifier = ValueNotifier(0.0);

    super.initState();
  }

  _pageListener() {
    _pageNotifier.value = controller.page;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            PageView.builder(
              controller: controller,
              physics: BouncingScrollPhysics(),
              itemCount: kOnboardData.length,
              itemBuilder: (ctx, idx) {
                return Page(
                  title: kOnboardData[idx].title,
                  subtitle: kOnboardData[idx].subtitle,
                  imagePath: kOnboardData[idx].imagePath,
                  imageWidth: kOnboardData[idx].imageWidth,
                );
              },
            ),
            Positioned(
              child: Container(
                height: SizeConfig.height * 0.24,
                width: SizeConfig.width,
                alignment: Alignment.center,
                child: SvgPicture.asset(
                  kAppLogoColoured,
                  height: SizeConfig.height * 0.1,
                ),
              ),
            ),
            Positioned(
                bottom: 30,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  width: SizeConfig.width,
                  child: ValueListenableBuilder(
                      valueListenable: _pageNotifier,
                      builder: (ctx, value, child) {
                        return Row(
                          children: [
                            value < 1
                                ? SizedBox(
                                    width: 50,
                                  )
                                : IconButton(
                                    icon: Icon(Icons.arrow_back_rounded),
                                    iconSize: 30,
                                    color: AppTheme().silverColor,
                                    onPressed: () => controller.animateToPage(
                                        controller.page.toInt() - 1,
                                        duration: Duration(milliseconds: 300),
                                        curve: Curves.easeInOutSine),
                                  ),
                            Spacer(),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircleAvatar(
                                radius: 5,
                                backgroundColor: value == 0
                                    ? AppTheme().primaryColor
                                    : AppTheme().silverColor,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircleAvatar(
                                radius: 5,
                                backgroundColor: value == 1
                                    ? AppTheme().primaryColor
                                    : AppTheme().silverColor,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircleAvatar(
                                radius: 5,
                                backgroundColor: value == 2
                                    ? AppTheme().primaryColor
                                    : AppTheme().silverColor,
                              ),
                            ),
                            Spacer(),
                            IconButton(
                              icon: Icon(Icons.arrow_forward_rounded),
                              iconSize: 30,
                              color: AppTheme().primaryColor,
                              onPressed: () {
                                controller.page == 2
                                    ? Navigator.pushNamed(context,
                                        AuthenticationWrapper.routeName)
                                    : controller.animateToPage(
                                        controller.page.toInt() + 1,
                                        duration: Duration(milliseconds: 300),
                                        curve: Curves.easeInOutSine);
                              },
                            ),
                          ],
                        );
                      }),
                ))
          ],
        ),
      ),
    );
  }
}

class Page extends StatelessWidget {
  final String title, subtitle, imagePath;
  final double imageWidth;

  Page(
      {@required this.imagePath,
      @required this.subtitle,
      @required this.title,
      @required this.imageWidth});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: SizeConfig.height * 0.2,
          ),
          Container(
            height: SizeConfig.height * 0.5,
            width: SizeConfig.width,
            alignment: Alignment.center,
            child: SvgPicture.asset(
              imagePath,
              width: SizeConfig.width * imageWidth,
            ),
          ),
          Text(
            title,
            style: Theme.of(context).textTheme.headline4.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: SizeConfig.width * 0.1),
            child: Text(
              subtitle,
              maxLines: 3,
              softWrap: true,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyText1.copyWith(
                    color: Colors.black,
                  ),
            ),
          ),
          Spacer(
            flex: 3,
          ),
        ],
      ),
    );
  }
}
