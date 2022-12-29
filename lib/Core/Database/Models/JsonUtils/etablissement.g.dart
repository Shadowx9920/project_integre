// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../etablissement.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Etablissement _$EtablissementFromJson(Map<String, dynamic> json) =>
    Etablissement(
      idEtb: json['idEtb'] as int? ?? 0,
      nom: json['nom'] as String,
      idResponsable: json['idResponsable'] as int? ?? 0,
      email: json['email'] as String,
    );

Map<String, dynamic> _$EtablissementToJson(Etablissement instance) =>
    <String, dynamic>{
      'idEtb': instance.idEtb,
      'nom': instance.nom,
      'email': instance.email,
      'idResponsable': instance.idResponsable,
    };
