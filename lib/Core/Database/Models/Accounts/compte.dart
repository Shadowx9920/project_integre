part '../JsonUtils/compte.g.dart';

class Compte {
  String id;
  String email;
  String password;
  String name;
  int accType;
  //accType: 0Admin, 1Rsp, 2Prof, 3Student

  Compte(
      {required this.id,
      required this.name,
      required this.email,
      required this.password,
      required this.accType});

  factory Compte.fromJson(Map<String, dynamic> json) => _$CompteFromJson(json);
  Map<String, dynamic> toJson() => _$CompteToJson(this);
}
