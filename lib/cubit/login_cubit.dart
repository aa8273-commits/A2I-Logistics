// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:flutter_bloc/flutter_bloc.dart';
// // import 'package:google_sign_in/google_sign_in.dart';

// // import 'login_state.dart';

// // class LoginCubit extends Cubit<LoginState> {
// //   LoginCubit() : super(LoginInitial()) {
// //     initializeGoogleSignIn();
// //   }

// //   final FirebaseAuth _auth = FirebaseAuth.instance;

// //   final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

// //   Future<void> initializeGoogleSignIn() async {
// //     await _googleSignIn.initialize();
// //   }

// //   Future<void> login({required String email, required String password}) async {
// //     if (email.trim().isEmpty || password.isEmpty) {
// //       emit(LoginError('Please enter your email and password.'));
// //       return;
// //     }

// //     emit(LoginLoading());

// //     try {
// //       final credential = await _auth.signInWithEmailAndPassword(
// //         email: email.trim(),
// //         password: password,
// //       );

// //       final user = credential.user;

// //       if (user == null) {
// //         emit(LoginError('Unable to get user information.'));
// //         return;
// //       }

// //       emit(LoginSuccess(user.email ?? email.trim()));
// //     } on FirebaseAuthException catch (e) {
// //       emit(LoginError(_getLoginErrorMessage(e.code)));
// //     } catch (_) {
// //       emit(LoginError('An unexpected error occurred during login.'));
// //     }
// //   }

// //   Future<void> signInWithGoogle() async {
// //     emit(LoginLoading());

// //     try {
// //       // Open Google's account selection screen.
// //       final GoogleSignInAccount googleUser = await _googleSignIn.authenticate();

// //       // Get the Google ID token.
// //       final GoogleSignInAuthentication googleAuth = googleUser.authentication;

// //       final idToken = googleAuth.idToken;

// //       if (idToken == null) {
// //         emit(LoginError('Unable to get Google authentication token.'));
// //         return;
// //       }

// //       // Create Firebase credential using Google's ID token.
// //       final OAuthCredential credential = GoogleAuthProvider.credential(
// //         idToken: idToken,
// //       );

// //       // Sign in to Firebase.
// //       final UserCredential userCredential = await _auth.signInWithCredential(
// //         credential,
// //       );

// //       final user = userCredential.user;

// //       if (user == null) {
// //         emit(LoginError('Unable to get Google user information.'));
// //         return;
// //       }

// //       emit(LoginSuccess(user.email ?? 'Google User'));
// //     } on GoogleSignInException catch (e) {
// //       emit(
// //         LoginError(
// //           'Google sign-in failed: ${e.description ?? 'Please try again.'}',
// //         ),
// //       );
// //     } on FirebaseAuthException catch (e) {
// //       emit(LoginError(_getLoginErrorMessage(e.code)));
// //     } catch (_) {
// //       emit(LoginError('An unexpected error occurred during Google sign-in.'));
// //     }
// //   }

// //   Future<void> sendPasswordResetEmail({required String email}) async {
// //     final trimmedEmail = email.trim();

// //     if (trimmedEmail.isEmpty) {
// //       emit(PasswordResetError('Please enter your email address first.'));
// //       return;
// //     }

// //     emit(PasswordResetLoading());

// //     try {
// //       await _auth.sendPasswordResetEmail(email: trimmedEmail);

// //       emit(PasswordResetSuccess(trimmedEmail));
// //     } on FirebaseAuthException catch (e) {
// //       emit(PasswordResetError(_getPasswordResetErrorMessage(e.code)));
// //     } catch (_) {
// //       emit(
// //         PasswordResetError(
// //           'Unable to send the password reset email. Please try again.',
// //         ),
// //       );
// //     }
// //   }

// //   String _getLoginErrorMessage(String code) {
// //     switch (code) {
// //       case 'invalid-email':
// //         return 'The email address is invalid.';

// //       case 'user-disabled':
// //         return 'This account has been disabled.';

// //       case 'user-not-found':
// //         return 'No account was found with this email.';

// //       case 'wrong-password':
// //         return 'The password is incorrect.';

// //       case 'invalid-credential':
// //         return 'The email or password is incorrect.';

// //       case 'too-many-requests':
// //         return 'Too many attempts. Please try again later.';

// //       case 'network-request-failed':
// //         return 'Please check your internet connection.';

// //       case 'operation-not-allowed':
// //         return 'Email and password sign-in is not enabled.';

// //       default:
// //         return 'Login failed. Please try again.';
// //     }
// //   }

