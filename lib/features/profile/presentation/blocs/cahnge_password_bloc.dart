import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:ojos_app/core/datasources/local/datasources/cached_extra_glasses_dao.dart';
import 'package:ojos_app/core/entities/extra_glasses_entity.dart';
import 'package:ojos_app/core/entities/offer_entity.dart';
import 'package:ojos_app/core/errors/base_error.dart';
import 'package:ojos_app/core/params/no_params.dart';
import 'package:ojos_app/core/repositories/core_repository.dart';
import 'package:ojos_app/core/usecases/get_extra_glasses.dart';
import 'package:ojos_app/core/usecases/get_offers.dart';
import 'package:ojos_app/features/cart/domin/entities/coupon_code_entity.dart';
import 'package:ojos_app/features/cart/domin/repositories/cartr_repository.dart';
import 'package:ojos_app/features/cart/domin/usecases/apply_coupon_code.dart';
import 'package:ojos_app/features/profile/domin/entities/profile_entity.dart';
import 'package:ojos_app/features/profile/domin/repositories/profile_repository.dart';
import 'package:ojos_app/features/profile/domin/usecases/get_user_details.dart';
import 'package:ojos_app/features/profile/domin/usecases/update_user_data.dart';
import 'package:ojos_app/features/user_management/domain/repositories/user_repository.dart';
import 'package:ojos_app/features/user_management/domain/usecases/change_password.dart';

import '../../../../main.dart';

@immutable
abstract class ChangePasswordState extends Equatable {}

class ChangePasswordUninitializedState extends ChangePasswordState {
  @override
  String toString() => 'ChangePasswordUninitializedState';

  @override
  List<Object> get props => [];
}

class ChangePasswordLoadingState extends ChangePasswordState {
  @override
  String toString() => 'ChangePasswordLoadingState';

  @override
  List<Object> get props => [];
}

class ChangePasswordDoneState extends ChangePasswordState {
  @override
  String toString() => 'ChangePasswordDoneState';

  @override
  List<Object> get props => [];
}

class ChangePasswordFailureState extends ChangePasswordState {
  final BaseError error;

  ChangePasswordFailureState(this.error);

  @override
  String toString() => 'ChangePasswordFailureState';

  @override
  List<Object> get props => [error];
}

@immutable
abstract class ChangePasswordEvent extends Equatable {}

class ApplyChangePasswordEvent extends ChangePasswordEvent {
  final CancelToken? cancelToken;
  final String? newPassword;
  final String? oldPassword;

  ApplyChangePasswordEvent({
    this.cancelToken,
    this.newPassword,
    this.oldPassword,
  });

  @override
  List<Object> get props => [cancelToken!, newPassword!, oldPassword!];
}

class ChangePasswordBloc
    extends Bloc<ChangePasswordEvent, ChangePasswordState> {
  ChangePasswordBloc() : super(ChangePasswordUninitializedState());

  @override
  Stream<ChangePasswordState> mapEventToState(
      ChangePasswordEvent event) async* {
    if (event is ApplyChangePasswordEvent) {
      yield ChangePasswordLoadingState();

      final result = await ChangePasswordUseCase(locator<UserRepository>())(
        ChangePasswordParams(queryParameters: {
          'password': event.oldPassword,
          'new_password': event.newPassword
        }, cancelToken: event.cancelToken),
      );

      ///=============================  Succeed request app info remote ========================================
      if (result.hasDataOnly) {
        yield ChangePasswordDoneState();
      } else {
        final error = result.error;
        yield ChangePasswordFailureState(error!);
      }
    }
  }
}
