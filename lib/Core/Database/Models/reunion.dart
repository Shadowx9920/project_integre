part 'JsonUtils/reunion.g.dart';

class Reunion {
  String uid;
  String subject;
  DateTime date;
  String profId;
  String idEtablissement;
  List<String> participants = [];

  Reunion(
      {required this.uid,
      required this.subject,
      required this.date,
      required this.participants,
      required this.idEtablissement,
      required this.profId});

  factory Reunion.fromJson(Map<String, dynamic> json) =>
      _$ReunionFromJson(json);
  Map<String, dynamic> toJson() => _$ReunionToJson(this);
}
