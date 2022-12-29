part '../JsonUtils/compte.g.dart';

class Compte {
  int id;
  String email;
  String password;
  String nom;
  String prenom;
  int accType;
  //accType: 0Admin, 1Rsp, 2Prof, 3Student

  Compte(
      {this.id = 0,
      required this.nom,
      required this.prenom,
      required this.email,
      required this.password,
      required this.accType});

  // Json

  factory Compte.fromJson(Map<String, dynamic> json) => _$CompteFromJson(json);
  Map<String, dynamic> toJson() => _$CompteToJson(this);

  //TODO: Account functions

  Future<bool> createAccount() async {
    // var db = await DBProvider.db.database;
    // var res = await db.insert("compte", toMap());
    // return res > 0 ? true : false;
    return false;
  }

  Future<bool> deleteAccount() async {
    // var db = await DBProvider.db.database;
    // var res = await db.delete("compte", where: "id = ?", whereArgs: [id]);
    // return res > 0 ? true : false;
    return false;
  }

  Future<bool> updateAccount() async {
    // var db = await DBProvider.db.database;
    // var res = await db.update("compte", toMap(),
    //     where: "id = ?", whereArgs: [id]);
    // return res > 0 ? true : false;
    return false;
  }

  Future<Compte> getAccount(int id) async {
    // var db = await DBProvider.db.database;
    // var res = await db.query("compte", where: "id = ?", whereArgs: [id]);
    // return res.isNotEmpty ? Compte.fromMap(res.first) : Null;
    return Compte(
        id: 0, email: "", password: "", accType: 0, nom: "", prenom: "");
  }
}
