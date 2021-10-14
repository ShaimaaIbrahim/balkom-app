// part 'api_resoponse.g.dart';
abstract class ApiResponse<T> {
  final bool? status;
  final String? msg;
  final T result;

  ApiResponse(
    this.status,
    this.msg,
    this.result,
  );
}
