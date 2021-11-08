import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:ojos_app/core/errors/base_error.dart';
import 'package:ojos_app/features/user_management/data/api_requests/login_request.dart';
import 'package:ojos_app/features/user_management/domain/entities/login_result.dart';
import 'package:ojos_app/features/user_management/domain/repositories/user_repository.dart';
import 'package:ojos_app/features/user_management/domain/usecases/login.dart';
import 'package:ojos_app/main.dart';

abstract class LoginState extends Equatable {}

class LoginUninitialized extends LoginState {
  @override
  List<Object> get props => [];

  @override
  String toString() => 'LoginUninitialized';
}

class LoginLoading extends LoginState {
  @override
  List<Object> get props => [];

  @override
  String toString() => 'LoginLoading';
}

class LoginSuccess extends LoginState {
  final LoginResult? data;

  LoginSuccess({this.data});

  @override
  List<Object> get props => [data!];

  @override
  String toString() => 'LoginSuccess { data: $data }';
}

class LoginSuccessButNeedVerify extends LoginState {
  final LoginResult data;

  LoginSuccessButNeedVerify({required this.data});

  @override
  List<Object> get props => [data];

  @override
  String toString() => 'LoginSuccessButNeedVerify';
}

class LoginFailure extends LoginState {
  final BaseError? error;
  final VoidCallback? callback;

  LoginFailure({
    required this.error,
    this.callback,
  }) : assert(error != null);

  @override
  List<Object> get props => [error!, callback!];

  @override
  String toString() => 'LoginFailure { error: $error }';
}

class LoginEvent extends Equatable {
  final String? username;
  final String? password;
  final String? device_token;
  final bool? isRememberMe;
  final CancelToken? cancelToken;

  LoginEvent({
    required this.username,
    required this.password,
    required this.device_token,
    required this.isRememberMe,
    this.cancelToken,
  })  : assert(username != null),
        assert(password != null);

  @override
  List<Object> get props => [
        username!,
        password!,
        cancelToken!,
      ];

  @override
  String toString() => 'LoginEvent';
}

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginUninitialized());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    yield LoginLoading();
    final result = await LoginUseCase(locator<UserRepository>())(
      LoginParams(
        isRememberMe: event.isRememberMe!,
        data: LoginRequest(
            mobile: event.username!,
            password: event.password!,
            device_token: event.device_token!),
        cancelToken: event.cancelToken,
      ),
    );

    if (result.hasDataOnly) {
      if (result.data!.accessToken!.isNotEmpty) {
        yield LoginSuccess(data: result.data);
      } else {
        yield LoginSuccessButNeedVerify(data: result.data!);
      }
    }
    if (result.hasErrorOnly) {
      yield LoginFailure(
        error: result.error!,
        callback: () {
          this.add(event);
        },
      );
    }
  }
}
