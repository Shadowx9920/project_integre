part 'JsonUtils/etablissement.g.dart';

class Etablissement {
  int idEtb;
  String nom;
  String email;
  int idResponsable;

  Etablissement({
    this.idEtb = 0,
    required this.nom,
    this.idResponsable = 0,
    required this.email,
  });

  // Json

  factory Etablissement.fromJson(Map<String, dynamic> json) =>
      _$EtablissementFromJson(json);
  Map<String, dynamic> toJson() => _$EtablissementToJson(this);
}
