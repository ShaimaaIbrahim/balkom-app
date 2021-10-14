import './http_error.dart';

class BadRequestError extends HttpError {
  final String message;

  BadRequestError({required this.message});

  @override
  List<Object> get props => [message];
}
