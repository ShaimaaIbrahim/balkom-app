import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:ojos_app/core/datasources/local/datasources/cached_extra_glasses_dao.dart';
import 'package:ojos_app/core/entities/extra_glasses_entity.dart';
import 'package:ojos_app/core/entities/offer_entity.dart';
import 'package:ojos_app/core/errors/base_error.dart';
import 'package:ojos_app/core/params/no_params.dart';
import 'package:ojos_app/core/repositories/core_repository.dart';
import 'package:ojos_app/core/usecases/get_extra_glasses.dart';
import 'package:ojos_app/core/usecases/get_offers.dart';
import 'package:ojos_app/features/cart/domin/entities/coupon_code_entity.dart';
import 'package:ojos_app/features/cart/domin/repositories/cartr_repository.dart';
import 'package:ojos_app/features/cart/domin/usecases/apply_coupon_code.dart';
import 'package:ojos_app/features/profile/domin/entities/profile_entity.dart';
import 'package:ojos_app/features/profile/domin/repositories/profile_repository.dart';
import 'package:ojos_app/features/profile/domin/usecases/get_user_details.dart';
import 'package:ojos_app/features/profile/domin/usecases/update_user_data.dart';

import '../../../../main.dart';

@immutable
abstract class ProfileState extends Equatable {}

class ProfileUninitializedState extends ProfileState {
  @override
  String toString() => 'ProfileUninitializedState';

  @override
  List<Object> get props => [];
}

class ProfileLoadingState extends ProfileState {
  @override
  String toString() => 'ProfileLoadingState';

  @override
  List<Object> get props => [];
}

class ProfileDoneState extends ProfileState {
  final ProfileEntity? profile;

  ProfileDoneState({this.profile});

  @override
  String toString() => 'ProfileDoneState data ${profile.toString()}';

  @override
  List<Object> get props => [profile!];
}

class UpdateProfileDoneState extends ProfileState {
  final ProfileEntity? profile;

  UpdateProfileDoneState({this.profile});

  @override
  String toString() => 'ProfileDoneState data ${profile.toString()}';

  @override
  List<Object> get props => [profile!];
}

class ProfileFailureState extends ProfileState {
  final BaseError error;

  ProfileFailureState(this.error);

  @override
  String toString() => 'ProfileFailureState';

  @override
  List<Object> get props => [error];
}

class UpdateProfileFailureState extends ProfileState {
  final BaseError error;

  UpdateProfileFailureState(this.error);

  @override
  String toString() => 'UpdateProfileFailureState';

  @override
  List<Object> get props => [error];
}

@immutable
abstract class ProfileEvent extends Equatable {}

class GetProfileEvent extends ProfileEvent {
  final CancelToken? cancelToken;

  GetProfileEvent({
    this.cancelToken,
  });

  @override
  List<Object> get props => [cancelToken!];
}

class UpdateProfileEvent extends ProfileEvent {
  final String? name;
  final String? email;
  final String? address;
  final String? mobile;
  //final String phone;
  final String? aboutMe;
  final String? device_token;
  final CancelToken? cancelToken;

  UpdateProfileEvent({
    //  this.phone,
    this.email,
    this.address,
    this.aboutMe,
    this.mobile,
    this.name,
    this.cancelToken,
    this.device_token,
  });

  @override
  List<Object> get props => [
        //   phone,
        email!,
        address!,
        device_token!,
        aboutMe!,
        name!,
        cancelToken!,
      ];
}

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileUninitializedState());

  @override
  Stream<ProfileState> mapEventToState(ProfileEvent event) async* {
    if (event is GetProfileEvent) {
      yield ProfileLoadingState();

      final result = await GetUserDetails(locator<ProfileRepository>())(
        NoParams(cancelToken: event.cancelToken),
      );

      ///=============================  Succeed request app info remote ========================================
      if (result.hasDataOnly) {
        yield ProfileDoneState(profile: result.data!);
      } else {
        final error = result.error;
        yield ProfileFailureState(error!);
      }
    }

    if (event is UpdateProfileEvent) {
      yield ProfileLoadingState();

      final result = await UpdateUserData(locator<ProfileRepository>())(
        UpdateUserDataParams(
            name: event.name,
            aboutMe: event.aboutMe,
            address: event.address,
            email: event.email,
            mobile: event.mobile,
            device_token: event.device_token,
            cancelToken: event.cancelToken!),
      );

      ///=============================  Succeed request app info remote ========================================
      if (result.hasDataOnly) {
        yield UpdateProfileDoneState(profile: result.data as ProfileEntity);
      } else {
        final error = result.error;
        yield UpdateProfileFailureState(error!);
      }
    }
  }
}
