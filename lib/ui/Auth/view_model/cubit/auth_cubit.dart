import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam_app/data/model/user_response/user_response.dart';
import 'package:online_exam_app/domain/common/exceptions/server_error.dart';
import 'package:online_exam_app/domain/common/result.dart';
import 'package:online_exam_app/domain/use_cases/Forget%20Password%20Use%20Cases/ForgetPassword_Use_Case.dart';
import 'package:online_exam_app/domain/use_cases/Forget%20Password%20Use%20Cases/resetPassword_UseCase.dart';
import 'package:online_exam_app/domain/use_cases/Forget%20Password%20Use%20Cases/verifyResetCodeUseCase.dart';
import 'package:online_exam_app/domain/use_cases/signup_usecase.dart';
import 'package:online_exam_app/ui/Auth/view_model/cubit/auth_intent.dart';

part 'auth_state.dart';

@injectable
class AuthCubit extends Cubit<AuthState> {
  AuthCubit(
      {required this.verifyresetcodeUseCase,
      required this.resetpasswordUsecase,
      required this.signupUsecase,
      required this.forgetPasswordUseCase})
      : super(AuthInitial());
  @factoryMethod
  SignupUsecase signupUsecase;
  ForgetPasswordUseCase forgetPasswordUseCase;
  VerifyresetcodeUseCase verifyresetcodeUseCase;
  ResetpasswordUsecase resetpasswordUsecase;

  void doIntent(AuthIntent intent) {
    switch (intent) {
      case SignUpIntent():
        _SignUp(intent: intent);
        break;
      case LoginIntent():
        _login();
        break;
      case ForgetPassword():
        _ForgetPassword(intent: intent);
        break;
      case VerifyResetCode():
        _VerifyResetCode(intent: intent);
        break;
      case ResetPassword():
        _ResetPassword(intent: intent);
        break;
    }
  }

  static AuthCubit get(BuildContext context) => BlocProvider.of(context);

  _SignUp({required SignUpIntent intent}) async {
    emit(SignupLoadingState());
    final result = await signupUsecase.invoke(
        username: intent.username,
        firstName: intent.firstName,
        lastName: intent.lastName,
        email: intent.email,
        password: intent.password,
        confirmPassword: intent.confirmPassword,
        phone: intent.phone);

    switch (result) {
      case Success():
        {
          emit(SignupSuccessState(userResponse: result.data));
        }
      case Error():
        {
          if (result.exception is ClientError) {
            emit(SignupErrorState(
                message: (result.exception as ClientError).message ??
                    "Unknown error"));
          } else {
            emit(SignupErrorState(message: result.exception.toString()));
          }
        }
    }
  }

  _ForgetPassword({required ForgetPassword intent}) async {
    emit(SendEmailVerificationLoadingState());
    final result = await forgetPasswordUseCase.invoke(
      email: intent.email,
    );
    switch (result) {
      case Success():
        {
          emit(SendEmailVerificationSuccessState(isSent: result.data ?? false));
        }
      case Error():
        {
          emit(SendEmailVerificationErrorState(
              message: result.exception.toString()));
        }
    }
  }

  _VerifyResetCode({required VerifyResetCode intent}) async {
    emit(VerifyResetCodeLoadingState());
    final result = await verifyresetcodeUseCase.check(
      code: intent.resetCode,
    );
    switch (result) {
      case Success():
        {
          emit(VerifyResetCodeSuccessState(isVerified: result.data ?? false));
        }
      case Error():
        {
          emit(VerifyResetCodeErrorState(message: result.exception.toString()));
        }
    }
  }

  _ResetPassword({required ResetPassword intent}) async {
    emit(ResetPasswordLoadingState());

    final result = await resetpasswordUsecase.invoke(
        email: intent.email, password: intent.NewPassword);

    switch (result) {
      case Success():
        {
          emit(ResetPasswordSuccessState(isChanged: result.data ?? false));
        }
      case Error():
        {
          emit(ResetPasswordErrorState(message: result.exception.toString()));
        }
    }
  }

  _login() {}
}
