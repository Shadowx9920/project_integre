import 'Accounts/compte.dart';

part 'JsonUtils/reunion.g.dart';

class Reunion {
  String uid;
  DateTime date;
  List<Compte> participants = [];

  Reunion({required this.uid, required this.date, required this.participants});

  factory Reunion.fromJson(Map<String, dynamic> json) =>
      _$ReunionFromJson(json);
  Map<String, dynamic> toJson() => _$ReunionToJson(this);
}
