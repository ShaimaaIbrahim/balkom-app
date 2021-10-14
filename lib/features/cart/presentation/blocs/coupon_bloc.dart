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

import '../../../../main.dart';

@immutable
abstract class CouponState extends Equatable {}

class CouponUninitializedState extends CouponState {
  @override
  String toString() => 'CouponUninitializedState';

  @override
  List<Object> get props => [];
}

class CouponLoadingState extends CouponState {
  @override
  String toString() => 'CouponLoadingState';

  @override
  List<Object> get props => [];
}

class CouponDoneState extends CouponState {
  final CouponCodeEntity couponInfo;

  CouponDoneState({required this.couponInfo});

  @override
  String toString() => 'CouponDoneState';

  @override
  List<Object> get props => [];
}

class CouponFailureState extends CouponState {
  final BaseError error;

  CouponFailureState(this.error);

  @override
  String toString() => 'CouponFailureState';

  @override
  List<Object> get props => [error];
}

@immutable
abstract class CouponEvent extends Equatable {}

class ApplyCouponEvent extends CouponEvent {
  final CancelToken? cancelToken;
  final String? couponCode;
  final String? total;

  ApplyCouponEvent({
    this.cancelToken,
    this.total,
    this.couponCode,
  });

  @override
  List<Object> get props => [cancelToken!, total!, couponCode!];
}

class CouponBloc extends Bloc<CouponEvent, CouponState> {
  CouponBloc() : super(CouponUninitializedState());

  @override
  Stream<CouponState> mapEventToState(CouponEvent event) async* {
    if (event is ApplyCouponEvent) {
      yield CouponLoadingState();

      final result = await ApplyCouponCode(locator<CartRepository>())(
        ApplyCouponCodeParams(
            couponCode: event.couponCode!,
            total: event.total!,
            cancelToken: event.cancelToken!),
      );

      ///=============================  Succeed request app info remote ========================================
      if (result.hasDataOnly) {
        yield CouponDoneState(couponInfo: result.data!);
      } else {
        final error = result.error;
        yield CouponFailureState(error!);
      }
    }
  }
}
