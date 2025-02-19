import 'package:online_exam_app/data/model/user_response/user_response.dart';

class ProfileDetailsState {
  final bool isLoading;
  final String? error;
  final UserResponse? userProfile;

  const ProfileDetailsState({
    this.isLoading = false,
    this.error,
    this.userProfile,
  });

  ProfileDetailsState copyWith({
    bool? isLoading,
    String? error,
    UserResponse? userProfile,
  }) {
    return ProfileDetailsState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      userProfile: userProfile ?? this.userProfile,
    );
  }
}
