import 'package:audiobook/ui/widgets/flat_button.dart';
import 'package:audiobook/utils/appTheme.dart';
import 'package:audiobook/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_range_slider/flutter_range_slider.dart' as frs;

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
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  child: frs.RangeSlider(
                    min: 1,
                    max: 5,
                    lowerValue: start,
                    upperValue: end,
                    divisions: 5,
                    showValueIndicator: true,
                    valueIndicatorMaxDecimals: 0,
                    onChanged: (double newLowerValue, double newUpperValue) {
                      setState(() {
                        start = newLowerValue;
                        end = newUpperValue;
                      });
                    },
                    onChangeStart:
                        (double startLowerValue, double startUpperValue) {
                      print(
                          'Started with values: $startLowerValue and $startUpperValue');
                    },
                    onChangeEnd: (double newLowerValue, double newUpperValue) {
                      print(
                          'Ended with values: $newLowerValue and $newUpperValue');
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
                // RangeSlider(
                //     divisions: 5,
                //     min: 1,
                //     max: 5,
                //     labels: RangeLabels(
                //         start.toInt().toString(), end.toInt().toString()),
                //     activeColor: AppTheme().primaryColor.withOpacity(0.5),
                //     inactiveColor: AppTheme().silverColor,
                //     onChangeStart: (RangeValues values) {
                //       setState(() {
                //         start = values.start;
                //       });
                //     },
                //     onChangeEnd: (RangeValues values) {
                //       setState(() {
                //         end = values.end;
                //       });
                //     },
                //     values: RangeValues(start, end),
                //     onChanged: (RangeValues values) {
                //       setState(() {
                //         start = values.start;
                //         end = values.end;
                //       });
                //     })
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
