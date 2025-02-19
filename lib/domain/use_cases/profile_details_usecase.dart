import 'package:injectable/injectable.dart';
import 'package:online_exam_app/core/services/token_storage_service.dart';
import 'package:online_exam_app/core/services/user_service.dart';
import 'package:online_exam_app/data/model/user_response/user_response.dart';
import 'package:online_exam_app/domain/common/result.dart';
import 'package:online_exam_app/domain/repo_contract/profile_details_repo_contract.dart';

@injectable
class ProfileDetailsUsecase {
  final ProfileDetailsRepoContract profileDetailsRepoContract;
  final TokenStorageService tokenStorage;
  final UserService userService;

  @factoryMethod
  ProfileDetailsUsecase({
    required this.profileDetailsRepoContract,
    required this.tokenStorage,
    required this.userService,
  });

  Future<Result<UserResponse>> invoke({
    required String token,
    required String userName,
    required String email,
    required String phoneNumber,
    required String password,
    required String firstName,
    required String lastName,
  }) {
    return profileDetailsRepoContract.getProfileDetails(
      token: token,
      userName: userName,
      email: email,
      phoneNumber: phoneNumber,
      password: password,
      firstName: firstName,
      lastName: lastName,
    );
  }
}
