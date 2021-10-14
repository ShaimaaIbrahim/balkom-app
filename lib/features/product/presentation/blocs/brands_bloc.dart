import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:ojos_app/core/datasources/local/datasources/cached_extra_glasses_dao.dart';
import 'package:ojos_app/core/entities/brand_entity.dart';
import 'package:ojos_app/core/entities/extra_glasses_entity.dart';
import 'package:ojos_app/core/errors/base_error.dart';
import 'package:ojos_app/core/params/no_params.dart';
import 'package:ojos_app/core/repositories/core_repository.dart';
import 'package:ojos_app/core/usecases/get_brands.dart';
import 'package:ojos_app/core/usecases/get_extra_glasses.dart';

import '../../../../main.dart';

@immutable
abstract class BrandsState extends Equatable {}

class BrandsUninitializedState extends BrandsState {
  @override
  String toString() => 'BrandsUninitializedState';

  @override
  List<Object> get props => [];
}

class BrandsLoadingState extends BrandsState {
  @override
  String toString() => 'BrandsLoadingState';

  @override
  List<Object> get props => [];
}

class BrandsDoneState extends BrandsState {
  final List<BrandEntity>? brands;

  BrandsDoneState({this.brands});

  @override
  String toString() => 'BrandsDoneState';

  @override
  List<Object> get props => [];
}

class BrandsFailureState extends BrandsState {
  final BaseError error;

  BrandsFailureState(this.error);

  @override
  String toString() => 'BrandsFailureState';

  @override
  List<Object> get props => [error];
}

@immutable
abstract class BrandsEvent extends Equatable {}

class GetBrandsEvent extends BrandsEvent {
  final CancelToken? cancelToken;

  GetBrandsEvent({
    this.cancelToken,
  });

  @override
  List<Object> get props => [cancelToken!];
}

class BrandsBloc extends Bloc<BrandsEvent, BrandsState> {
  BrandsBloc() : super(BrandsUninitializedState());

  @override
  Stream<BrandsState> mapEventToState(BrandsEvent event) async* {
    if (event is GetBrandsEvent) {
      yield BrandsLoadingState();

      final result = await GetBrands(locator<CoreRepository>())(
        NoParams(cancelToken: event.cancelToken),
      );
      if (result.hasDataOnly) {
        yield BrandsDoneState(brands: result.data!);
      } else {
        final error = result.error;
        yield BrandsFailureState(error!);
      }
    }
  }
}
