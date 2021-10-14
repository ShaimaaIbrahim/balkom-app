import 'package:dio/dio.dart';
import 'package:ojos_app/core/errors/base_error.dart';
import 'package:ojos_app/core/params/base_params.dart';
import 'package:ojos_app/core/results/result.dart';
import 'package:ojos_app/core/usecases/usecase.dart';
import 'package:ojos_app/features/profile/domin/repositories/profile_repository.dart';

class UpdateUserDataParams extends BaseParams {
  final String? name;
  final String? email;
  final String? address;
  // final String phone;
  final String? aboutMe;
  final String? mobile;
  final String? photo;
  final String? device_token;

  UpdateUserDataParams({
    this.photo,
    this.aboutMe,
    //   this.phone,
    this.name,
    this.email,
    this.device_token,
    this.mobile,
    this.address,
    CancelToken? cancelToken,
  }) : super(cancelToken: cancelToken!);
}

class UpdateUserData extends UseCase<Object, UpdateUserDataParams> {
  final ProfileRepository repository;

  UpdateUserData(this.repository);

  @override
  Future<Result<BaseError, Object>> call(UpdateUserDataParams params) =>
      repository.updateProfile(
        photo: params.photo ?? '',
        //phone: params.phone,
        email: params.email ?? '',
        address: params.address ?? '',
        aboutMe: params.aboutMe ?? '',
        mobile: params.mobile ?? '',
        device_token: params.device_token ?? '',
        name: params.name ?? '',
        cancelToken: params.cancelToken,
      );
}
