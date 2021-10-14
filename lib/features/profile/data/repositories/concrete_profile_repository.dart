import 'package:dio/dio.dart';
import 'package:ojos_app/core/errors/base_error.dart';
import 'package:ojos_app/core/results/result.dart';
import 'package:ojos_app/features/profile/data/datasources/profile_remote_data_source.dart';
import 'package:ojos_app/features/profile/data/models/profile_model.dart';
import 'package:ojos_app/features/profile/domin/entities/profile_entity.dart';
import 'package:ojos_app/features/profile/domin/repositories/profile_repository.dart';

class ConcreteProfileRepository extends ProfileRepository {
  final ProfileRemoteDataSource remoteDataSource;

  ConcreteProfileRepository(this.remoteDataSource);

  @override
  Future<Result<BaseError, ProfileEntity>> getUserData(
      {CancelToken? cancelToken}) async {
    final remoteResult = await remoteDataSource.getUserData(
      cancelToken: cancelToken!,
    );
    return execute<ProfileModel, ProfileEntity>(remoteResult: remoteResult);
  }

  @override
  Future<Result<BaseError, ProfileEntity>> updateProfile({
    String? name,
    String? email,
    String? address,
    String? device_token,
    String? aboutMe,
    String? mobile,
    String? photo,
    CancelToken? cancelToken,
  }) async {
    final remoteResult = await remoteDataSource.updateProfile(
      name: name!,
      aboutMe: aboutMe!,
      address: address!,
      email: email!,
      mobile: mobile!,
      device_token: device_token!,
      photo: photo!,
      cancelToken: cancelToken!,
    );

    // if (remoteResult.isRight()) {
    //   final profile = (remoteResult as Right<BaseError, ProfileModel>).value;
    //   await UserRepository.persistProfile(profile);
    // }

    return execute<ProfileModel, ProfileEntity>(remoteResult: remoteResult);
  }
}
