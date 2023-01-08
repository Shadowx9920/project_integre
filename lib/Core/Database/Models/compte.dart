part 'JsonUtils/compte.g.dart';

class Compte {
  String id;
  String email;
  String password;
  String name;
  int accType;
  //accType: 0Admin, 1Rsp, 2Prof, 3Student

  //Responsable
  int? idEtablissementResponsable;

  //Professeur
  List<int?>? idEtudiants = [];

  //Etudiant
  int? niveau;
  int? idEtablissementEtudiant;
  int? idProf;
  bool? isStage;
  List<DateTime?>? deadlines = [null, null, null, null];

  Compte({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.accType,
    this.idEtablissementResponsable,
    this.idEtudiants = const [],
    this.niveau,
    this.idEtablissementEtudiant,
    this.idProf,
    this.isStage,
    this.deadlines = const [null, null, null, null],
  });

  factory Compte.fromJson(Map<String, dynamic> json) => _$CompteFromJson(json);
  Map<String, dynamic> toJson() => _$CompteToJson(this);
}
