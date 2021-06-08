import 'package:audiobook/utils/appTheme.dart';
import 'package:audiobook/utils/size_config.dart';
import 'package:flutter/material.dart';

class LocalLibrary extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
      child: ListView.builder(
          itemCount: 20,
          itemBuilder: (ctx, i) {
            return ListTile(
              minVerticalPadding: 10,
              leading: Container(
                height: SizeConfig.width * 0.1,
                width: SizeConfig.width * 0.1,
                decoration: BoxDecoration(
                  color: AppTheme().mulledWineColor,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Center(
                  child: Icon(
                    Icons.audiotrack_outlined,
                    color: Colors.white,
                  ),
                ),
              ),
              title: Text(
                "Book Name",
                style: Theme.of(context).textTheme.headline5.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
              ),
              subtitle: Text(
                "Chapter Name",
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    .copyWith(color: Colors.grey),
              ),
            );
          }),
    );
  }
}
