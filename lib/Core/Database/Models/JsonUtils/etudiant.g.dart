// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../Accounts/etudiant.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Etudiant _$EtudiantFromJson(Map<String, dynamic> json) => Etudiant(
      email: json['email'] as String,
      password: json['password'] as String,
      accType: json['accType'] as int,
      nom: json['nom'] as String,
      prenom: json['prenom'] as String,
      niveau: json['niveau'] as int,
      idEtb: json['idEtb'] as int,
      idProf: json['idProf'] as int,
      isStage: json['isStage'] as bool,
    )
      ..id = json['id'] as int
      ..deadlines = (json['deadlines'] as List<dynamic>)
          .map((e) => e == null ? null : DateTime.parse(e as String))
          .toList()
      ..documents =
          (json['documents'] as List<dynamic>).map((e) => e as bool).toList();

Map<String, dynamic> _$EtudiantToJson(Etudiant instance) => <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'password': instance.password,
      'nom': instance.nom,
      'prenom': instance.prenom,
      'accType': instance.accType,
      'niveau': instance.niveau,
      'idEtb': instance.idEtb,
      'idProf': instance.idProf,
      'isStage': instance.isStage,
      'deadlines': instance.deadlines.map((e) => e?.toIso8601String()).toList(),
      'documents': instance.documents,
    };
