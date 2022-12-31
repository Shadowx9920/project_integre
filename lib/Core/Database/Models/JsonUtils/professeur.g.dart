// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../Accounts/professeur.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Professeur _$ProfesseurFromJson(Map<String, dynamic> json) => Professeur(
      id: json['id'] as String,
      email: json['email'] as String,
      name: json['name'] as String,
      password: json['password'] as String,
      accType: json['accType'] as int,
    )..idEtudiants =
        (json['idEtudiants'] as List<dynamic>).map((e) => e as int).toList();

Map<String, dynamic> _$ProfesseurToJson(Professeur instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'password': instance.password,
      'name': instance.name,
      'accType': instance.accType,
      'idEtudiants': instance.idEtudiants,
    };
