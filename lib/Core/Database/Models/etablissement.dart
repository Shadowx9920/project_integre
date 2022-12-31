part 'JsonUtils/etablissement.g.dart';

class Etablissement {
  String uid;
  String nom;
  String email;
  String idResponsable;

  Etablissement({
    this.uid = "",
    required this.nom,
    required this.idResponsable,
    required this.email,
  });

  factory Etablissement.fromJson(Map<String, dynamic> json) =>
      _$EtablissementFromJson(json);
  Map<String, dynamic> toJson() => _$EtablissementToJson(this);
}
