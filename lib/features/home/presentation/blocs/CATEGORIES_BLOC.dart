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
import 'package:ojos_app/features/product/domin/repositories/product_repository.dart';
import 'package:ojos_app/features/product/domin/usecases/get_products.dart';

import '../../../../main.dart';

@immutable
abstract class CategoryState extends Equatable {}

class CategoryUninitializedState extends CategoryState {
  @override
  String toString() => 'CtegoryUninitializedState';

  @override
  List<Object> get props => [];
}

class CategoryLoadingState extends CategoryState {
  @override
  String toString() => 'CtegoryLoadingState';

  @override
  List<Object> get props => [];
}

class CategoryDoneState extends CategoryState {
  final List<CategoryEntity>? categories;

  CategoryDoneState({this.categories});

  @override
  String toString() => 'CtegoryDoneState';

  @override
  List<Object> get props => [];
}

class CategoryFailureState extends CategoryState {
  final BaseError error;

  CategoryFailureState(this.error);

  @override
  String toString() => 'CtegoryFailureState';

  @override
  List<Object> get props => [error];
}

@immutable
abstract class CategoryEvent extends Equatable {}

class SetupCategoryEvent extends CategoryEvent {
  final CancelToken? cancelToken;

  SetupCategoryEvent({
    this.cancelToken,
  });

  @override
  List<Object> get props => [cancelToken!];
}

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc() : super(CategoryUninitializedState());

  @override
  Stream<CategoryState> mapEventToState(CategoryEvent event) async* {
    if (event is SetupCategoryEvent) {
      yield CategoryLoadingState();

      final result = await GetCategories(locator<CoreRepository>())(
        NoParams(cancelToken: event.cancelToken),
      );

      ///=============================  Succeed request app info remote ========================================
      if (result.hasDataOnly) {
        // for(int i =0 ; i< result.data!.length; i++){
        //    await GetProduct(locator<ProductRepository>())(
        //     GetProductParams(
        //       page: 0,
        //       pagesize: 100,
        //       filterParams: {"category_id": result.data![i].id},
        //       cancelToken: event.cancelToken!,
        //     ),
        //   );
        // }
        yield CategoryDoneState(categories: result.data!);
      } else {
        final error = result.error;
        yield CategoryFailureState(error!);
      }
    }
  }
}