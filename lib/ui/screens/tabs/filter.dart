import 'package:audiobook/ui/widgets/flat_button.dart';
import 'package:audiobook/utils/appTheme.dart';
import 'package:audiobook/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

enum LengthFilter {
  all,
  one,
  two,
  three,
  five,
  seven,
  ten,
}

class Filters extends StatefulWidget {
  @override
  _FiltersState createState() => _FiltersState();
}

class _FiltersState extends State<Filters> {
  double start = 1, end = 4;
  LengthFilter _lengthVal = LengthFilter.all;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                IconButton(
                  icon: Icon(
                    Icons.arrow_back_rounded,
                    size: 40,
                    color: Colors.black,
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  child: Text(
                    "Filters",
                    style: Theme.of(context).textTheme.headline4.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  width: SizeConfig.width * 0.7,
                  child: Text(
                    "Only show audiobooks within this range of rating",
                    style: Theme.of(context).textTheme.headline6.copyWith(
                        color: Colors.black, fontWeight: FontWeight.w700),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  width: SizeConfig.width,
                  alignment: Alignment.center,
                  child: TextButton(
                      onPressed: () {},
                      child: Text("All Ratings",
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1
                              .copyWith(color: AppTheme().primaryColor))),
                ),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: SfRangeSlider(
                    min: 1.0,
                    max: 5.0,
                    values: SfRangeValues(start, end),
                    interval: 1.0,
                    showDividers: true,
                    enableIntervalSelection: true,
                    enableTooltip: true,
                    showTicks: true,
                    showLabels: true,
                    minorTicksPerInterval: 1,
                    onChanged: (SfRangeValues values) {
                      setState(() {
                        start = values.start;
                        end = values.end;
                      });
                    },
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Container(
                  width: SizeConfig.width * 0.65,
                  padding: EdgeInsets.only(left: 25),
                  child: Text(
                    "Show only audiobooks with following length:",
                    style: Theme.of(context).textTheme.headline6.copyWith(
                        color: Colors.black, fontWeight: FontWeight.w700),
                  ),
                ),
                radioTile(LengthFilter.all, "All Audiobooks"),
                radioTile(LengthFilter.one, "Upto 1 hour long"),
                radioTile(LengthFilter.two, "Upto 2 hour long"),
                radioTile(LengthFilter.three, "Upto 3 hour long"),
                radioTile(LengthFilter.five, "Upto 5 hour long"),
                radioTile(LengthFilter.seven, "Upto 7 hour long"),
                radioTile(LengthFilter.ten, "Upto 10 hour or longer"),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget radioTile(LengthFilter lengthFilter, String title) {
    return RadioListTile<LengthFilter>(
        title: Text(
          title,
          style: Theme.of(context)
              .textTheme
              .headline6
              .copyWith(color: Colors.black),
        ),
        value: lengthFilter,
        groupValue: _lengthVal,
        onChanged: (LengthFilter value) {
          setState(() {
            _lengthVal = value;
          });
        });
  }
}
