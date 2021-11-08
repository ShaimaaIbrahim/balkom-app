import 'package:ojos_app/core/entities/base_entity.dart';

class NotificationsEntity extends BaseEntity {
  final String? description;
  final String? id;
  final String? title;
  final int? type;
  final int? type_int;
  //final String? notifiable_id;
  final String? icon;
  final int? id_s;

  NotificationsEntity(
      {required this.description,
      required this.title,
      required this.id,
      required this.type,
      required this.icon,
      required this.id_s,
      required this.type_int});

  @override
  List<Object> get props => [
        description ?? '',
        title ?? '',
        type ?? '',
        id ?? '',
        type_int ?? 0,
        icon ?? ''
      ];
}
