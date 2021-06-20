import 'package:audiobook/ui/widgets/raised_button.dart';
import 'package:audiobook/utils/appTheme.dart';
import 'package:audiobook/utils/constants.dart';
import 'package:audiobook/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PremiumCard extends StatelessWidget {
  final text;
  PremiumCard({@required this.text});
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 5,
      shadowColor: AppTheme().primaryColor.withOpacity(0.5),
      margin: EdgeInsets.symmetric(horizontal: 60),
      child: Wrap(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                SizedBox(height: 20),
                SvgPicture.asset(
                  "assets/svgs/premium.svg",
                  width: SizeConfig.width * 0.4,
                ),
                SizedBox(
                  height: 30,
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
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    text ?? kPremiumText,
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
