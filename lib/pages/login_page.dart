import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_app/auth_controller.dart';
import 'package:todo_app/code_provider.dart';
import 'package:todo_app/pages/homepage.dart';
import 'package:todo_app/utils/constants.dart';
import 'package:todo_app/widgets/appstyle.dart';
import 'package:todo_app/widgets/custom_otn_btn.dart';
import 'package:todo_app/widgets/custome_text.dart';
import 'package:todo_app/widgets/reusable_text.dart';
import 'package:country_picker/country_picker.dart';
import 'package:todo_app/widgets/showDialog.dart';

import 'otp_page.dart';


class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final TextEditingController phone = TextEditingController();

  Country country = Country(
      phoneCode: "86",
      countryCode: "CN",
      e164Sc: 0,
      geographic: true,
      level: 1,
      name: "China",
      example: "China",
      displayName: "China",
      displayNameNoCountryCode: "CN",
      e164Key:""

      );


  sendCodeToUser() {
    if(phone.text.isEmpty) {
      return showAlertDialog(context: context, message: "Please enter ya phone number");
    } else if(phone.text.length < 8) {
      return showAlertDialog(context: context, message: "Ya phone number is too short");
    } else {
      print('+${country.phoneCode}${phone.text}');
      ref.read(authControllerProvider).sendSms(
          context: context,
          phone: '+${country.phoneCode}${phone.text}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //safearea will keep the widgets
      //within the size of the screen
      body: SafeArea(child: Padding(padding: EdgeInsets.symmetric(horizontal: 8.w,),
      child: ListView(
        children: [
          Padding(padding: EdgeInsets.symmetric(horizontal: 30.w),
              child: Image.asset("lib/img/clip-timeline.png", width: 300,),),
          const SizedBox(height: 20),

          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 16.w),
            child: ReusableText(text: "Numero di telefono",
            style: appstyle(17, AppConst.kLight, FontWeight.w500)),

          ),

          const SizedBox(height: 20),
          Center(
            child: CustomTextField(
              controller: phone,
              prefixIcon: Container(
                padding: const EdgeInsets.all(14),
                child: GestureDetector(
                    onTap: (){
                      showCountryPicker(context: context,
                      countryListTheme: CountryListThemeData(
                        backgroundColor: AppConst.kGreyLight,
                        bottomSheetHeight: AppConst.kHeight*0.6,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(AppConst.kRadius),
                          topRight: Radius.circular(AppConst.kRadius),
                        ),
                      ),
                      onSelect: (code){
                        setState(() {
                          country = code;
                        });

                          });
                    },
                  child: ReusableText(text: "${country.flagEmoji} + ${country.phoneCode}", style: appstyle(18, AppConst.kBkDark, FontWeight.bold)),
                ),
              ),
              //controlla che sia un numero telefonico:
              keyboardType: TextInputType.number,
              hintText: "Inserire numero di telefono",
              hintStyle: appstyle(16, AppConst.kBkDark, FontWeight.w600),
              ),
          ),

          const SizedBox(height: 20),

          Padding(
            padding: const EdgeInsets.all(10.0),
            child: CustomOtlnBtn(
              onTap: (){
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => HomePage())
                );
              },
              // onTap: (){
              //   sendCodeToUser();
              // },
                width: AppConst.kWidth*0.9,
                height: AppConst.kHeight*0.075,
                color: AppConst.kBkDark,
                color2: AppConst.kLight,
                text: "Invia codice"),
          )

        ],
      ),)),
    );
  }
}
