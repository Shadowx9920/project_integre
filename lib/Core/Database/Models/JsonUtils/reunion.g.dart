// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../reunion.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Reunion _$ReunionFromJson(Map<String, dynamic> json) => Reunion(
      uid: json['uid'] as String,
      date: DateTime.parse(json['date'] as String),
      participants: (json['participants'] as List<dynamic>)
          .map((e) => Compte.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ReunionToJson(Reunion instance) => <String, dynamic>{
      'uid': instance.uid,
      'date': instance.date.toIso8601String(),
      'participants': instance.participants,
    };
