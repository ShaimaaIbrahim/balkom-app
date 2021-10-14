import 'package:ojos_app/core/entities/base_entity.dart';

class NotificationsEntity extends BaseEntity {
  final String? description;
  final String? id;
  final String? title;
  final String? type;
  int? type_int;

  NotificationsEntity(
      {required this.description,
      required this.title,
      required this.id,
      required this.type,
      required this.type_int});

  @override
  List<Object> get props =>
      [description ?? '', title ?? '', type ?? '', id ?? '', type_int ?? 0];
}
