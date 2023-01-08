// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../reunion.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Reunion _$ReunionFromJson(Map<String, dynamic> json) => Reunion(
      uid: json['uid'] as String,
      subject: json['subject'] as String,
      date: DateTime.parse(json['date'] as String),
      profId: json['profId'] as String,
      participants: (json['participants'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$ReunionToJson(Reunion instance) => <String, dynamic>{
      'uid': instance.uid,
      'subject': instance.subject,
      'date': instance.date.toIso8601String(),
      'profId': instance.profId,
      'participants': instance.participants,
    };
