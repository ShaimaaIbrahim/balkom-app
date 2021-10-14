import 'package:ojos_app/core/entities/notifications_entity.dart';
import 'package:ojos_app/core/errors/base_error.dart';
import 'package:ojos_app/core/params/no_params.dart';
import 'package:ojos_app/core/repositories/core_repository.dart';
import 'package:ojos_app/core/results/result.dart';

import 'usecase.dart';

class GetNotifications extends UseCase<List<NotificationsEntity>, NoParams> {
  final CoreRepository repository;

  GetNotifications(this.repository);

  @override
  Future<Result<BaseError, List<NotificationsEntity>>> call(NoParams params) =>
      repository.getNotifications(cancelToken: params.cancelToken);
}
