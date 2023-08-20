import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/utils/constants.dart';
import 'package:todo_app/widgets/appstyle.dart';
import 'package:todo_app/widgets/reusable_text.dart';

class PageOne extends StatelessWidget {
  const PageOne({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppConst.kHeight,
      width: AppConst.kWidth,
      color: AppConst.kBkDark,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [Padding(padding: EdgeInsets.symmetric(horizontal: 30.w),
          child: Image.asset("lib/img/clip-timeline.png")),
        const SizedBox(height: 100,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
               ReusableText(text: "ToDo",
                 style: appstyle(30, AppConst.kLight, FontWeight.w600),),
               const SizedBox(height: 10),
               Padding(padding: EdgeInsets.symmetric(horizontal: 30.w),
                 child: Text("Benvenuto! Vuoi creare un task?",
                        textAlign: TextAlign.center,
                        style: appstyle(16, AppConst.kGreyLight, FontWeight.normal),

                 ),
               ),
            ],
          ),


        ],
      ),
    );
  }
}
