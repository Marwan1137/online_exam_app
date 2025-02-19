import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam_app/core/services/token_storage_service.dart';
import 'package:online_exam_app/core/services/user_service.dart';
import 'package:online_exam_app/data/model/user_response/user_response.dart';
import 'package:online_exam_app/domain/common/result.dart';
import 'package:online_exam_app/domain/use_cases/profile_details_usecase.dart';
import 'profile_details_intent.dart';
import 'profile_details_state.dart';

@injectable
class ProfileDetailsCubit extends Cubit<ProfileDetailsState> {
  final ProfileDetailsUsecase _profileDetailsUsecase;
  final TokenStorageService _tokenStorage;
  final UserService _userService;

  ProfileDetailsCubit({
    required ProfileDetailsUsecase profileDetailsUsecase,
    required TokenStorageService tokenStorage,
    required UserService userService,
  })  : _profileDetailsUsecase = profileDetailsUsecase,
        _tokenStorage = tokenStorage,
        _userService = userService,
        super(const ProfileDetailsState());

  Future<void> handleIntent(ProfileDetailsIntent intent) async {
    switch (intent) {
      case LoadProfileIntent():
        await _handleLoadProfile(intent);
      case UpdateProfileIntent():
        await _handleUpdateProfile(intent);
    }
  }

  Future<void> _handleLoadProfile(LoadProfileIntent intent) async {
    try {
      emit(state.copyWith(isLoading: true, error: null));

      final token = _tokenStorage.getToken();
      if (token == null) {
        emit(state.copyWith(
          isLoading: false,
          error: 'No authentication token found',
        ));
        return;
      }

      // Pre-fill with current user data if available
      final currentUser = _userService.getCurrentUser();
      if (currentUser != null) {
        emit(state.copyWith(
          userProfile: UserResponse(user: currentUser, token: token),
        ));
      }

      final result = await _profileDetailsUsecase.invoke(
        token: token,
        userName: currentUser?.username ?? '',
        email: currentUser?.email ?? '',
        phoneNumber: currentUser?.phone ?? '',
        password: '', // Usually not needed for profile fetch
        firstName: currentUser?.firstName ?? '',
        lastName: currentUser?.lastName ?? '',
      );

      switch (result) {
        case Success():
          emit(state.copyWith(
            isLoading: false,
            userProfile: result.data,
          ));
        case Error():
          emit(state.copyWith(
            isLoading: false,
            error: result.exception.toString(),
          ));
      }
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        error: e.toString(),
      ));
    }
  }

  Future<void> _handleUpdateProfile(UpdateProfileIntent intent) async {
    try {
      emit(state.copyWith(isLoading: true, error: null));

      final token = _tokenStorage.getToken();
      if (token == null) {
        emit(state.copyWith(
          isLoading: false,
          error: 'No authentication token found',
        ));
        return;
      }

      final result = await _profileDetailsUsecase.invoke(
        token: token,
        userName: intent.userName,
        email: intent.email,
        phoneNumber: intent.phoneNumber,
        password: intent.password,
        firstName: intent.firstName,
        lastName: intent.lastName,
      );

      switch (result) {
        case Success():
          {
            // Update the stored user data
            if (result.data?.user != null) {
              _userService.setCurrentUser(result.data!.user);
            }

            emit(state.copyWith(
              isLoading: false,
              userProfile: result.data,
            ));
          }
        case Error():
          {
            emit(state.copyWith(
              isLoading: false,
              error: result.exception.toString(),
            ));
          }
      }
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        error: e.toString(),
      ));
    }
  }
}
