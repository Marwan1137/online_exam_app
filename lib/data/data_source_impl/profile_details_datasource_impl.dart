import 'package:online_exam_app/core/api/api_endpoints.dart';
import 'package:online_exam_app/core/api/api_excuter.dart';
import 'package:online_exam_app/core/api/api_manager.dart';
import 'package:online_exam_app/data/data_source_contract/profile_details_datasource.dart';
import 'package:online_exam_app/data/model/user_response/user_response.dart';
import 'package:online_exam_app/domain/common/result.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ProfileDetailsDataSourceContract)
class ProfileDetailsDataSourceImpl extends ProfileDetailsDataSourceContract {
  final ApiManager _apiManager;

  ProfileDetailsDataSourceImpl(this._apiManager);

  @override
  Future<Result<UserResponse>> getProfileDetails({
    required String token,
    required String userName,
    required String email,
    required String phoneNumber,
    required String password,
    required String firstName,
    required String lastName,
  }) async {
    return await executeApi<UserResponse>(
      () async {
        var apiResponse = await _apiManager.getRequest(
          endPoint: ApiEndpoints.profileDetailsEndpoint,
          queryParamters: {
            "token": token,
            "userName": userName,
            "email": email,
            "phoneNumber": phoneNumber,
            "password": password,
            "firstName": firstName,
            "lastName": lastName,
          },
        );
        var response = UserResponse.fromJson(apiResponse.data ?? {});
        return response;
      },
    );
  }
}
