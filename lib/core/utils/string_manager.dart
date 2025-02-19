class AppStrings {
  /* -------------------------------------------------------------------------- */
  /*                          APPLICATION TEXT STRINGS                          */
  /* -------------------------------------------------------------------------- */
  static const String login = "Login";
  static const String email = "Email";
  static const String enterYourEmail = "Enter your e-mail";
  static const String password = "Password";
  static const String rememberMe = "Remember me";
  static const String forgetpassword = "Forget password?";
  static const String dontHaveAccount = "Don't have account?";
  /* -------------------------------------------------------------------------- */
  /* -------------------------------------------------------------------------- */
  static const String signUp = "Sign up";
  static const String userName = "Username";
  static const String enterUserName = "Enter your username";
  static const String firstName = "Firstname";
  static const String enterYourFirstName = "Enter your Firstname";
  static const String lastName = "Lastname";
  static const String enterYourLastName = "Enter your lastname";
  static const String confirmPassword = "Confirm password";
  static const String phoneNumber = "Phone number";
  static const String enterYourPhoneNumber = "Enter your phone number";
  static const String signUpSuccessfully = "Sign Up successful";
  static const String alreadyHaveAnAccount = "Already have an account?";
  /* -------------------------------------------------------------------------- */
  /* -------------------------------------------------------------------------- */
  static const String profile = "Profile";
  static const String updatesDoneSucceffully =
      "Updates has been done Successful";
  static const String update = "Update";
  /* -------------------------------------------------------------------------- */
  /* -------------------------------------------------------------------------- */
  static const String emailVerification = "Email verification";
  static const String sendedCode = '''
Please enter your code that send to your
 email address''';
  static const String dontRecieveCode = "Don't recieved code?";
  static const String resend = "Resend";
  static const String pleaseEnterEmailsAssociatedToUrAccount =
      ''' Please enter your email associated to
your account''';
  static const String continu = "Continue";
  static const String newPassword = "New Password";
  static const String passwordvalid =
      '''Password must not be empty and must contain
6 characters with an uppercase letter and one
number at least''';
  static const String resetPassword = "Reset password";

  /* -------------------------------------------------------------------------- */
  /*                               Validator Text                               */
  /* -------------------------------------------------------------------------- */

  static const String emailCantBeEmpty = "Email cannot be empty";
  static const String thePinCodeIsWrong = "The Pin Code is Wrong";
  static const String enterValidEmailAddress = "Enter a valid email address";
  static const String passwordCantBeEmpty = "Password cannot be empty";
  static const String passwordMustBeAtLeast6Characters =
      "Password must be at least 6 characters";
  static const String passwordMustContainAtLeastOneUppercaseLetter =
      "Password must contain at least one uppercase letter";
  static const String passwordMustContainAtLeastOneNumber =
      "Password must contain at least one number";
  static const String passwordsDoNotMatch = "Passwords do not match";
  static const String userNameCannotBeEmpty = "User name cannot be empty";
  static const String userNameCannotBeMoreThan20Characters =
      "User name cannot be more than 20 characters";
  static const String firstNameCannotBeEmpty = "First name cannot be empty";
  static const String firstNameCannotBeMoreThan20Characters =
      "First name cannot be more than 20 characters";
  static const String lastNameCannotBeEmpty = "Last name cannot be empty";
  static const String lastNameCannotBeMoreThan20Characters =
      "Last name cannot be more than 20 characters";
  static const String phoneNumberCannotBeEmpty = "Phone number cannot be empty";
  static const String phoneNumberCannotBeMoreThan20Characters =
      "Phone number cannot be more than 20 characters";

  static const String passwordMustContainAtLeastOneSpecialCharacter =
      "Password Must Contain At Least One Special Character";

  /* -------------------------------------------------------------------------- */
  /*                         APPLICATION ROUTES STRINGS                          */
  /* -------------------------------------------------------------------------- */
  static const String homeScreenRoute = '/Homescreen';
  static const String loginScreenRoute = '/Login';
  static const String singUpScreenRoute = '/SignUp';
  static const String profileDetailsScreenRoute = '/ProfileDetails';
  static const String enterEmailForgetPasswordScreenRoute =
      '/EnterEmailForgetPassword';
  static const String emailVerificationScreenRoute = '/EmailVerification';
  static const String putNewPasswordScreenRoute = '/PutNewPassword';
}
