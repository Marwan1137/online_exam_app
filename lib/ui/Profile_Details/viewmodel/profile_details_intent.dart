sealed class ProfileDetailsIntent {
  const ProfileDetailsIntent();
}

class LoadProfileIntent extends ProfileDetailsIntent {
  const LoadProfileIntent();
}

class UpdateProfileIntent extends ProfileDetailsIntent {
  final String userName;
  final String email;
  final String phoneNumber;
  final String password;
  final String firstName;
  final String lastName;

  const UpdateProfileIntent({
    required this.userName,
    required this.email,
    required this.phoneNumber,
    required this.password,
    required this.firstName,
    required this.lastName,
  });
}
