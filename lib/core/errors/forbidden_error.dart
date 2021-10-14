import './http_error.dart';

class ForbiddenError extends HttpError {
  final String message;

  ForbiddenError({required this.message});

  @override
  List<Object> get props => [message];
}
