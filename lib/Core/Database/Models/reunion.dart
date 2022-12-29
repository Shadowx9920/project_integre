import 'Accounts/compte.dart';

part 'JsonUtils/reunion.g.dart';

class Reunion {
  int idReunion;
  DateTime date;
  List<Compte> participants = [];

  Reunion(
      {required this.idReunion,
      required this.date,
      required this.participants});

  // Json

  factory Reunion.fromJson(Map<String, dynamic> json) =>
      _$ReunionFromJson(json);
  Map<String, dynamic> toJson() => _$ReunionToJson(this);
}
