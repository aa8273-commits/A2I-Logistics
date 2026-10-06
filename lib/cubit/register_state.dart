// abstract class RegisterState {}

// class RegisterInitial extends RegisterState {}

// class RegisterLoading extends RegisterState {}

// class RegisterSuccess extends RegisterState {
//   final String email;

//   RegisterSuccess(this.email);
// }

// class RegisterError extends RegisterState {
//   final String message;

//   RegisterError(this.message);
// }
abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterSuccess extends RegisterState {
  final String email;

  RegisterSuccess(this.email);
}

class RegisterError extends RegisterState {
  final String message;

  RegisterError(this.message);
}

// Phone verification
class RegisterPhoneCodeSent extends RegisterState {
  final String verificationId;

  RegisterPhoneCodeSent(this.verificationId);
}

class RegisterPhoneVerificationLoading extends RegisterState {}

class RegisterPhoneVerificationError extends RegisterState {
  final String message;

  RegisterPhoneVerificationError(this.message);
}
