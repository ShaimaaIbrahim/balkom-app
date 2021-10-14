import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:ojos_app/features/profile/domin/entities/profile_entity.dart';

class UpdateProfileImagePageArgs {
  final File image;
  final ProfileEntity profile;

  UpdateProfileImagePageArgs({required this.image, required this.profile});
}
