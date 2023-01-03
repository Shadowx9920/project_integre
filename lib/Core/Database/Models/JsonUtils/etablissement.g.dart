// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../etablissement.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Etablissement _$EtablissementFromJson(Map<String, dynamic> json) =>
    Etablissement(
      uid: json['uid'] as String,
      name: json['name'] as String,
      idResponsable: json['idResponsable'] as String,
      email: json['email'] as String,
    );

Map<String, dynamic> _$EtablissementToJson(Etablissement instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'name': instance.name,
      'email': instance.email,
      'idResponsable': instance.idResponsable,
    };
