import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:ojos_app/core/datasources/local/datasources/cached_extra_glasses_dao.dart';
import 'package:ojos_app/core/entities/category_entity.dart';
import 'package:ojos_app/core/entities/extra_glasses_entity.dart';
import 'package:ojos_app/core/entities/offer_entity.dart';
import 'package:ojos_app/core/errors/base_error.dart';
import 'package:ojos_app/core/params/no_params.dart';
import 'package:ojos_app/core/repositories/core_repository.dart';
import 'package:ojos_app/core/usecases/get_categories.dart';
import 'package:ojos_app/core/usecases/get_extra_glasses.dart';
import 'package:ojos_app/core/usecases/get_offers.dart';
import 'package:ojos_app/features/product/domin/entities/product_entity.dart';
import 'package:ojos_app/features/product/domin/repositories/product_repository.dart';
import 'package:ojos_app/features/product/domin/usecases/get_products.dart';

import '../../../../main.dart';

@immutable
abstract class ProductsState extends Equatable {}

class CategoryUninitializedState extends ProductsState {
  @override
  String toString() => 'CtegoryUninitializedState';

  @override
  List<Object> get props => [];
}

class ProductsLoadingState extends ProductsState {
  @override
  String toString() => 'CtegoryLoadingState';

  @override
  List<Object> get props => [];
}

class ProductsDoneState extends ProductsState {
  final List<ProductEntity>? products;

  ProductsDoneState({this.products});

  @override
  String toString() => 'CtegoryDoneState';

  @override
  List<Object> get props => [];
}

class ProductsFailureState extends ProductsState {
  final BaseError error;

  ProductsFailureState(this.error);

  @override
  String toString() => 'CtegoryFailureState';

  @override
  List<Object> get props => [error];
}

@immutable
abstract class ProductsEvent extends Equatable {}

class SetupProductsEvent extends ProductsEvent {
  final CancelToken? cancelToken;
  final String? id;

  SetupProductsEvent({
    this.cancelToken,
    this.id,
  });

  @override
  List<Object> get props => [cancelToken!];
}

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  ProductsBloc() : super(CategoryUninitializedState());

  @override
  Stream<ProductsState> mapEventToState(ProductsEvent event) async* {
    if (event is SetupProductsEvent) {
      yield ProductsLoadingState();

      final result = await GetProduct(locator<ProductRepository>())(
        GetProductParams(
          page: 0,
          pagesize: 100,
          filterParams: {"category_id": event.id},
          cancelToken: event.cancelToken!,
        ),
      );
      ///=============================  Succeed request app info remote ========================================
      if (result.hasDataOnly) {
        yield ProductsDoneState(products: result.data!);
      } else {
        final error = result.error;
        yield ProductsFailureState(error!);
      }
    }
  }
}