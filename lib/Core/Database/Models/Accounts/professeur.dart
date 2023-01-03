import 'compte.dart';

part '../JsonUtils/professeur.g.dart';

class Professeur extends Compte {
  List<int> idEtudiants = [];

  Professeur(
      {required super.email,
      required super.name,
      required super.password,
      required super.accType,
      required super.id});

  // Json

  factory Professeur.fromJson(Map<String, dynamic> json) =>
      _$ProfesseurFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$ProfesseurToJson(this);
}
