import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:ojos_app/core/errors/base_error.dart';
import 'package:ojos_app/features/order/data/models/general_order_item_model.dart';
import 'package:ojos_app/features/order/domain/entities/general_order_item_entity.dart';
import 'package:ojos_app/features/order/domain/entities/spec_order_item_entity.dart';
import 'package:ojos_app/features/order/domain/repositories/order_repository.dart';
import 'package:ojos_app/features/order/domain/usecases/delete_order.dart';
import 'package:ojos_app/features/order/domain/usecases/get_orders.dart';

import '../../../../main.dart';
import 'package:get/get.dart' as Get;

@immutable
abstract class OrderState extends Equatable {}

class OrderUninitializedState extends OrderState {
  @override
  String toString() => 'OrderUninitializedState';

  @override
  List<Object> get props => [];
}

class OrderLoadingState extends OrderState {
  @override
  String toString() => 'OrderLoadingState';

  @override
  List<Object> get props => [];
}

class DoneDeleteOrder extends OrderState {
  @override
  String toString() => 'DoneDeleteOrder';
  @override
  List<Object?> get props => [];
}

class FailureDeleteOrder extends OrderState {
  final BaseError? error;

  FailureDeleteOrder({this.error});

  @override
  String toString() => 'FailureDeleteOrder';
  @override
  List<Object?> get props => [];
}

class OrderDoneState extends OrderState {
  final List<GeneralOrderItemEntity>? orders;
  final bool? withTrack;

  OrderDoneState({this.orders, this.withTrack});

  @override
  String toString() => 'OrderDoneState data ${orders.toString()}';

  @override
  List<Object> get props => [orders!, withTrack!];
}

class StateLoadingState extends OrderState {
  @override
  List<Object?> get props => [];
}

class LoadingDeleteState extends OrderState {
  @override
  String toString() => 'LoadingDeleting data';

  @override
  List<Object> get props => [];
}

class OrderFailureState extends OrderState {
  final BaseError error;

  OrderFailureState(this.error);

  @override
  String toString() => 'OrderFailureState';

  @override
  List<Object> get props => [error];
}

class OrderDoneStateState extends OrderState {
  final List<GeneralOrderItemEntity>? orders;
  final bool? withTrack;

  OrderDoneStateState({this.orders, this.withTrack});

  @override
  List<Object?> get props => [orders!, withTrack!];
}

@immutable
abstract class OrderEvent extends Equatable {}

class GetOrderEvent extends OrderEvent {
  final CancelToken? cancelToken;
  final Map<String, String>? filterParams;

  GetOrderEvent({
    this.cancelToken,
    this.filterParams,
  });

  @override
  List<Object> get props => [cancelToken!, filterParams!];
}

class StatusOrder extends OrderEvent {
  String? status;
  final CancelToken? cancelToken;
  final Map<String, String>? filterParams;

  StatusOrder({this.status, this.filterParams, this.cancelToken});
  @override
  List<Object?> get props => [status!, filterParams!, cancelToken!];
}

class DeleteOrderEvent extends OrderEvent {
  final CancelToken? cancelToken;
  final int? id;
  final Map<String, String>? filterparams;

  DeleteOrderEvent({this.cancelToken, this.id, required this.filterparams});

  @override
  List<Object?> get props => [id ?? 0, cancelToken ?? ''];
}

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc() : super(OrderUninitializedState());

  @override
  Stream<OrderState> mapEventToState(OrderEvent event) async* {
    if (event is GetOrderEvent) {
      yield OrderLoadingState();

      final result = await GetOrders(locator<OrderRepository>())(
        GetOrdersParams(
            cancelToken: event.cancelToken, filterParams: event.filterParams),
      );

      if (result.hasDataOnly) {
        final List<GeneralOrderItemEntity> listOfResult = result.data!;
        yield OrderDoneState(orders: listOfResult, withTrack: false);
      } else {
        final error = result.error;
        yield OrderFailureState(error!);
      }
    }

    if (event is DeleteOrderEvent) {
      yield LoadingDeleteState();
      final result = await DeleteOrder(locator<OrderRepository>())(
          DeleteOrderParams(cancelToken: event.cancelToken, id: event.id!));

      if (result.hasDataOnly) {
        final result1 = await GetOrders(locator<OrderRepository>())(
            GetOrdersParams(
                cancelToken: event.cancelToken,
                filterParams: event.filterparams));

        if (result1.hasDataOnly) {
          final List<GeneralOrderItemEntity> listOfResult = result1.data!;
          yield DoneDeleteOrder();
          yield OrderDoneState(orders: listOfResult, withTrack: true);
        } else {
          final error = result1.error;
          yield FailureDeleteOrder(error: error);
        }
      } else {
        final error = result.error;
        yield FailureDeleteOrder(error: error);
      }
    }

    if (event is StatusOrder) {
      yield StateLoadingState();

      final result = await GetOrders(locator<OrderRepository>())(
        GetOrdersParams(
            cancelToken: event.cancelToken, filterParams: event.filterParams),
      );
      if (result.hasDataOnly) {
        List<GeneralOrderItemEntity> orders = [];
        final List<GeneralOrderItemEntity> listOfResult = result.data!;
        for (GeneralOrderItemEntity v in listOfResult) {
          if (v.status == event.status) {
            orders.add(v);
          }
        }
        yield OrderDoneStateState(orders: orders, withTrack: true);
      } else {
        final error = result.error;
        yield OrderFailureState(error!);
      }
    }
  }
}
