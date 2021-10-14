import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:ojos_app/core/errors/base_error.dart';
import 'package:ojos_app/features/user_management/data/api_requests/forgot_password_request.dart';
import 'package:ojos_app/features/user_management/data/api_requests/reset_password_request.dart';
import 'package:ojos_app/features/user_management/domain/repositories/user_repository.dart';
import 'package:ojos_app/features/user_management/domain/usecases/forgot_password.dart';
import 'package:ojos_app/features/user_management/domain/usecases/resend_code.dart';
import 'package:ojos_app/features/user_management/domain/usecases/reset_password.dart';
import 'package:ojos_app/main.dart';

abstract class ResetPasswordState extends Equatable {}

class ResetPasswordUninitialized extends ResetPasswordState {
  @override
  List<Object> get props => [];

  @override
  String toString() => 'ResetPasswordUninitialized';
}

class ResetPasswordLoading extends ResetPasswordState {
  @override
  List<Object> get props => [];

  @override
  String toString() => 'ResetPasswordLoading';
}

class ResetPasswordSuccess extends ResetPasswordState {
  @override
  List<Object> get props => [];

  @override
  String toString() => 'ResetPasswordSuccess';
}

class ResetPasswordFailure extends ResetPasswordState {
  final BaseError? error;
  final VoidCallback? callback;

  ResetPasswordFailure({
    required this.error,
    this.callback,
  }) : assert(error != null);

  @override
  List<Object> get props => [error!, callback!];

  @override
  String toString() => 'ResetPasswordFailure { error: $error }';
}

class ResendCodeSuccess extends ResetPasswordState {
  @override
  List<Object> get props => [];

  @override
  String toString() => 'ResendCodeSuccess';
}

class ResendCodeFailure extends ResetPasswordState {
  final BaseError error;
  final VoidCallback? callback;

  ResendCodeFailure({
    required this.error,
    this.callback,
  }) : assert(error != null);

  @override
  List<Object> get props => [error, callback!];

  @override
  String toString() => 'ResendCodeFailure { error: $error }';
}

abstract class BaseResetPasswordEvent extends Equatable {}

class ResetPasswordEvent extends BaseResetPasswordEvent {
  final String? mobile;
  final String? password;
  final String? otp_code;
  final CancelToken? cancelToken;

  ResetPasswordEvent({
    this.mobile,
    this.otp_code,
    this.password,
    this.cancelToken,
  }) : assert(mobile != null);

  @override
  List<Object> get props => [
        mobile!,
        cancelToken!,
        password!,
        otp_code!,
      ];

  @override
  String toString() => 'ResetPasswordEvent';
}

class ResendCodeEvent extends BaseResetPasswordEvent {
  final String? username;
  final String? device_token;
  final CancelToken? cancelToken;

  ResendCodeEvent({this.username, this.cancelToken, this.device_token})
      : assert(username != null);

  @override
  List<Object> get props => [username!, cancelToken!, device_token!];

  @override
  String toString() => 'ResendCodeEvent';
}

class ResetPasswordBloc
    extends Bloc<BaseResetPasswordEvent, ResetPasswordState> {
  ResetPasswordBloc() : super(ResetPasswordUninitialized());

  @override
  Stream<ResetPasswordState> mapEventToState(
      BaseResetPasswordEvent event) async* {
    if (event is ResetPasswordEvent) {
      yield ResetPasswordLoading();
      final result = await ResetPassword(locator<UserRepository>())(
        ResetPasswordParams(
          data: ResetPasswordRequest(
              mobile: event.mobile!,
              otp_code: event.otp_code!,
              password: event.password!),
          cancelToken: event.cancelToken,
        ),
      );
      if (result.hasDataOnly) {
        yield ResetPasswordSuccess();
      }
      if (result.hasErrorOnly) {
        yield ResetPasswordFailure(
          error: result.error,
          callback: () {
            this.add(event);
          },
        );
      }
    }

    if (event is ResendCodeEvent) {
      yield ResetPasswordLoading();
      final result = await ReSendCode(locator<UserRepository>())(
        ReSendCodeParams(
          mobile: event.username!,
//          codeType: CODE_CONFIRM_ACCOUNT,
          device_token: event.device_token!,
          cancelToken: event.cancelToken,
        ),
      );
      if (result.hasDataOnly) {
        yield ResendCodeSuccess();
      }
      if (result.hasErrorOnly) {
        yield ResendCodeFailure(
          error: result.error!,
          callback: () {
            this.add(event);
          },
        );
      }
    }
  }
}
