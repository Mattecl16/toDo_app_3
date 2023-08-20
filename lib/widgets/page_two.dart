import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/utils/constants.dart';
import 'package:todo_app/widgets/custom_otn_btn.dart';

import '../pages/login_page.dart';


class PageTwo extends StatelessWidget {
  const PageTwo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      height: AppConst.kHeight,
      width: AppConst.kWidth,
      color: AppConst.kBkDark,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [Padding(padding: EdgeInsets.symmetric(horizontal: 30.w),
            child: Image.asset("lib/img/clip-timeline.png")),
          const SizedBox(height: 50,),
          CustomOtlnBtn(
              onTap:(){
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context)=> const LoginPage()));
              },
              width: AppConst.kWidth*0.9,
              height: AppConst.kHeight*0.06,
              color: AppConst.kLight,
              text: "Accesso con un numero di telefono")


        ],
      ),
    );
  }
}
