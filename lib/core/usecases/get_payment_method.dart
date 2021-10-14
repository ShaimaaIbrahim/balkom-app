import 'package:ojos_app/core/errors/base_error.dart';
import 'package:ojos_app/core/params/no_params.dart';
import 'package:ojos_app/core/repositories/core_repository.dart';
import 'package:ojos_app/core/results/result.dart';
import 'package:ojos_app/features/cart/domin/entities/payment_method_entity.dart';

import 'usecase.dart';

class GetPaymentMethods extends UseCase<List<PaymentMethodEntity>, NoParams> {
  final CoreRepository repository;

  GetPaymentMethods(this.repository);

  @override
  Future<Result<BaseError, List<PaymentMethodEntity>>> call(NoParams params) =>
      repository.getPaymentMethods(cancelToken: params.cancelToken);
}
