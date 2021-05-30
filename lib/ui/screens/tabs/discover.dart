import 'package:audiobook/ui/screens/splash.dart';
import 'package:audiobook/ui/screens/tabs/home%20tabs/authors.dart';
import 'package:audiobook/ui/screens/tabs/home%20tabs/foryou.dart';
import 'package:audiobook/ui/screens/tabs/home%20tabs/genres.dart';
import 'package:audiobook/ui/screens/tabs/home%20tabs/premium.dart';
import 'package:audiobook/ui/widgets/appbar.dart';
import 'package:audiobook/utils/appTheme.dart';
import 'package:audiobook/utils/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Discover extends StatelessWidget {
  final PageController _controller = PageController(initialPage: 0);
  final ValueNotifier<int> _pageNotifier = ValueNotifier(0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            FAppBar(
              isAction: true,
            ),
            ValueListenableBuilder(
              valueListenable: _pageNotifier,
              builder: (ctx, value, _) {
                return Container(
                  height: kToolbarHeight,
                  width: SizeConfig.width,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                    colors: [
                      Colors.white,
                      Colors.white,
                      Colors.grey.withOpacity(0.2),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  )),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                              child: section(context, "For you", value, 0),
                            ),
                            Expanded(
                              child: section(context, "Genres", value, 1),
                            ),
                            Expanded(
                              child: section(context, "Authors", value, 2),
                            ),
                            Expanded(
                              child: section(context, "Premium", value, 3),
                            )
                          ],
                        ),
                      ),
                      Transform.translate(
                        offset: Offset(value * SizeConfig.width * 0.25, 0),
                        // duration: Duration(milliseconds: 600),
                        // curve: Curves.easeInOutSine,
                        // left: value * SizeConfig.width * 0.2,
                        child: Container(
                          width: SizeConfig.width * 0.25,
                          alignment: Alignment.center,
                          child: Container(
                            width: 20,
                            height: 15,
                            decoration: BoxDecoration(
                              color: AppTheme().primaryColor,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(100),
                                topRight: Radius.circular(100),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
            Expanded(
              child: PageView(
                controller: _controller,
                onPageChanged: (page) {
                  _pageNotifier.value = page;
                },
                physics: BouncingScrollPhysics(),
                children: [ForYou(), Genres(), Authors(), Premium()],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget section(BuildContext context, String text, int val, int id) {
    return Text(
      text,
      style: Theme.of(context).textTheme.headline6.copyWith(
            fontWeight: val == id ? FontWeight.w700 : FontWeight.w500,
            color: val == id ? AppTheme().primaryColor : Colors.black,
          ),
      textAlign: TextAlign.center,
    );
  }
}
