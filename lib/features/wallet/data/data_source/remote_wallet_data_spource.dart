import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:ojos_app/core/datasources/remote_data_source.dart';
import 'package:ojos_app/core/errors/base_error.dart';
import 'package:ojos_app/features/user_management/data/models/register_result_model.dart';

abstract class RemoteWalletDataSource extends RemoteDataSource{

  Future<Either<BaseError, RegisterResultModel>> getMyWallet({
    CancelToken cancelToken,
  });
}