import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:ojos_app/core/errors/base_error.dart';
import 'package:ojos_app/features/user_management/data/api_requests/forgot_password_request.dart';
import 'package:ojos_app/features/user_management/domain/repositories/user_repository.dart';
import 'package:ojos_app/features/user_management/domain/usecases/forgot_password.dart';
import 'package:ojos_app/main.dart';

abstract class ForgotPasswordState extends Equatable {}

class ForgotPasswordUninitialized extends ForgotPasswordState {
  @override
  List<Object> get props => [];

  @override
  String toString() => 'ForgotPasswordUninitialized';
}

class ForgotPasswordLoading extends ForgotPasswordState {
  @override
  List<Object> get props => [];

  @override
  String toString() => 'ForgotPasswordLoading';
}

class ForgotPasswordSuccess extends ForgotPasswordState {
  final String? mobile;
  final int? code;
  ForgotPasswordSuccess({this.mobile, required this.code});
  @override
  List<Object> get props => [];

  @override
  String toString() => 'ForgotPasswordSuccess';
}

class ForgotPasswordFailure extends ForgotPasswordState {
  final BaseError error;
  final VoidCallback? callback;

  ForgotPasswordFailure({
    required this.error,
    this.callback,
  }) : assert(error != null);

  @override
  List<Object> get props => [error, callback!];

  @override
  String toString() => 'ForgotPasswordFailure { error: $error }';
}

class ForgotPasswordEvent extends Equatable {
  final String? mobile;
  final String? device_token;
  final CancelToken? cancelToken;

  ForgotPasswordEvent({
    this.mobile,
    this.device_token,
    this.cancelToken,
  }) : assert(mobile != null);

  @override
  List<Object> get props => [
        mobile!,
        cancelToken!,
        device_token!,
      ];

  @override
  String toString() => 'ForgotPasswordEvent';
}

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  ForgotPasswordBloc() : super(ForgotPasswordUninitialized());

  @override
  Stream<ForgotPasswordState> mapEventToState(
      ForgotPasswordEvent event) async* {
    yield ForgotPasswordLoading();
    final result = await ForgotPassword(locator<UserRepository>())(
      ForgotPasswordParams(
        data: ForgotPasswordRequest(
            mobile: event.mobile!, device_token: event.device_token!),
        cancelToken: event.cancelToken,
      ),
    );
    if (result.hasDataOnly) {
      yield ForgotPasswordSuccess(
          mobile: event.mobile, code: int.parse(result.data!.otp_code!));
    }
    if (result.hasErrorOnly) {
      yield ForgotPasswordFailure(
        error: result.error!,
        callback: () {
          this.add(event);
        },
      );
    }
  }
}
