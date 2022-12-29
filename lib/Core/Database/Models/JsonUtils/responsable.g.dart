// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../Accounts/responsable.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Responsable _$ResponsableFromJson(Map<String, dynamic> json) => Responsable(
      email: json['email'] as String,
      nom: json['nom'] as String,
      prenom: json['prenom'] as String,
      password: json['password'] as String,
      accType: json['accType'] as int,
      idEtb: json['idEtb'] as int,
    )..id = json['id'] as int;

Map<String, dynamic> _$ResponsableToJson(Responsable instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'password': instance.password,
      'nom': instance.nom,
      'prenom': instance.prenom,
      'accType': instance.accType,
      'idEtb': instance.idEtb,
    };
