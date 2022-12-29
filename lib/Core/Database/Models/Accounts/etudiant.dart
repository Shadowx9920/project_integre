import 'compte.dart';

part '../JsonUtils/etudiant.g.dart';

class Etudiant extends Compte {
  int niveau;
  int idEtb;
  int idProf;
  bool isStage;
  List<DateTime?> deadlines = [null, null, null, null];
  List<bool> documents = [false, false, false, false];

  Etudiant(
      {required super.email,
      required super.password,
      required super.accType,
      required super.nom,
      required super.prenom,
      required this.niveau,
      required this.idEtb,
      required this.idProf,
      required this.isStage});

  // Json

  factory Etudiant.fromJson(Map<String, dynamic> json) =>
      _$EtudiantFromJson(json);
  Map<String, dynamic> toJson() => _$EtudiantToJson(this);
}
