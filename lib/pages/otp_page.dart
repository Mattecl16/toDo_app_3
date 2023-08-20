import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pinput/pinput.dart';
import 'package:todo_app/auth_controller.dart';
import 'package:todo_app/utils/constants.dart';
import 'package:todo_app/widgets/appstyle.dart';
import 'package:todo_app/widgets/reusable_text.dart';

class OtpPage extends ConsumerWidget {
  const OtpPage({Key? key, required this.smsCodeId, required this.phone}) : super(key: key);

  final String smsCodeId;
  final String phone;

  void verifyOtpCode(
      BuildContext context, WidgetRef ref, String smsCode
      ) {
    ref.read(authControllerProvider).verifyOtpCode(
        context: context,
        smsCodeId: smsCodeId,
        smsCode: smsCode,
        mounted: true);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: AppConst.kHeight*0.12),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.w),
                child: Image.asset("lib/img/clip-distance-education.gif",width: AppConst.kWidth*0.5,),),

              const SizedBox(height: 26),
              ReusableText(text: "Inserire otp",
              style: appstyle(18, AppConst.kLight, FontWeight.bold)),
              const SizedBox(height: 26),
              Pinput(
                length: 6,
                showCursor: true,
                onCompleted: (value){
                  if (value.length == 6) {
                    return verifyOtpCode(context, ref, value);
                  }
                },
                onSubmitted: (value) {
                  if(value.length == 6) {
                    return verifyOtpCode(context, ref, value);
                  }
                },
              ),
            ],

          ),
        ),
      ),
    );
  }
}
