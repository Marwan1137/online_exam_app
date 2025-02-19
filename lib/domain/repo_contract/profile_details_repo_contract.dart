import 'package:online_exam_app/data/model/user_response/user_response.dart';
import 'package:online_exam_app/domain/common/result.dart';

abstract class ProfileDetailsRepoContract {
  Future<Result<UserResponse>> getProfileDetails({
    required String token,
    required String userName,
    required String email,
    required String phoneNumber,
    required String password,
    required String firstName,
    required String lastName,
  });
}
