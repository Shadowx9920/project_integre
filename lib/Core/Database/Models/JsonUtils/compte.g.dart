// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../Accounts/compte.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Compte _$CompteFromJson(Map<String, dynamic> json) => Compte(
      id: json['id'] as int? ?? 0,
      nom: json['nom'] as String,
      prenom: json['prenom'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      accType: json['accType'] as int,
    );

Map<String, dynamic> _$CompteToJson(Compte instance) => <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'password': instance.password,
      'nom': instance.nom,
      'prenom': instance.prenom,
      'accType': instance.accType,
    };
