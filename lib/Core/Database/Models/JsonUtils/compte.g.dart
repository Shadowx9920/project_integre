// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../Accounts/compte.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Compte _$CompteFromJson(Map<String, dynamic> json) => Compte(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      accType: json['accType'] as int,
    );

Map<String, dynamic> _$CompteToJson(Compte instance) => <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'password': instance.password,
      'name': instance.name,
      'accType': instance.accType,
    };
