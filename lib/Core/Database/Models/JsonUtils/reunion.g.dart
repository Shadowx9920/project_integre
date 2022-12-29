// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../reunion.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Reunion _$ReunionFromJson(Map<String, dynamic> json) => Reunion(
      idReunion: json['idReunion'] as int,
      date: DateTime.parse(json['date'] as String),
      participants: (json['participants'] as List<dynamic>)
          .map((e) => Compte.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ReunionToJson(Reunion instance) => <String, dynamic>{
      'idReunion': instance.idReunion,
      'date': instance.date.toIso8601String(),
      'participants': instance.participants,
    };
