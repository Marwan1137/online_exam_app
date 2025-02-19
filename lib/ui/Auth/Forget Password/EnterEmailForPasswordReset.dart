// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_exam_app/Shared/widgets/Validator.dart';
import 'package:online_exam_app/Shared/widgets/custom_button.dart';
import 'package:online_exam_app/Shared/widgets/custom_text_field.dart';
import 'package:online_exam_app/Shared/widgets/toast_message.dart';
import 'package:online_exam_app/core/theme/colors_manager.dart';
import 'package:online_exam_app/core/utils/config.dart';
import 'package:online_exam_app/core/utils/string_manager.dart';
import 'package:online_exam_app/core/utils/text_style_manger.dart';
import 'package:online_exam_app/ui/Auth/view_model/cubit/auth_cubit.dart';
import 'package:online_exam_app/ui/Auth/view_model/cubit/auth_intent.dart';

class EnterEmailForgetPassword extends StatefulWidget {
  static const routeName = '/EnterEmailForgetPassword';

  const EnterEmailForgetPassword({super.key});

  @override
  State<EnterEmailForgetPassword> createState() =>
      _EnterEmailForgetPasswordState();
}

class _EnterEmailForgetPasswordState extends State<EnterEmailForgetPassword> {
  final TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _validateAndContinue() {
    if (_formKey.currentState!.validate()) {
      AuthCubit.get(context).doIntent(ForgetPassword(
        email: emailController.text,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    Config().init(context);

    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is SendEmailVerificationLoadingState) {
          showDialog(
            context: context,
            builder: (context) => Center(
              child: CircularProgressIndicator(
                color: AppColors.blue_base,
              ),
            ),
          );
        }

        if (state is SendEmailVerificationSuccessState) {
          if (state.isSent) {
            Navigator.pushNamed(
              context,
              AppStrings.emailVerificationScreenRoute,
              arguments: emailController.text,
            );
          }
        }
        if (state is SendEmailVerificationErrorState) {
          Navigator.pop(context);
          toastMessage(
              message: "Error : ${state.message}",
              tybeMessage: TybeMessage.negative);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            AppStrings.password,
          ),
        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: Config.screenHight! * 0.03),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    AppStrings.forgetpassword,
                    style: AppTextStyle.medium18,
                  ),
                ),
                SizedBox(height: Config.screenHight! * 0.012),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    AppStrings.pleaseEnterEmailsAssociatedToUrAccount,
                    style:
                        AppTextStyle.regular14.copyWith(color: AppColors.grey),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: Config.screenHight! * 0.05),

                /* Email Field */
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    CustomTextField(
                      label: AppStrings.email,
                      placeholder: AppStrings.enterYourEmail,
                      controller: emailController,
                      validator: Validator.email,
                    ),
                  ],
                ),
                SizedBox(height: Config.screenHight! * 0.06),

                /* Continue Button */
                CustomButton(
                  onTap: _validateAndContinue,
                  text: AppStrings.continu,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
