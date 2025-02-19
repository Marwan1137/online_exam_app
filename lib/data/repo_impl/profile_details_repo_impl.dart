import 'package:injectable/injectable.dart';
import 'package:online_exam_app/data/data_source_contract/profile_details_datasource.dart';
import 'package:online_exam_app/data/model/user_response/user_response.dart';
import 'package:online_exam_app/domain/common/result.dart';
import 'package:online_exam_app/domain/repo_contract/profile_details_repo_contract.dart';

@Injectable(as: ProfileDetailsRepoContract)
class ProfileDetailsRepoImpl implements ProfileDetailsRepoContract {
  final ProfileDetailsDataSourceContract profileDetailsDataSource;

  ProfileDetailsRepoImpl({required this.profileDetailsDataSource});

  @override
  Future<Result<UserResponse>> getProfileDetails({
    required String token,
    required String userName,
    required String email,
    required String phoneNumber,
    required String password,
    required String firstName,
    required String lastName,
  }) {
    return profileDetailsDataSource.getProfileDetails(
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
