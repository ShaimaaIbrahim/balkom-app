import 'package:ojos_app/core/entities/faqs_entity.dart';
import 'package:ojos_app/core/errors/base_error.dart';
import 'package:ojos_app/core/params/no_params.dart';
import 'package:ojos_app/core/repositories/core_repository.dart';
import 'package:ojos_app/core/results/result.dart';

import 'usecase.dart';

class GetFaqs extends UseCase<List<FaqsEntity>, NoParams> {
  final CoreRepository repository;

  GetFaqs(this.repository);

  @override
  Future<Result<BaseError, List<FaqsEntity>>> call(NoParams params) =>
      repository.getFAQS(cancelToken: params.cancelToken);
}
