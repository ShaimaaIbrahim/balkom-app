import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ojos_app/core/bloc/application_state.dart';
import 'package:ojos_app/core/res/shared_preference_utils/shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  int? _forceResendingToken;
  late String _phoneNumber;
  String _verificationId = "";
  late String _smsCode;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  String get verificationId => _verificationId;

  String get phoneNumber => _phoneNumber;

  String get smsCode => _smsCode;

  @override
  toString() {
    return '\n phoneNumber1 is : $phoneNumber | '
        ' verificationId is : $verificationId | '
        ' smsCode is : $smsCode | '
        '\n';
  }

  /// When you sign out from the application.
  signOut() {
    _auth.signOut();
  }

  /// Be aware that if you pass a null or a non formatted number the firebase will throw an exception.
  /// and it will not send a SMS
  /// and the number should be with GSM country according to firebase policy
  /// THe format number as following : +963 0933843989 for example.
  Future<void> sendingSMSForProvidedPhoneNumber({
    required String phoneNumber,

    /// this func to tell you if sending sms success or not
    required Function(bool) onSendSMSDone,
  }) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    _phoneNumber = phoneNumber;
    print('phone number is ============================$_phoneNumber');

    try {
      PhoneVerificationCompleted verificationCompleted = (
        PhoneAuthCredential phoneAuthCredential,
      ) async {
        print('Auth completed is ============================$verificationId');

        onSendSMSDone(true);
      };

      PhoneVerificationFailed verificationFailed = (
        FirebaseAuthException authException,
      ) async {
        print('Auth failed is ============================');
        if (onSendSMSDone != null) {
          print('Auth failed is ==========================$onSendSMSDone}');
          onSendSMSDone(false);
        }
      };

      PhoneCodeSent codeSent = (
        String verificationId,
        int? forceResendingToken,
      ) async {
        _forceResendingToken = forceResendingToken ?? null;
        this._verificationId = verificationId;
        print('verificationId is ============================$verificationId');
        preferences.setString('verificationId', verificationId);
        if (onSendSMSDone != null) {
          if (verificationId != null)
            onSendSMSDone(true);
          else
            onSendSMSDone(false);
        }
      };

      PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout = (
        String verificationId,
      ) async {
        this._verificationId = verificationId;
        preferences.setString('verificationId', verificationId);
      };

      await _auth.verifyPhoneNumber(
        codeSent: codeSent,
        phoneNumber: phoneNumber,

        /// This duration to tell firebase after how many times you want to hang fire the sms
        timeout: const Duration(seconds: 60),
        verificationFailed: verificationFailed,

        /// This param used in testing development to enforce the firebase to not block this current user.
        forceResendingToken: _forceResendingToken,
        verificationCompleted: verificationCompleted,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
      );
    } catch (e) {
      print('catch error  is ============================$e');

      onSendSMSDone(false);
    }
  }

  /// Sending code for verification process.
  void signInWithPhoneNumber({
    required String smsCode,
    required Function(bool) onVerifyDone,
  }) async {
    try {
      _smsCode = smsCode;
      SharedPreferences preferences = await SharedPreferences.getInstance();
      this._verificationId = (preferences.getString('verificationId'))!;

      /// now we throw the verification process to firebase
      /// we have to scenarios
      /// 1 - if every things is right and firebase returns credential and after that user
      /// that means the user has entered the verification code correctly

      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCode,
      );
      print('verificationId is ============================$verificationId');

      final User? user = (await _auth.signInWithCredential(credential)).user;
      if (user != null) {
        onVerifyDone(true);
        //appSharedPrefs.saveUserData();
      } else
        onVerifyDone(false);
    } catch (e) {
      /// 2 - if an exception happened that means user did not enter the right code.
      /// and you have to call this method again.
      print('catch error is ============================${e.toString()}');
      onVerifyDone(false);
    }
  }
}
