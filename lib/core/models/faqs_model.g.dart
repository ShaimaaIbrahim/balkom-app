// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'faqs_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FaqsModel _$FaqsModelFromJson(Map<String, dynamic> json) {
  return FaqsModel(
    id: json['id'] as int,
    answer: json['answer'] as String,
    question: json['question'] as String,
  );
}

Map<String, dynamic> _$FaqsModelToJson(FaqsModel instance) => <String, dynamic>{
      'id': instance.id,
      'question': instance.question,
      'answer': instance.answer,
    };
