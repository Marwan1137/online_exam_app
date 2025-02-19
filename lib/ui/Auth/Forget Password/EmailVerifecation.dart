import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:online_exam_app/Shared/widgets/toast_message.dart';
import 'package:online_exam_app/core/theme/colors_manager.dart';
import 'package:online_exam_app/core/utils/text_style_manger.dart';
import 'package:online_exam_app/ui/Auth/Forget%20Password/PutNewPassword.dart';
import 'package:online_exam_app/ui/Auth/view_model/cubit/auth_cubit.dart';
import 'package:online_exam_app/core/utils/config.dart';
import 'package:online_exam_app/core/utils/string_manager.dart';
import 'package:pinput/pinput.dart';

import '../view_model/cubit/auth_intent.dart';

class EmailVerification extends StatefulWidget {
  const EmailVerification({super.key});

  @override
  State<EmailVerification> createState() => _EmailVerificationState();
}

class _EmailVerificationState extends State<EmailVerification> {
  bool isResendEnabled = false;

  @override
  Widget build(BuildContext context) {
    final email = ModalRoute.of(context)!.settings.arguments as String;

    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is SendEmailVerificationLoadingState ||
            state is VerifyResetCodeLoadingState) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => Center(
              child: CircularProgressIndicator(
                color: AppColors.blue_base,
              ),
            ),
          );
        }

        if (state is SendEmailVerificationSuccessState) {
          Navigator.pop(context);
          if (state.isSent) {
            toastMessage(
                message: "The Code has been sent. Check your email.",
                tybeMessage: TybeMessage.positive);
          }
        }

        if (state is SendEmailVerificationErrorState) {
          Navigator.pop(context);
          toastMessage(
              message: "Error: ${state.message}",
              tybeMessage: TybeMessage.negative);
        }

        if (state is VerifyResetCodeSuccessState) {
          Navigator.pop(context);
          if (state.isVerified) {
            Navigator.pushNamed(
              context,
              PutNewPassword.routeName,
              arguments: email,
            );
          }
        }

        if (state is VerifyResetCodeErrorState) {
          Navigator.pop(context); // Close loading on error
          toastMessage(
              message: AppStrings.thePinCodeIsWrong,
              tybeMessage: TybeMessage.negative);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppStrings.password),
        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: Config.screenHight! * 0.03),
              Align(
                alignment: Alignment.center,
                child: Text(
                  AppStrings.emailVerification,
                  style: AppTextStyle.medium20,
                ),
              ),
              SizedBox(height: Config.screenHight! * 0.012),
              Align(
                alignment: Alignment.center,
                child: Text(
                  AppStrings.sendedCode,
                  textAlign: TextAlign.center,
                  style: AppTextStyle.regular14.copyWith(color: AppColors.grey),
                ),
              ),
              SizedBox(height: Config.screenHight! * 0.05),
              Pinput(
                length: 6,
                showCursor: true,
                defaultPinTheme: PinTheme(
                  height: 68,
                  width: 74,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.white,
                  ),
                ),
                onCompleted: (value) {
                  AuthCubit.get(context)
                      .doIntent(VerifyResetCode(resetCode: value));
                },
              ),
              SizedBox(height: Config.screenHight! * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppStrings.dontRecieveCode,
                    style: AppTextStyle.regular16,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: GestureDetector(
                      onTap: isResendEnabled
                          ? () {
                              setState(() {
                                isResendEnabled = false; // Disable again
                              });

                              AuthCubit.get(context).doIntent(
                                ForgetPassword(email: email),
                              );
                            }
                          : null,
                      child: Text(AppStrings.resend,
                          style: AppTextStyle.regular16.copyWith(
                            color: isResendEnabled
                                ? Theme.of(context).primaryColor
                                : AppColors.grey, // Change color dynamically
                            decoration: TextDecoration.underline,
                            decorationColor: isResendEnabled
                                ? Theme.of(context).primaryColor
                                : AppColors.grey, // Underline matches color
                            decorationThickness: 2,
                          )),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TimerCountdown(
                    colonsTextStyle:
                        AppTextStyle.regular12.copyWith(color: AppColors.grey),
                    timeTextStyle:
                        AppTextStyle.regular12.copyWith(color: AppColors.grey),
                    format: CountDownTimerFormat.secondsOnly,
                    endTime: DateTime.now().add(
                      Duration(seconds: 60),
                    ),
                    onEnd: () {
                      setState(() {
                        isResendEnabled = true;
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
