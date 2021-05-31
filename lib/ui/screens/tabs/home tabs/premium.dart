import 'package:audiobook/ui/widgets/raised_button.dart';
import 'package:audiobook/utils/constants.dart';
import 'package:audiobook/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Premium extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(height: 50),
            SvgPicture.asset(
              "assets/svgs/premium.svg",
              width: SizeConfig.width * 0.7,
            ),
            SizedBox(
              height: 50,
            ),
            FRaisedButton(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      "assets/svgs/crown.svg",
                      color: Colors.white,
                      width: 20,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      "Become Premium",
                      style: Theme.of(context).textTheme.headline6.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          height: 1.3),
                    )
                  ],
                ),
                onPressed: () {}),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: SizeConfig.width * 0.1),
              child: Text(
                kPremiumText,
                maxLines: 3,
                softWrap: true,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyText1.copyWith(
                      color: Colors.black,
                    ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            // Text(
            //   "Benifits of Premium Membership",
            //   textAlign: TextAlign.center,
            //   style: Theme.of(context).textTheme.headline4.copyWith(
            //         fontWeight: FontWeight.w600,
            //         color: Colors.black,
            //       ),
            // ),
          ],
        ),
      ),
    );
  }
}
