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

import '../../../../main.dart';

@immutable
abstract class OfferState extends Equatable {}

class OfferUninitializedState extends OfferState {
  @override
  String toString() => 'OfferUninitializedState';

  @override
  List<Object> get props => [];
}

class OfferLoadingState extends OfferState {
  @override
  String toString() => 'OfferLoadingState';

  @override
  List<Object> get props => [];
}

class OfferDoneState extends OfferState {
  final OfferEntity? offer;

  OfferDoneState({this.offer});

  @override
  String toString() => 'OfferDoneState';

  @override
  List<Object> get props => [];
}

class OfferFailureState extends OfferState {
  final BaseError error;

  OfferFailureState(this.error);

  @override
  String toString() => 'OfferFailureState';

  @override
  List<Object> get props => [error];
}

@immutable
abstract class OfferEvent extends Equatable {}

class SetupOfferEvent extends OfferEvent {
  final CancelToken? cancelToken;

  SetupOfferEvent({
    this.cancelToken,
  });

  @override
  List<Object> get props => [cancelToken!];
}

class OfferBloc extends Bloc<OfferEvent, OfferState> {
  OfferBloc() : super(OfferUninitializedState());

  @override
  Stream<OfferState> mapEventToState(OfferEvent event) async* {
    if (event is SetupOfferEvent) {
      yield OfferLoadingState();

      final result = await GetOffers(locator<CoreRepository>())(
        NoParams(cancelToken: event.cancelToken),
      );

      ///=============================  Succeed request app info remote ========================================
      if (result.hasDataOnly) {
        yield OfferDoneState(offer: result.data!);
      } else {
        final error = result.error;
        yield OfferFailureState(error!);
      }
    }
  }
}
