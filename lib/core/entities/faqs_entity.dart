import 'package:ojos_app/core/entities/base_entity.dart';

class FaqsEntity extends BaseEntity {
  final int id;
  final String? question;
  final String? answer;

  FaqsEntity({
    required this.id,
    required this.answer,
    required this.question,
  });

  @override
  List<Object> get props => [
        id,
        answer??'',
        question??'',
      ];
}
