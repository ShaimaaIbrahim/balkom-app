import './http_error.dart';

class InternalServerError extends HttpError {
  final String message;

  InternalServerError({required this.message});

  @override
  List<Object> get props => [message];
}
