import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:ojos_app/core/errors/base_error.dart';
import 'package:ojos_app/core/results/result.dart';

@immutable
abstract class SmartListState extends Equatable {
  SmartListState([List props = const []]);
}

class ListUninitializedState extends SmartListState {
  @override
  String toString() => 'ListUninitializedState';

  @override
  List<Object?> get props => [];
}

class ListWaitingForInitialDataState extends SmartListState {
  @override
  String toString() => 'ListWaitingForInitialDataState';

  @override
  List<Object?> get props => [];
}

class ListEmptyState extends SmartListState {
  @override
  String toString() => 'ListEmptyState';

  @override
  List<Object?> get props => [];
}

class ListInitialDataFetchedState extends SmartListState {
  @override
  String toString() => 'ListInitialDataFetchedState';

  @override
  List<Object?> get props => [];
}

class ListConnectionErrorState extends SmartListState {
  final VoidCallback callback;

  ListConnectionErrorState({required this.callback}) : super([callback]);

  @override
  String toString() => 'ListConnectionErrorState { callback: $callback }';

  @override
  List<Object?> get props => [];
}

//class ListResponseErrorState extends SmartListState {
//  final String message;
//
//  ListResponseErrorState({required this.message})
//      : assert(message != null),
//        super([message]);
//
//  @override
//  String toString() => 'ListResponseErrorState { message: $message }';
//}

class ListRefreshingState extends SmartListState {
  @override
  String toString() => 'ListRefreshingState';

  @override
  List<Object?> get props => [];
}

class ListRefreshDoneState extends SmartListState {
  @override
  String toString() => 'ListRefreshDoneState';

  @override
  List<Object?> get props => [];
}

class ListLoadingState extends SmartListState {
  @override
  String toString() => 'ListLoadingState';

  @override
  List<Object?> get props => [];
}

class ListLoadSuccessState extends SmartListState {
  @override
  String toString() => 'ListLoadSuccessState';

  @override
  List<Object?> get props => [];
}

class ListLoadFailedState extends SmartListState {
  final VoidCallback callback;

  ListLoadFailedState({required this.callback}) : super([callback]);

  @override
  String toString() => 'ListLoadFailedState { callback: $callback }';

  @override
  List<Object?> get props => [];
}

class ListLoadNoDataState extends SmartListState {
  @override
  String toString() => 'ListLoadNoDataState';

  @override
  List<Object?> get props => [];
}

/// New States
class DataWithoutErrorState extends SmartListState {
  @override
  String toString() => 'DataWithoutErrorState';

  @override
  List<Object?> get props => [];
}

class DataWithConnectionErrorState extends SmartListState {
  final VoidCallback callback;

  DataWithConnectionErrorState({required this.callback}) : super([callback]);

  @override
  String toString() => 'DataWithConnectionErrorState { callback: $callback }';

  @override
  List<Object?> get props => [];
}

class DataWithCustomErrorState extends SmartListState {
  final String message;

  DataWithCustomErrorState({required this.message}) : super([message]);

  @override
  String toString() => 'DataWithCustomErrorState { message: $message }';

  @override
  List<Object?> get props => [];
}

class EmptyState extends SmartListState {
  @override
  String toString() => 'EmptyState';

  @override
  List<Object?> get props => [];
}

class LoadingState extends SmartListState {
  @override
  String toString() => 'LoadingState';

  @override
  List<Object?> get props => [];
}

class ConnectionErrorState extends SmartListState {
  final VoidCallback callback;

  ConnectionErrorState({required this.callback}) : super([callback]);

  @override
  String toString() => 'ConnectionErrorState { callback: $callback }';

  @override
  List<Object?> get props => [];
}

class CustomErrorState extends SmartListState {
  final String message;

  CustomErrorState({required this.message}) : super([message]);

  @override
  String toString() => 'CustomErrorState { message: $message }';

  @override
  List<Object?> get props => [];
}

class LoadCompletedState extends SmartListState {
  @override
  String toString() => 'LoadCompletedState';

  @override
  List<Object?> get props => [];
}

class LoadFailedState extends SmartListState {
  @override
  String toString() => 'LoadFailedState';

  @override
  List<Object?> get props => [];
}

class LoadNoDataState extends SmartListState {
  @override
  String toString() => 'LoadNoDataState';

  @override
  List<Object?> get props => [];
}

class RefreshCompletedState extends SmartListState {
  @override
  String toString() => 'RefreshCompletedState';

  @override
  List<Object?> get props => [];
}

class RefreshFailedWithConnectionErrorState extends SmartListState {
  final VoidCallback callback;

  RefreshFailedWithConnectionErrorState({required this.callback})
      : super([callback]);

  @override
  String toString() =>
      'RefreshFailedWithConnectionErrorState { callback: $callback }';

  @override
  List<Object?> get props => [];
}

class RefreshFailedWithCustomErrorState extends SmartListState {
  final String message;

  RefreshFailedWithCustomErrorState({required this.message}) : super([message]);

  @override
  String toString() =>
      'RefreshFailedWithCustomErrorState { message: $message }';

  @override
  List<Object?> get props => [];
}

