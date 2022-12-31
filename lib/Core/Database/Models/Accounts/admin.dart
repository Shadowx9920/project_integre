import 'package:project_integre/Core/Database/Models/Accounts/professeur.dart';

import 'compte.dart';

part '../JsonUtils/admin.g.dart';

class Admin extends Compte {
  Admin(
      {required super.email,
      required super.name,
      required super.password,
      required super.accType,
      required super.id});

  // Json

  factory Admin.fromJson(Map<String, dynamic> json) => _$AdminFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$AdminToJson(this);

  // Functions
  Future<bool> addEtab(nom, email) async {
    return false;
  }

  Future<bool> editEtab(id, nom, email) async {
    return false;
  }

  Future<bool> deleteEtab(id) async {
    return false;
  }

  Future<bool> setResponsable(int idEtab, int idResponsable) async {
    return false;
  }

  Future<bool> deleteResponsable(int idResponsable) async {
    return false;
  }

  Future<bool> validateProf(int idProf) async {
    return false;
  }

  Future<bool> deleteProf(int idProf) async {
    return false;
  }

  Future<List<Professeur>?> listAllProf() async {
    return null;
  }
}
