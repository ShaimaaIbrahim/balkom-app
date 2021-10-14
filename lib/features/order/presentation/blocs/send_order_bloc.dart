import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:ojos_app/core/errors/base_error.dart';
import 'package:ojos_app/features/order/data/requests/order_request.dart';
import 'package:ojos_app/features/order/domain/entities/general_order_item_entity.dart';
import 'package:ojos_app/features/order/domain/entities/spec_order_item_entity.dart';
import 'package:ojos_app/features/order/domain/repositories/order_repository.dart';
import 'package:ojos_app/features/order/domain/usecases/get_orders.dart';
import 'package:ojos_app/features/order/domain/usecases/send_order.dart';

import '../../../../main.dart';

@immutable
abstract class SendOrderState extends Equatable {}

class SendOrderUninitializedState extends SendOrderState {
  @override
  String toString() => 'SendOrderUninitializedState';

  @override
  List<Object> get props => [];
}

class SendOrderLoadingState extends SendOrderState {
  @override
  String toString() => 'SendOrderLoadingState';

  @override
  List<Object> get props => [];
}

class SendOrderDoneState extends SendOrderState {
  @override
  String toString() => 'SendOrderDoneState ';

  @override
  List<Object> get props => [SendOrders];
}

class SendOrderFailureState extends SendOrderState {
  final BaseError error;
  final VoidCallback? callback;

  SendOrderFailureState({
    required this.error,
    this.callback,
  }) : assert(error != null);

  @override
  List<Object> get props => [error, callback!];

  @override
  String toString() => 'SendOrderFailureState';
}

@immutable
abstract class SendOrderEvent extends Equatable {}

class GetSendOrderEvent extends SendOrderEvent {
  final CancelToken? cancelToken;
  final OrderRequest? request;

  GetSendOrderEvent({
    this.cancelToken,
    this.request,
  });

  @override
  List<Object> get props => [cancelToken!, request!];
}

class SendOrderBloc extends Bloc<SendOrderEvent, SendOrderState> {
  SendOrderBloc() : super(SendOrderUninitializedState());

  @override
  Stream<SendOrderState> mapEventToState(SendOrderEvent event) async* {
    if (event is GetSendOrderEvent) {
      yield SendOrderLoadingState();

      final result = await SendOrders(locator<OrderRepository>())(
        SendOrdersParams(
            cancelToken: event.cancelToken!, request: event.request!),
      );

      ///=============================  Succeed request app info remote ========================================
      if (result.hasDataOnly) {
        yield SendOrderDoneState();
      } else {
        final error = result.error;
        yield SendOrderFailureState(
          error: error!,
          callback: () {
            this.add(event);
          },
        );
      }
    }
  }
}
