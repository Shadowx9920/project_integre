import 'dart:typed_data';

import 'compte.dart';
import 'etudiant.dart';

part '../JsonUtils/responsable.g.dart';

class Responsable extends Compte {
  int idEtb;

  Responsable(
      {required super.email,
      required super.nom,
      required super.prenom,
      required super.password,
      required super.accType,
      required this.idEtb});

  // Json

  factory Responsable.fromJson(Map<String, dynamic> json) =>
      _$ResponsableFromJson(json);
  Map<String, dynamic> toJson() => _$ResponsableToJson(this);

  //Functions

  Future<List<Etudiant>>? parseEtudiants(ByteData excelFile) {
    return null;
  }

  Future<bool> setProf(int idEtudiant, int idProf) async {
    return false;
  }

  //TODO: Request documents and download them 3la 7sab type

  Future<bool> setDeadline(int idEtudiant, int index, DateTime deadline) async {
    return false;
  }

  Future<bool> newReunion(DateTime date, List<Compte> participants) async {
    return false;
  }
}
