// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../etablissement.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Etablissement _$EtablissementFromJson(Map<String, dynamic> json) =>
    Etablissement(
      uid: json['uid'] as String,
      nom: json['nom'] as String,
      idResponsable: json['idResponsable'] as String,
      email: json['email'] as String,
    );

Map<String, dynamic> _$EtablissementToJson(Etablissement instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'nom': instance.nom,
      'email': instance.email,
      'idResponsable': instance.idResponsable,
    };
