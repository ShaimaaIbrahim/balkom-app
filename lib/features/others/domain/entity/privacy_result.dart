import 'package:flutter/material.dart';
import 'package:ojos_app/core/entities/base_entity.dart';

class PrivacyAppResult extends BaseEntity {
  final String title;
  final String details;

  PrivacyAppResult({
    required this.details,
    required this.title,
  });

  @override
  List<Object> get props => [
        details,
        title,
      ];
}
