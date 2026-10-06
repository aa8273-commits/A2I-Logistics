// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String? _verificationId;

  User? _pendingUser;

  String? _pendingName;
  String? _pendingEmail;
  String? _pendingRole;

  // ============================================================
  // REGISTER
  // ============================================================

  Future<void> register({
    required String name,
    required String email,
    required String password,
    required String phone,
    required String role,
  }) async {
    final trimmedName = name.trim();
    final trimmedEmail = email.trim();
    final trimmedPhone = phone.trim();
    final trimmedRole = role.trim();

    if (trimmedName.isEmpty ||
        trimmedEmail.isEmpty ||
        password.isEmpty ||
        trimmedPhone.isEmpty ||
        trimmedRole.isEmpty) {
      emit(RegisterError('Please fill in all required fields.'));
      return;
    }

    emit(RegisterLoading());

    try {
      // ----------------------------------------------------------
      // 1. Create Email/Password account
      // ----------------------------------------------------------

      final credential = await _auth.createUserWithEmailAndPassword(
        email: trimmedEmail,
        password: password,
      );

      final user = credential.user;

      if (user == null) {
        emit(RegisterError('Unable to create the account.'));
        return;
      }

      // ----------------------------------------------------------
      // 2. Save temporary registration data
      // ----------------------------------------------------------

      _pendingUser = user;
      _pendingName = trimmedName;
      _pendingEmail = trimmedEmail;
      _pendingRole = trimmedRole;

      await user.updateDisplayName(trimmedName);

      // ----------------------------------------------------------
      // 3. Send phone verification code
      // ----------------------------------------------------------

      await _auth.verifyPhoneNumber(
        phoneNumber: trimmedPhone,

        verificationCompleted: (PhoneAuthCredential credential) async {
          await _completePhoneLink(credential);
        },

        verificationFailed: (FirebaseAuthException e) {
          emit(
            RegisterPhoneVerificationError(
              _getPhoneVerificationErrorMessage(e.code),
            ),
          );
        },

        codeSent: (String verificationId, int? resendToken) {
          _verificationId = verificationId;

          emit(RegisterPhoneCodeSent(verificationId));
        },

        codeAutoRetrievalTimeout: (String verificationId) {
          _verificationId = verificationId;
        },
      );
    } on FirebaseAuthException catch (e) {
      emit(RegisterError(_getErrorMessage(e.code)));
    } catch (_) {
      emit(RegisterError('An unexpected error occurred during registration.'));
    }
  }

  // ============================================================
  // VERIFY PHONE CODE
  // ============================================================

  Future<void> verifyPhoneCode({required String smsCode}) async {
    final code = smsCode.trim();

    if (code.isEmpty) {
      emit(
        RegisterPhoneVerificationError('Please enter the verification code.'),
      );
      return;
    }

    if (_verificationId == null) {
      emit(
        RegisterPhoneVerificationError(
          'Verification session expired. Please request a new code.',
        ),
      );
      return;
    }

    if (_pendingUser == null) {
      emit(
        RegisterPhoneVerificationError(
          'Registration session expired. Please start again.',
        ),
      );
      return;
    }

    emit(RegisterPhoneVerificationLoading());

    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: _verificationId!,
        smsCode: code,
      );

      await _completePhoneLink(credential);
    } on FirebaseAuthException catch (e) {
      emit(
        RegisterPhoneVerificationError(
          _getPhoneVerificationErrorMessage(e.code),
        ),
      );
    } catch (_) {
      emit(
        RegisterPhoneVerificationError(
          'An unexpected error occurred while verifying the code.',
        ),
      );
    }
  }

  // ============================================================
  // LINK PHONE TO SAME ACCOUNT
  // ============================================================

  Future<void> _completePhoneLink(PhoneAuthCredential credential) async {
    final user = _pendingUser;

    if (user == null) {
      emit(
        RegisterPhoneVerificationError(
          'Registration session expired. Please start again.',
        ),
      );
      return;
    }

    emit(RegisterPhoneVerificationLoading());

    try {
      // ----------------------------------------------------------
      // Link phone credential to the SAME Firebase user
      // ----------------------------------------------------------

      await user.linkWithCredential(credential);

      // ----------------------------------------------------------
      // Save user data in Firestore
      // ----------------------------------------------------------

      await _firestore.collection('users').doc(user.uid).set({
        'uid': user.uid,
        'name': _pendingName,
        'email': _pendingEmail,
        'phone': user.phoneNumber,
        'role': _pendingRole,
        'createdAt': FieldValue.serverTimestamp(),
      });

      final registeredEmail = _pendingEmail ?? user.email ?? '';

      // ----------------------------------------------------------
      // Clear temporary data
      // ----------------------------------------------------------

      _verificationId = null;
      _pendingUser = null;
      _pendingName = null;
      _pendingEmail = null;
      _pendingRole = null;

      // ----------------------------------------------------------
      // Sign out after registration
      // ----------------------------------------------------------

      await _auth.signOut();

      emit(RegisterSuccess(registeredEmail));
    } on FirebaseAuthException catch (e) {
      emit(
        RegisterPhoneVerificationError(
          _getPhoneVerificationErrorMessage(e.code),
        ),
      );
    } catch (_) {
      emit(
        RegisterPhoneVerificationError(
          'Unable to complete the registration. Please try again.',
        ),
      );
    }
  }

  // ============================================================
  // EMAIL REGISTRATION ERRORS
  // ============================================================

  String _getErrorMessage(String code) {
    switch (code) {
      case 'invalid-email':
        return 'The email address is invalid.';

      case 'email-already-in-use':
        return 'This email is already in use.';

      case 'weak-password':
        return 'The password is too weak.';

      case 'operation-not-allowed':
        return 'Email and password registration is not enabled.';

      case 'network-request-failed':
        return 'Please check your internet connection.';

      default:
        return 'Registration failed. Please try again.';
    }
  }

  // ============================================================
  // PHONE VERIFICATION ERRORS
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
}
