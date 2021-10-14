import 'package:ojos_app/core/errors/base_error.dart';
import 'package:ojos_app/core/params/no_params.dart';
import 'package:ojos_app/core/results/result.dart';
import 'package:ojos_app/core/usecases/usecase.dart';
import 'package:ojos_app/features/profile/domin/entities/profile_entity.dart';
import 'package:ojos_app/features/profile/domin/repositories/profile_repository.dart';




class GetUserDetails extends UseCase<ProfileEntity, NoParams> {
  final ProfileRepository repository;

  GetUserDetails(this.repository);

  @override
  Future<Result<BaseError, ProfileEntity>> call(NoParams params) {
    return repository.getUserData(
      cancelToken: params.cancelToken,
    );
  }
}
