part 'JsonUtils/etablissement.g.dart';

class Etablissement {
  String uid;
  String name;
  String email;
  String idResponsable;

  Etablissement({
    this.uid = "",
    required this.name,
    required this.idResponsable,
    required this.email,
  });

  factory Etablissement.fromJson(Map<String, dynamic> json) =>
      _$EtablissementFromJson(json);
  Map<String, dynamic> toJson() => _$EtablissementToJson(this);
}
