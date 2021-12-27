import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:ojos_app/features/user_management/domain/repositories/user_repository.dart';


@immutable
abstract class RetrieveState extends Equatable {}

class RetrieveUninitializedState extends RetrieveState {
  @override
  String toString() => 'CouponUninitializedState';

  @override
  List<Object> get props => [];
}

class RetrieveLoadingState extends RetrieveState {
  @override
  String toString() => 'CouponLoadingState';

  @override
  List<Object> get props => [];
}

class RetrieveDoneState extends RetrieveState {
  final Object resonse;

  RetrieveDoneState({required this.resonse});

  @override
  String toString() => 'CouponDoneState';

  @override
  List<Object> get props => [];
}

class RetrieveFailureState extends RetrieveState {
  final String? error;

  RetrieveFailureState(this.error);

  @override
  String toString() => 'CouponFailureState';

  @override
  List<Object> get props => [error!];
}

@immutable
abstract class RetrieveEvent extends Equatable {}

class ApplyRetrieveEvent extends RetrieveEvent {
  final CancelToken? cancelToken;
  final String? place;
  final String? reason;
  final String? name;
  final String? phone;
  final String? productId;
  final String? orderId;

  ApplyRetrieveEvent({
    this.place,
    this.reason,
    this.name,
    this.phone,
    this.productId,
    this.cancelToken,
    this.orderId,
  });

  @override
  List<Object> get props => [cancelToken!];
}

class RetrieveBloc extends Bloc<RetrieveEvent, RetrieveState> {
  RetrieveBloc() : super(RetrieveUninitializedState());

  @override
  Stream<RetrieveState> mapEventToState(RetrieveEvent event) async* {
    //  dio.options.headers['_method'] = 'post';

    if (event is ApplyRetrieveEvent) {
      yield RetrieveLoadingState();
      Dio dio = Dio();
      if (await UserRepository.hasToken) {
        final token = await UserRepository.authToken;
        dio.options.headers["Authorization"] = "Bearer $token";
      }
      // dio.options.headers['content-Type'] = 'application/json';
      // dio.options.contentType = "application/json";
      dio.options.headers['Accept'] = 'application/json';

      Response result = await dio.post(
        'https://bilqom.com/api/auth/product-retriev',
        cancelToken: event.cancelToken,
        data: {
          'phone': event.phone!,
          'reason': event.reason!,
          'order_id': 3,
          'place': event.place!,
          'name': event.name!,
          'product_id': 1
        },
        onSendProgress: (int sent, int total) {
          print('$sent $total');
        },
      );

      ///=============================  Succeed request app info remote ========================================
      if (result.statusCode == 200) {
        yield RetrieveDoneState(resonse: result.data!);
      } else {
        final error = result.statusMessage;
        yield RetrieveFailureState(error);
      }
    }
  }
}
