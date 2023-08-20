import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_app/utils/constants.dart';
import 'package:todo_app/widgets/appstyle.dart';
import 'package:todo_app/widgets/reusable_text.dart';

import '../todo/todo_provider.dart';

class BottomTitles extends StatelessWidget {
  const BottomTitles({Key? key, required this.text, required this.text2, this.clr}) : super(key: key);

  final String text;
  final String text2;
  final Color? clr;//? to make it optional
  //se vuoi puoi passarlo, oppure no
  //remove required
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppConst.kWidth,
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Consumer(
                builder: (context, ref, child) {
                  var color = ref.read(todoStateProvider.notifier).getRandomColor();
                  return Container(
                    height: 80,
                    width: 5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(AppConst.kRadius),
                      ),

                     color: color,
                    ),
                  );
                }


            ),
            const SizedBox(width: 15,),
            Padding(padding: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ReusableText(
                  text: text,
                  style: appstyle(24, AppConst.kLight, FontWeight.bold),),
                const SizedBox(height: 10,),

                ReusableText(
                  text: text2,
                  style: appstyle(12, AppConst.kLight, FontWeight.normal),)
              ],
            ),)

          ],
        ),
      ),

    );
  }
}