// //   String _getPasswordResetErrorMessage(String code) {
// //     switch (code) {
// //       case 'invalid-email':
// //         return 'The email address is invalid.';

// //       case 'too-many-requests':
// //         return 'Too many requests. Please try again later.';

// //       case 'network-request-failed':
// //         return 'Please check your internet connection.';

// //       case 'operation-not-allowed':
// //         return 'Password reset is not enabled.';

// //       default:
// //         return 'Unable to send the password reset email. Please try again.';
// //     }
// //   }
// // }
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:google_sign_in/google_sign_in.dart';

// import 'login_state.dart';

// class LoginCubit extends Cubit<LoginState> {
//   LoginCubit() : super(LoginInitial()) {
//     initializeGoogleSignIn();
//   }

//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

//   Future<void> initializeGoogleSignIn() async {
//     await _googleSignIn.initialize();
//   }

//   Future<void> login({
//     required String emailOrPhone,
//     required String password,
//   }) async {
//     final trimmedInput = emailOrPhone.trim();

//     if (trimmedInput.isEmpty || password.isEmpty) {
//       emit(LoginError('Please enter your details and password.'));
//       return;
//     }

//     emit(LoginLoading());

//     try {
//       final isEmail = RegExp(
//         r'^[^@\s]+@[^@\s]+\.[^@\s]+$',
//       ).hasMatch(trimmedInput);

//       if (isEmail) {
//         final credential = await _auth.signInWithEmailAndPassword(
//           email: trimmedInput,
//           password: password,
//         );

//         final user = credential.user;

//         if (user == null) {
//           emit(LoginError('Unable to get user information.'));
//           return;
//         }

//         emit(LoginSuccess(user.email ?? trimmedInput));
//       } else {
//         // في حال تم الإدخال كرقم هاتف
//         emit(LoginError('Phone number login is being processed via SMS code.'));
//       }
//     } on FirebaseAuthException catch (e) {
//       emit(LoginError(_getLoginErrorMessage(e.code)));
//     } catch (_) {
//       emit(LoginError('An unexpected error occurred during login.'));
//     }
//   }

//   Future<void> signInWithGoogle() async {
//     emit(LoginLoading());

//     try {
//       final GoogleSignInAccount googleUser = await _googleSignIn.authenticate();
//       final GoogleSignInAuthentication googleAuth = googleUser.authentication;

//       final idToken = googleAuth.idToken;

//       if (idToken == null) {
//         emit(LoginError('Unable to get Google authentication token.'));
//         return;
//       }

//       final OAuthCredential credential = GoogleAuthProvider.credential(
//         idToken: idToken,
//       );

//       final UserCredential userCredential = await _auth.signInWithCredential(
//         credential,
//       );

//       final user = userCredential.user;

//       if (user == null) {
//         emit(LoginError('Unable to get Google user information.'));
//         return;
//       }

//       emit(LoginSuccess(user.email ?? 'Google User'));
//     } on GoogleSignInException catch (e) {
//       emit(
//         LoginError(
//           'Google sign-in failed: ${e.description ?? 'Please try again.'}',
//         ),
//       );
//     } on FirebaseAuthException catch (e) {
//       emit(LoginError(_getLoginErrorMessage(e.code)));
//     } catch (_) {
//       emit(LoginError('An unexpected error occurred during Google sign-in.'));
//     }
//   }

//   Future<void> sendPasswordResetEmail({required String email}) async {
//     final trimmedEmail = email.trim();

//     if (trimmedEmail.isEmpty) {
//       emit(PasswordResetError('Please enter your email address first.'));
//       return;
//     }

//     emit(PasswordResetLoading());

//     try {
//       await _auth.sendPasswordResetEmail(email: trimmedEmail);
//       emit(PasswordResetSuccess(trimmedEmail));
//     } on FirebaseAuthException catch (e) {
//       emit(PasswordResetError(_getPasswordResetErrorMessage(e.code)));
//     } catch (_) {
//       emit(
//         PasswordResetError(
//           'Unable to send the password reset email. Please try again.',
//         ),
//       );
//     }
//   }

//   String _getLoginErrorMessage(String code) {
//     switch (code) {
//       case 'invalid-email':
//         return 'The email address is invalid.';

//       case 'user-disabled':
//         return 'This account has been disabled.';

//       case 'user-not-found':
//         return 'No account was found with this email.';

//       case 'wrong-password':
//         return 'The password is incorrect.';

//       case 'invalid-credential':
//         return 'The email or password is incorrect.';

//       case 'too-many-requests':
//         return 'Too many attempts. Please try again later.';

//       case 'network-request-failed':
//         return 'Please check your internet connection.';