@immutable
abstract class SmartListEvent extends Equatable {
  SmartListEvent([List props = const []]);
}

class InitializeEvent<T> extends SmartListEvent {
  final Future<Result<BaseError, List<T>>> Function(
    int pageSize,
    int pageIndex,
  ) onInitialize;

  InitializeEvent(this.onInitialize);

  @override
  String toString() => 'InitializeEvent';

  @override
  List<Object?> get props => [];
}

class RefreshEvent<T> extends SmartListEvent {
  final Future<Result<BaseError, List<T>>> Function(
    int pageSize,
    int pageIndex,
  ) onRefresh;

  RefreshEvent(this.onRefresh);

  @override
  String toString() => 'RefreshEvent';

  @override
  List<Object?> get props => [];
}

class LoadEvent<T> extends SmartListEvent {
  final Future<Result<BaseError, List<T>>> Function(
    int pageSize,
    int pageIndex,
  ) onLoad;

  LoadEvent(this.onLoad);

  @override
  String toString() => 'LoadEvent';

  @override
  List<Object?> get props => [];
}

// class SmartListBloc<T> extends Bloc<SmartListEvent, SmartListState> {
//   final int pageSize;
//   final int initialPageIndex;
//   int _currentPageIndex;
//   final List<T> items = [];
//
//   SmartListBloc({this.pageSize, this.initialPageIndex}) : super(ListUninitializedState()) {
//     _currentPageIndex = initialPageIndex;
//   }
//
//
//   @override
//   Stream<SmartListState> mapEventToState(SmartListEvent event) async* {
//     if (event is InitializeEvent<T>) {
//       yield LoadingState();
//       final result = await event.onInitialize(pageSize, _currentPageIndex);
//       if (result.hasDataOnly) {
//         // result has data
//         if (result.hasDataOnly) {
//           // has data without error
//           if (result.data.isEmpty) {
//             // the data is empty
//             yield EmptyState();
//           } else {
//             // the data is not empty
// //            _currentPageIndex++;
//             items.clear();
//             items.addAll(result.data);
//             yield DataWithoutErrorState();
//           }
//         } else {
//           // has data with error
//           if (result.error is ConnectionError) {
//             // connection error
//             items.clear();
//             items.addAll(result.data);
//             yield DataWithConnectionErrorState(callback: () {
//               this.add(event);
//             });
//           }
//           if (result.error is CustomError) {
//             // custom error
//             items.clear();
//             items.addAll(result.data);
//             yield DataWithCustomErrorState(
//                 message: (result.error as CustomError).message);
//           }
//         }
//       } else {
//         // result has no data
//         if (result.hasErrorOnly) {
//           if (result.error is ConnectionError) {
//             yield ConnectionErrorState(callback: () {
//               this.add(event);
//             });
//           }
//           if (result.error is CustomError) {
//             yield CustomErrorState(
//                 message: (result.error as CustomError).message);
//           }
//         }
//       }
//     }
//     if (event is RefreshEvent<T>) {
//       final result = await event.onRefresh(pageSize, initialPageIndex);
//       if (result.hasDataAndError) {
//         // result has data
//         if (result.hasDataOnly) {
//           // has data without error
//           if (result.data.isEmpty) {
//             // the data is empty
//             yield RefreshCompletedState();
//             yield EmptyState();
//           } else {
//             // the data is not empty
//             _currentPageIndex = initialPageIndex;
//             items.clear();
//             items.addAll(result.data);
//             yield RefreshCompletedState();
//             yield DataWithoutErrorState();
//           }
//         } else {
//           // has data with error
//           if (result.error is ConnectionError) {
//             // connection error
//             _currentPageIndex = initialPageIndex;
//             items.clear();
//             items.addAll(result.data);
//             yield RefreshFailedWithConnectionErrorState(callback: () {
//               this.add(InitializeEvent<T>(event.onRefresh));
//             });
//           }
//           if (result.error is CustomError) {
//             // custom error
//             _currentPageIndex = initialPageIndex;
//             items.clear();
//             items.addAll(result.data);
//             yield RefreshFailedWithCustomErrorState(
//                 message: (result.error as CustomError).message);
//           }
//         }
//       } else {
//         // result has no data
//         if (result.hasErrorOnly) {
//           if (result.error is ConnectionError) {
//             yield ConnectionErrorState(callback: () {
//               this.add(event);
//             });
//           }
//           if (result.error is CustomError) {
//             yield CustomErrorState(
//                 message: (result.error as CustomError).message);
//           }
//         }
//       }
//     }
//     if (event is LoadEvent<T>) {
//       final result = await event.onLoad(pageSize, _currentPageIndex + 1);
//       if (result.hasDataOnly) {
//         if (result.data.isEmpty) {
//           yield LoadNoDataState();
//           yield DataWithoutErrorState();
//         } else {
//           _currentPageIndex++;
//           items.addAll(result.data);
//           yield LoadCompletedState();
//           yield DataWithoutErrorState();
//         }
//       } else {
//         if (result.hasErrorOnly) {
//           yield LoadFailedState();
//           yield DataWithoutErrorState();
//         }
//       }
//     }
//   }
// }
