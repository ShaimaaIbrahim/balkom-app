import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:ojos_app/core/errors/base_error.dart';
import 'package:ojos_app/core/repositories/core_repository.dart';
import 'package:ojos_app/core/usecases/complaint.dart';
import 'package:ojos_app/core/usecases/contact_us.dart';
import 'package:ojos_app/features/user_management/data/api_requests/forgot_password_request.dart';
import 'package:ojos_app/features/user_management/data/api_requests/reset_password_request.dart';
import 'package:ojos_app/features/user_management/domain/repositories/user_repository.dart';
import 'package:ojos_app/features/user_management/domain/usecases/forgot_password.dart';
import 'package:ojos_app/features/user_management/domain/usecases/resend_code.dart';
import 'package:ojos_app/features/user_management/domain/usecases/reset_password.dart';
import 'package:ojos_app/main.dart';

abstract class ComplaintState extends Equatable {}

class ComplaintUninitialized extends ComplaintState {
  @override
  List<Object> get props => [];

  @override
  String toString() => 'ComplaintUninitialized';
}

class ComplaintLoading extends ComplaintState {
  @override
  List<Object> get props => [];

  @override
  String toString() => 'ComplaintLoading';
}

class ComplaintSuccess extends ComplaintState {
  @override
  List<Object> get props => [];

  @override
  String toString() => 'ComplaintSuccess';
}

class ComplaintFailure extends ComplaintState {
  final BaseError? error;
  final VoidCallback? callback;

  ComplaintFailure({
    required this.error,
    this.callback,
  }) : assert(error != null);

  @override
  List<Object> get props => [error!, callback!];

  @override
  String toString() => 'ComplaintFailure { error: $error }';
}

abstract class BaseComplaintEvent extends Equatable {}

class ComplaintEvent extends BaseComplaintEvent {
  final String? name;
  final String? phone;
  final String? message;
  final String? email;
  final CancelToken? cancelToken;

  ComplaintEvent({
    this.name,
    this.message,
    this.phone,
    this.email,
    this.cancelToken,
  });

  @override
  List<Object> get props => [
        name!,
        cancelToken!,
        message!,
        phone!,
        email!,
      ];

  @override
  String toString() => 'ComplaintEvent';
}

class ComplaintBloc extends Bloc<BaseComplaintEvent, ComplaintState> {
  ComplaintBloc() : super(ComplaintUninitialized());

  @override
  Stream<ComplaintState> mapEventToState(BaseComplaintEvent event) async* {
    if (event is ComplaintEvent) {
      yield ComplaintLoading();
      final result = await ComplaintUseCase(locator<CoreRepository>())(
        ComplaintParams(
          message: event.message!,
          name: event.name!,
          phone: event.phone!,
          email: event.email!,
          cancelToken: event.cancelToken!,
        ),
      );
      if (result.hasDataOnly) {
        yield ComplaintSuccess();
      }
      if (result.hasErrorOnly) {
        yield ComplaintFailure(
          error: result.error!,
          callback: () {
            this.add(event);
          },
        );
      }
    }
  }
}
