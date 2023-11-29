abstract class AppSignupStates {}

class AppSignupInitialState extends AppSignupStates {}

class AppSignupLoadingState extends AppSignupStates {}

class AppSignupSuccessState extends AppSignupStates {}

class AppSignupErrorState extends AppSignupStates {
  final String error;
  AppSignupErrorState(this.error);
}

class AppCreateUserSuccessState extends AppSignupStates {}

class AppCreateUserErrorState extends AppSignupStates {
  final String error;
  AppCreateUserErrorState(this.error);
}

class AppChangePasswordVisibilitySignupState extends AppSignupStates {}

class AppProfileImagePickedErrorState extends AppSignupStates {}

class AppUserUpdateLoadingState extends AppSignupStates {}

class AppUploadProfileImageErrorState extends AppSignupStates {}

class AppProfileImagePickedSuccessState extends AppSignupStates {}
