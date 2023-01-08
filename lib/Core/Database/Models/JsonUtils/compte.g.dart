part of '../compte.dart';

Compte _$CompteFromJson(Map<String, dynamic> json) => Compte(
      //for all
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      accType: json['accType'] as int,
      //for etudiant
      niveau: json['niveau'] as int?,
      idEtablissementEtudiant: json['idEtablissementEtudiant'] as int?,
      idProf: json['idProf'] as int?,
      isStage: json['isStage'] as bool?,
      deadlines: (json['deadlines'] as List<dynamic>?)
          ?.map((e) => e == null ? null : DateTime.parse(e as String))
          .toList(),
      //for prof
      idEtudiants: (json['idEtudiants'] as List<dynamic>?)
          ?.map((e) => e as int)
          .toList(),
      //for responsable
      idEtablissementResponsable: json['idEtablissementResponsable'] as int?,
    );

Map<String, dynamic> _$CompteToJson(Compte instance) => <String, dynamic>{
      //for all
      'id': instance.id,
      'email': instance.email,
      'password': instance.password,
      'name': instance.name,
      'accType': instance.accType,
      //for etudiant
      'niveau': instance.niveau,
      'idEtablissementEtudiant': instance.idEtablissementEtudiant,
      'idProf': instance.idProf,
      'isStage': instance.isStage,
      'deadlines':
          instance.deadlines?.map((e) => e?.toIso8601String()).toList(),
      //for prof
      'idEtudiants': instance.idEtudiants,
      //for responsable
      'idEtablissementResponsable': instance.idEtablissementResponsable,
    };
