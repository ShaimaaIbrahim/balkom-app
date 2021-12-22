import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:ojos_app/core/errors/base_error.dart';
import 'package:ojos_app/features/user_management/data/api_requests/register_request.dart';
import 'package:ojos_app/features/user_management/domain/entities/register_result.dart';
import 'package:ojos_app/features/user_management/domain/repositories/user_repository.dart';
import 'package:ojos_app/features/user_management/domain/usecases/register.dart';
import 'package:ojos_app/main.dart';

abstract class RegisterState extends Equatable {}

class RegisterUninitialized extends RegisterState {
  @override
  List<Object> get props => [];

  @override
  String toString() => 'RegisterUninitialized';
}

class RegisterLoading extends RegisterState {
  @override
  List<Object> get props => [];

  @override
  String toString() => 'RegisterLoading';
}

class RegisterSuccess extends RegisterState {
  final RegisterResult data;

  RegisterSuccess({required this.data});

  @override
  List<Object> get props => [data];

  @override
  String toString() => 'RegisterSuccess { data: $data }';
}

class RegisterFailure extends RegisterState {
  final BaseError? error;
  final VoidCallback? callback;

  RegisterFailure({
    this.error,
    this.callback,
  }) : assert(error != null);

  @override
  List<Object> get props => [error!, callback!];

  @override
  String toString() => 'RegisterFailure { error: $error }';
}

class RegisterEvent extends Equatable {
  final String name;
  final String email;
  final String password;
  final String device_token;
  final CancelToken? cancelToken;

  RegisterEvent({
    required this.email,
    required this.name,
    required this.password,
    required this.device_token,
    this.cancelToken,
  })  : assert(email != null),
        assert(name != null),
        assert(password != null);

  @override
  List<Object> get props => [
        name,
        email,
        password,
        device_token,
        cancelToken!,
      ];

  @override
  String toString() => 'RegisterEvent';
}

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterUninitialized());

  @override
  Stream<RegisterState> mapEventToState(RegisterEvent event) async* {
    yield RegisterLoading();
    final result = await RegisterUseCase(locator<UserRepository>())(
      RegisterParams(
        bodyParam: RegisterRequest(
          phone: event.email,
            name: event.name,
            email: event.email,
            password: event.password,
            device_token: event.device_token),
        cancelToken: event.cancelToken,
      ),
    );
    if (result.hasDataOnly) {
      yield RegisterSuccess(data: result.data!);
    }
    if (result.hasErrorOnly) {
      yield RegisterFailure(
        error: result.error!,
        callback: () {
          this.add(event);
        },
      );
    }
  }
}
