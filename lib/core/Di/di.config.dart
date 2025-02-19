// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:online_exam_app/core/Di/di.dart';
import 'package:shared_preferences/shared_preferences.dart' as _i460;

import '../../data/data_source_contract/ForgetPassword_dataSourses/ForgetPassword_dataSourse.dart'
    as _i42;
import '../../data/data_source_contract/ForgetPassword_dataSourses/ResetpasswordDataSourceRepo.dart'
    as _i865;
import '../../data/data_source_contract/ForgetPassword_dataSourses/VerifyresetcodeRepoDataSource.dart'
    as _i443;
import '../../data/data_source_contract/profile_details_datasource.dart'
    as _i1052;
import '../../data/data_source_contract/signin_datasource.dart' as _i1072;
import '../../data/data_source_contract/signup_datasource.dart' as _i647;
import '../../data/data_source_impl/ForgetPassword/ForgetPassWord.dart'
    as _i444;
import '../../data/data_source_impl/ForgetPassword/ResetpasswordDataSourceRepoImpl.dart'
    as _i66;
import '../../data/data_source_impl/ForgetPassword/VerifyresetcodeRepoDataSourceImpl.dart'
    as _i695;
import '../../data/data_source_impl/profile_details_datasource_impl.dart'
    as _i808;
import '../../data/data_source_impl/signin_datasource_impl.dart' as _i64;
import '../../data/data_source_impl/signup_datasource_impl.dart' as _i648;
import '../../data/repo_impl/Forget%20Password%20Impl/ForgetPasswordRepoImpl.dart'
    as _i455;
import '../../data/repo_impl/Forget%20Password%20Impl/ResetpasswordRepoImpl.dart'
    as _i343;
import '../../data/repo_impl/Forget%20Password%20Impl/VerifyresetcodeRepoImpl.dart'
    as _i165;
import '../../data/repo_impl/profile_details_repo_impl.dart' as _i544;
import '../../data/repo_impl/signin_repo_impl.dart' as _i209;
import '../../data/repo_impl/signup_repo_impl.dart' as _i430;
import '../../domain/repo_contract/Forget%20Password%20Repos/ForgetPassword_repo.dart'
    as _i105;
import '../../domain/repo_contract/Forget%20Password%20Repos/resetPasswordRepo.dart'
    as _i974;
import '../../domain/repo_contract/Forget%20Password%20Repos/verifyResetCodeRepo.dart'
    as _i460;
import '../../domain/repo_contract/profile_details_repo_contract.dart' as _i286;
import '../../domain/repo_contract/sign_in_repo_contract.dart' as _i1006;
import '../../domain/repo_contract/signup_repo_contract.dart' as _i229;
import '../../domain/use_cases/Forget%20Password%20Use%20Cases/ForgetPassword_Use_Case.dart'
    as _i524;
import '../../domain/use_cases/Forget%20Password%20Use%20Cases/resetPassword_UseCase.dart'
    as _i498;
import '../../domain/use_cases/Forget%20Password%20Use%20Cases/verifyResetCodeUseCase.dart'
    as _i644;
