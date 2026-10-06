abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final String email;

  LoginSuccess(this.email);
}

class LoginError extends LoginState {
  final String message;

  LoginError(this.message);
}

class PasswordResetLoading extends LoginState {}

class PasswordResetSuccess extends LoginState {
  final String email;

  PasswordResetSuccess(this.email);
}

class PasswordResetError extends LoginState {
  final String message;

  PasswordResetError(this.message);
}

class LoginPhoneCodeSent extends LoginState {
  final String verificationId;

  LoginPhoneCodeSent(this.verificationId);
}

class PhoneVerificationLoading extends LoginState {}

class PhoneVerificationError extends LoginState {
  final String message;

  PhoneVerificationError(this.message);
}
