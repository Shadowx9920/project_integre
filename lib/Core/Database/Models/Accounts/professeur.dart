import 'compte.dart';

part '../JsonUtils/professeur.g.dart';

class Professeur extends Compte {
  List<int> idEtudiants = [];

  Professeur(
      {required super.email,
      required super.nom,
      required super.prenom,
      required super.password,
      required super.accType});

  // Json

  factory Professeur.fromJson(Map<String, dynamic> json) =>
      _$ProfesseurFromJson(json);
  Map<String, dynamic> toJson() => _$ProfesseurToJson(this);

  //TODO: Request documents and download them 3la 7sab type
}