import '../../domain/use_cases/profile_details_usecase.dart' as _i833;
import '../../domain/use_cases/signin_usecase.dart' as _i788;
import '../../domain/use_cases/signup_usecase.dart' as _i459;
import '../../ui/Auth/view_model/cubit/auth_cubit.dart' as _i906;
import '../../ui/Profile_Details/viewmodel/profile_details_cubit.dart' as _i543;
import '../api/api_manager.dart' as _i1047;
import '../services/token_storage_service.dart' as _i474;
import '../services/user_service.dart' as _i381;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final registerModule = _$RegisterModule();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => registerModule.prefs,
      preResolve: true,
    );
    gh.singleton<_i1047.ApiManager>(() => _i1047.ApiManager());
    gh.singleton<_i381.UserService>(() => _i381.UserService());
    gh.singleton<_i474.TokenStorageService>(
        () => _i474.TokenStorageService(gh<_i460.SharedPreferences>()));
    gh.factory<_i1072.SignInDataSourceContract>(
        () => _i64.SigninDatasourceImpl(gh<_i1047.ApiManager>()));
    gh.factory<_i647.SignUpDataSourceContract>(
        () => _i648.SignUpDataSourceImpl(gh<_i1047.ApiManager>()));
    gh.factory<_i1006.SignInRepoContract>(
        () => _i209.SigninRepoImpl(gh<_i1072.SignInDataSourceContract>()));
    gh.factory<_i1052.ProfileDetailsDataSourceContract>(
        () => _i808.ProfileDetailsDataSourceImpl(gh<_i1047.ApiManager>()));
    gh.factory<_i42.ForgetpasswordDataSourseRepo>(() =>
        _i444.ForgetpasswordDataSourceRepoImpl(
            apiManager: gh<_i1047.ApiManager>()));
    gh.factory<_i443.VerifyresetcodeRepoDataSource>(() =>
        _i695.Verifyresetcoderepodatasourceimpl(
            apiManager: gh<_i1047.ApiManager>()));
    gh.factory<_i788.SigninUsecase>(() => _i788.SigninUsecase(
          signInRepoContract: gh<_i1006.SignInRepoContract>(),
          tokenStorage: gh<_i474.TokenStorageService>(),
          userService: gh<_i381.UserService>(),
        ));
    gh.factory<_i229.SignupRepoContract>(() => _i430.SignupRepoImpl(
        signUpDataSourceContract: gh<_i647.SignUpDataSourceContract>()));
    gh.factory<_i286.ProfileDetailsRepoContract>(() =>
        _i544.ProfileDetailsRepoImpl(
            profileDetailsDataSource:
                gh<_i1052.ProfileDetailsDataSourceContract>()));
    gh.factory<_i865.ResetpasswordDataSourceRepo>(() =>
        _i66.Resetpassworddatasourcerepoimpl(
            apiManager: gh<_i1047.ApiManager>()));
    gh.factory<_i833.ProfileDetailsUsecase>(() => _i833.ProfileDetailsUsecase(
          profileDetailsRepoContract: gh<_i286.ProfileDetailsRepoContract>(),
          tokenStorage: gh<_i474.TokenStorageService>(),
          userService: gh<_i381.UserService>(),
        ));
    gh.factory<_i543.ProfileDetailsCubit>(() => _i543.ProfileDetailsCubit(
          profileDetailsUsecase: gh<_i833.ProfileDetailsUsecase>(),
          tokenStorage: gh<_i474.TokenStorageService>(),
          userService: gh<_i381.UserService>(),
        ));
    gh.factory<_i460.VerifyresetcodeRepo>(() => _i165.Verifyresetcoderepoimpl(
        gh<_i443.VerifyresetcodeRepoDataSource>()));
    gh.factory<_i974.ResetpasswordRepo>(() =>
        _i343.Resetpasswordrepoimpl(gh<_i865.ResetpasswordDataSourceRepo>()));
    gh.factory<_i105.ForgetpasswordRepo>(() => _i455.Forgetpasswordrepoimpl(
        forgetpassword_data_sourse_repo:
            gh<_i42.ForgetpasswordDataSourseRepo>()));
    gh.factory<_i644.VerifyresetcodeUseCase>(() =>
        _i644.VerifyresetcodeUseCase(repo: gh<_i460.VerifyresetcodeRepo>()));
    gh.factory<_i459.SignupUsecase>(() => _i459.SignupUsecase(
        signupRepoContract: gh<_i229.SignupRepoContract>()));
    gh.factory<_i498.ResetpasswordUsecase>(
        () => _i498.ResetpasswordUsecase(repo: gh<_i974.ResetpasswordRepo>()));
    gh.factory<_i524.ForgetPasswordUseCase>(() => _i524.ForgetPasswordUseCase(
        forgetPassword: gh<_i105.ForgetpasswordRepo>()));
    gh.factory<_i906.AuthCubit>(() => _i906.AuthCubit(
          verifyresetcodeUseCase: gh<_i644.VerifyresetcodeUseCase>(),
          resetpasswordUsecase: gh<_i498.ResetpasswordUsecase>(),
          signupUsecase: gh<_i459.SignupUsecase>(),
          forgetPasswordUseCase: gh<_i524.ForgetPasswordUseCase>(),
          signinUsecase: gh<_i788.SigninUsecase>(),
        ));
    return this;
  }
}

class _$RegisterModule extends RegisterModule {}
