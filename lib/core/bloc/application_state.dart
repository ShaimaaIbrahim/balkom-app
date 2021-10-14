import 'package:ojos_app/core/entities/extra_glasses_entity.dart';
import 'package:ojos_app/features/profile/domin/entities/profile_entity.dart';
import 'package:ojos_app/features/user_management/domain/entities/login_result.dart';

class ApplicationState {
  // Current user language.
  final String? language;
  final ExtraGlassesEntity? extraGlasses;

  // // Current user profile.
  final LoginResult? userData;
  final ProfileEntity? profile;

  ApplicationState({
    this.language,
    this.extraGlasses,
    this.userData,
    this.profile,
  });

  ApplicationState copyWith({
    String? language,
    ExtraGlassesEntity? extraGlasses,
    LoginResult? userData,
    ProfileEntity? profile,
  }) =>
      ApplicationState(
        language: language ?? this.language,
        extraGlasses: extraGlasses ?? this.extraGlasses,
        userData: userData ?? this.userData,
        profile: profile ?? this.profile,
      );

  ApplicationState clearProfile() {
    return ApplicationState(
      language: language,
      extraGlasses: extraGlasses,
      userData: null,
      profile: null,
    );
  }

  static ApplicationState get initialState => ApplicationState();

  bool get isUserAuthenticated => this.profile != null;

  bool get isUserVerified => this.userData != null;
}