//       case 'operation-not-allowed':
//         return 'Email and password sign-in is not enabled.';

//       default:
//         return 'Login failed. Please try again.';
//     }
//   }

//   String _getPasswordResetErrorMessage(String code) {
//     switch (code) {
//       case 'invalid-email':
//         return 'The email address is invalid.';

//       case 'too-many-requests':
//         return 'Too many requests. Please try again later.';

//       case 'network-request-failed':
//         return 'Please check your internet connection.';

//       case 'operation-not-allowed':
//         return 'Password reset is not enabled.';

//       default:
//         return 'Unable to send the password reset email. Please try again.';
//     }
//   }
// }
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial()) {
    initializeGoogleSignIn();
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

  String? _verificationId;

  Future<void> initializeGoogleSignIn() async {
    await _googleSignIn.initialize();
  }

  // ============================================================
  // EMAIL OR PHONE LOGIN
  // ============================================================

  Future<void> login({
    required String emailOrPhone,
    required String password,
  }) async {
    final trimmedInput = emailOrPhone.trim();

    if (trimmedInput.isEmpty) {
      emit(LoginError('Please enter your email or phone number.'));
      return;
    }

    final isEmail = RegExp(
      r'^[^@\s]+@[^@\s]+\.[^@\s]+$',
    ).hasMatch(trimmedInput);

    if (isEmail) {
      await _loginWithEmail(email: trimmedInput, password: password);
    } else {
      await sendPhoneCode(trimmedInput);
    }
  }

  // ============================================================
  // EMAIL LOGIN
  // ============================================================

  Future<void> _loginWithEmail({
    required String email,
    required String password,
  }) async {
    if (password.isEmpty) {
      emit(LoginError('Please enter your password.'));
      return;
    }

    emit(LoginLoading());

    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = credential.user;

      if (user == null) {
        emit(LoginError('Unable to get user information.'));
        return;
      }

      emit(LoginSuccess(user.email ?? email));
    } on FirebaseAuthException catch (e) {
      emit(LoginError(_getLoginErrorMessage(e.code)));
    } catch (_) {
      emit(LoginError('An unexpected error occurred during login.'));
    }
  }

  // ============================================================
  // PHONE LOGIN - SEND OTP
  // ============================================================

  Future<void> sendPhoneCode(String phoneNumber) async {
    final phone = phoneNumber.trim();

    if (phone.isEmpty) {
      emit(LoginError('Please enter your phone number.'));
      return;
    }

    emit(LoginLoading());

    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phone,

        verificationCompleted: (PhoneAuthCredential credential) async {
          try {
            final userCredential = await _auth.signInWithCredential(credential);

            final user = userCredential.user;

            if (user == null) {
              emit(
                LoginError(
                  'Unable to get user information after phone verification.',
                ),
              );
              return;
            }

            emit(LoginSuccess(user.email ?? phone));
          } on FirebaseAuthException catch (e) {
            emit(LoginError(_getLoginErrorMessage(e.code)));
          } catch (_) {
            emit(
              LoginError('An unexpected error occurred during phone login.'),
            );
          }
        },

        verificationFailed: (FirebaseAuthException e) {
          emit(
            PhoneVerificationError(_getPhoneVerificationErrorMessage(e.code)),
          );
        },

        codeSent: (String verificationId, int? resendToken) {
          _verificationId = verificationId;

          emit(LoginPhoneCodeSent(verificationId));
        },

        codeAutoRetrievalTimeout: (String verificationId) {
          _verificationId = verificationId;
        },
      );
    } on FirebaseAuthException catch (e) {
      emit(PhoneVerificationError(_getPhoneVerificationErrorMessage(e.code)));
    } catch (_) {
      emit(
        PhoneVerificationError(
          'Unable to send the verification code. Please try again.',
        ),
      );
    }
  }

  // ============================================================
  // PHONE LOGIN - VERIFY OTP
  // ============================================================

  Future<void> verifyPhoneCode({required String smsCode}) async {
    final code = smsCode.trim();

    if (code.isEmpty) {
      emit(PhoneVerificationError('Please enter the verification code.'));
      return;
    }

    if (_verificationId == null) {
      emit(
        PhoneVerificationError(
          'Verification session expired. Please request a new code.',
        ),
      );
      return;
    }

    emit(PhoneVerificationLoading());

    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: _verificationId!,
        smsCode: code,
      );

      final userCredential = await _auth.signInWithCredential(credential);

      final user = userCredential.user;

      if (user == null) {
        emit(PhoneVerificationError('Unable to complete phone login.'));
        return;
      }

      emit(LoginSuccess(user.email ?? user.phoneNumber ?? 'Phone User'));

      _verificationId = null;
    } on FirebaseAuthException catch (e) {
      emit(PhoneVerificationError(_getPhoneVerificationErrorMessage(e.code)));
    } catch (_) {
      emit(
        PhoneVerificationError(
          'An unexpected error occurred while verifying the code.',
        ),
      );
    }
  }

  // ============================================================
  // GOOGLE LOGIN
  // ============================================================

  Future<void> signInWithGoogle() async {
    emit(LoginLoading());

    try {
      final GoogleSignInAccount googleUser = await _googleSignIn.authenticate();

      final GoogleSignInAuthentication googleAuth = googleUser.authentication;

      final idToken = googleAuth.idToken;

      if (idToken == null) {
        emit(LoginError('Unable to get Google authentication token.'));
        return;
      }

      final OAuthCredential credential = GoogleAuthProvider.credential(
        idToken: idToken,
      );

      final UserCredential userCredential = await _auth.signInWithCredential(
        credential,
      );

      final user = userCredential.user;

      if (user == null) {
        emit(LoginError('Unable to get Google user information.'));
        return;
      }

      emit(LoginSuccess(user.email ?? 'Google User'));
    } on GoogleSignInException catch (e) {
      emit(
        LoginError(
          'Google sign-in failed: ${e.description ?? 'Please try again.'}',
        ),
      );
    } on FirebaseAuthException catch (e) {
      emit(LoginError(_getLoginErrorMessage(e.code)));
    } catch (_) {
      emit(LoginError('An unexpected error occurred during Google sign-in.'));
    }
  }

  // ============================================================
  // PASSWORD RESET
  // ============================================================

  Future<void> sendPasswordResetEmail({required String email}) async {
    final trimmedEmail = email.trim();

    if (trimmedEmail.isEmpty) {
      emit(PasswordResetError('Please enter your email address first.'));
      return;
    }

    emit(PasswordResetLoading());

    try {
      await _auth.sendPasswordResetEmail(email: trimmedEmail);

      emit(PasswordResetSuccess(trimmedEmail));
    } on FirebaseAuthException catch (e) {
      emit(PasswordResetError(_getPasswordResetErrorMessage(e.code)));
    } catch (_) {
      emit(
        PasswordResetError(
          'Unable to send the password reset email. Please try again.',
        ),
      );
    }
  }

  // ============================================================
  // EMAIL LOGIN ERRORS
  // ============================================================

  String _getLoginErrorMessage(String code) {
    switch (code) {
      case 'invalid-email':
        return 'The email address is invalid.';

      case 'user-disabled':
        return 'This account has been disabled.';

      case 'user-not-found':
        return 'No account was found with this email.';

      case 'wrong-password':
        return 'The password is incorrect.';

      case 'invalid-credential':
        return 'The email or password is incorrect.';

      case 'too-many-requests':
        return 'Too many attempts. Please try again later.';

      case 'network-request-failed':
        return 'Please check your internet connection.';

      case 'operation-not-allowed':
        return 'Email and password sign-in is not enabled.';

      default:
        return 'Login failed. Please try again.';
    }
  }

  // ============================================================
  // PHONE AUTH ERRORS
  // ============================================================

  String _getPhoneVerificationErrorMessage(String code) {
    switch (code) {
      case 'invalid-phone-number':
        return 'The phone number is invalid.';

      case 'missing-phone-number':
        return 'Please enter your phone number.';

      case 'quota-exceeded':
        return 'SMS quota exceeded. Please try again later.';

      case 'too-many-requests':
        return 'Too many attempts. Please try again later.';

      case 'network-request-failed':
        return 'Please check your internet connection.';

      case 'invalid-verification-code':
        return 'The verification code is incorrect.';

      case 'session-expired':
        return 'The verification code has expired. Please request a new one.';

      case 'credential-already-in-use':
        return 'This phone number is already linked to another account.';

      case 'provider-already-linked':
        return 'This phone number is already linked to this account.';

      case 'operation-not-allowed':
        return 'Phone authentication is not enabled.';

      default:
        return 'Phone verification failed. Please try again.';
    }
  }

  // ============================================================
  // PASSWORD RESET ERRORS
  // ============================================================

  String _getPasswordResetErrorMessage(String code) {
    switch (code) {
      case 'invalid-email':
        return 'The email address is invalid.';

      case 'too-many-requests':
        return 'Too many requests. Please try again later.';

      case 'network-request-failed':
        return 'Please check your internet connection.';

      case 'operation-not-allowed':
        return 'Password reset is not enabled.';

      default:
        return 'Unable to send the password reset email. Please try again.';
    }
  }
}
