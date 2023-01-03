import 'dart:typed_data';

import 'compte.dart';
import 'etudiant.dart';

part '../JsonUtils/responsable.g.dart';

class Responsable extends Compte {
  int idEtb;

  Responsable(
      {required super.email,
      required super.name,
      required super.password,
      required super.accType,
      required this.idEtb,
      required super.id});

  // Json

  factory Responsable.fromJson(Map<String, dynamic> json) =>
      _$ResponsableFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$ResponsableToJson(this);

  //Functions

  Future<List<Etudiant>>? parseEtudiants(ByteData excelFile) {
    return null;
  }

  Future<bool> setProf(int idEtudiant, int idProf) async {
    return false;
  }

  Future<bool> setDeadline(int idEtudiant, int index, DateTime deadline) async {
    return false;
  }

  Future<bool> newReunion(DateTime date, List<Compte> participants) async {
    return false;
  }
}
