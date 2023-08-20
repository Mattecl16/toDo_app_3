import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_app/auh_repository.dart';

final authControllerProvider = Provider((ref){
  final authRepository = ref.watch(authRepositoryProvider);
  return AuthController(authRepository: authRepository);
});

class AuthController{
  final AuthRepository authRepository;

  AuthController({required this.authRepository});

  void verifyOtpCode({
    required BuildContext context,
    required String smsCodeId,
    required String smsCode,
    required bool mounted,
    }) {
    authRepository.verifyOtp(
        context: context,
        smsCodeId: smsCodeId,
        smsCode: smsCode,
        mounted: mounted);
  }

  void sendSms({
    required BuildContext context,
    required String phone
}) {
    authRepository.sendOtp(context: context, phone: phone);
  }


}