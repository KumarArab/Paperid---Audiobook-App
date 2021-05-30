import 'package:audiobook/ui/widgets/raised_button.dart';
import 'package:audiobook/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Premium extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SvgPicture.asset(
            "assets/svgs/listen-audiobooks.svg",
            width: SizeConfig.width * 0.8,
          ),
          SizedBox(
            height: 20,
          ),
          FRaisedButton(
              child: Text("Only For Premimum Members"), onPressed: () {})
        ],
      ),
    );
  }
}
