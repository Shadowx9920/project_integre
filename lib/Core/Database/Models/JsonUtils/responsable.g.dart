// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../Accounts/responsable.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Responsable _$ResponsableFromJson(Map<String, dynamic> json) => Responsable(
      id: json['id'] as String,
      email: json['email'] as String,
      name: json['name'] as String,
      password: json['password'] as String,
      accType: json['accType'] as int,
      idEtb: json['idEtb'] as int,
    );

Map<String, dynamic> _$ResponsableToJson(Responsable instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'password': instance.password,
      'name': instance.name,
      'accType': instance.accType,
      'idEtb': instance.idEtb,
    };
