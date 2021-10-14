import 'package:ojos_app/core/entities/brand_entity.dart';
import 'package:ojos_app/core/entities/faqs_entity.dart';
import 'package:ojos_app/core/entities/wallet_transactions_entity.dart';
import 'package:ojos_app/core/errors/base_error.dart';
import 'package:ojos_app/core/params/no_params.dart';
import 'package:ojos_app/core/repositories/core_repository.dart';
import 'package:ojos_app/core/results/result.dart';
import 'usecase.dart';

class GetWalletTransactions
    extends UseCase<List<WalletTransactionsEntity>, NoParams> {
  final CoreRepository repository;

  GetWalletTransactions(this.repository);

  @override
  Future<Result<BaseError, List<WalletTransactionsEntity>>> call(
          NoParams params) =>
      repository.getWalletTransactions(cancelToken: params.cancelToken);
}
