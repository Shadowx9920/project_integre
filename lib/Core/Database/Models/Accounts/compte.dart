class Compte {
  int id;
  String email;
  String password;
  String status;

  Compte(
      {this.id = 0,
      required this.email,
      required this.password,
      required this.status});

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
    return Compte(id: 0, email: "", password: "", status: "");
  }
}
