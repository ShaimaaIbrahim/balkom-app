import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ojos_app/core/entities/extra_glasses_entity.dart';
import 'package:ojos_app/features/profile/domin/entities/profile_entity.dart';

import '../constants.dart';

@immutable
abstract class ApplicationEvent extends Equatable {}

class ApplicationStartedEvent extends ApplicationEvent {
  final BuildContext context;

  ApplicationStartedEvent(this.context);

  @override
  String toString() => 'ApplicationStartedEvent';

  @override
  List<Object> get props => [context];
}

abstract class SetApplicationLanguageEvent extends ApplicationEvent {
  final String language;

  SetApplicationLanguageEvent(this.language);

  @override
  String toString() => 'SetApplicationLanguageEvent { language: $language }';

  @override
  List<Object> get props => [language];
}

class SetArabicLanguageEvent extends SetApplicationLanguageEvent {
  SetArabicLanguageEvent() : super(LANG_AR);
}

class SetEnglishLanguageEvent extends SetApplicationLanguageEvent {
  SetEnglishLanguageEvent() : super(LANG_EN);
}

class UserLogoutEvent extends ApplicationEvent {
  @override
  String toString() => 'UserLogoutEvent';

  @override
  List<Object> get props => [];
}

class SetUserDataLoginEvent extends ApplicationEvent {
  @override
  String toString() => 'SetUserProfileEvent';

  @override
  List<Object> get props => [];
}

class VerifyUserAccountEvent extends ApplicationEvent {
  @override
  String toString() => 'VerifyUserAccountEvent';

  @override
  List<Object> get props => [];
}

class SetExtraGlassesEvent extends ApplicationEvent {
  final ExtraGlassesEntity extraGlassesEntity;
  SetExtraGlassesEvent({required this.extraGlassesEntity});
  @override
  String toString() => 'SetExtraGlassesEvent';

  @override
  List<Object> get props => [extraGlassesEntity];
}

class SetProfileSplashEvent extends ApplicationEvent {
  final ProfileEntity? profileEntity;
  SetProfileSplashEvent({required this.profileEntity});
  @override
  String toString() => 'SetProfileSplashEvent';

  @override
  List<Object> get props => [profileEntity!];
}

class GetFCMTokenAndUpdateItEvent extends ApplicationEvent {
  GetFCMTokenAndUpdateItEvent();

  @override
  String toString() => 'GetFCMTokenAndUpdateItEvent';

  @override
  List<Object> get props => [];
}
