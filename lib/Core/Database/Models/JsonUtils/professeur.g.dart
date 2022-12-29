// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../Accounts/professeur.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Professeur _$ProfesseurFromJson(Map<String, dynamic> json) => Professeur(
      email: json['email'] as String,
      nom: json['nom'] as String,
      prenom: json['prenom'] as String,
      password: json['password'] as String,
      accType: json['accType'] as int,
    )
      ..id = json['id'] as int
      ..idEtudiants =
          (json['idEtudiants'] as List<dynamic>).map((e) => e as int).toList();

Map<String, dynamic> _$ProfesseurToJson(Professeur instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'password': instance.password,
      'nom': instance.nom,
      'prenom': instance.prenom,
      'accType': instance.accType,
      'idEtudiants': instance.idEtudiants,
    };
