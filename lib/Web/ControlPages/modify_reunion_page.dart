import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';

import '../../Core/Database/Controllers/etablissement_controller.dart';
import '../../Core/Database/Controllers/reunion_controller.dart';
import '../../Core/Database/Controllers/users_controller.dart';
import '../../Core/Database/Models/compte.dart';
import '../../Core/Database/Models/etablissement.dart';
import '../../Core/Database/Models/reunion.dart';
import '../Widgets/custom_text_field.dart';

class ModifyReunionPage extends StatefulWidget {
  const ModifyReunionPage({super.key, required this.reunion});

  final Reunion reunion;

  @override
  State<ModifyReunionPage> createState() => _ModifyReunionPageState();
}

class _ModifyReunionPageState extends State<ModifyReunionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Modify Reunion"),
      ),
      body: FutureBuilder(
        future: Future.wait([
          UsersController.getAllAcountsFuture(),
          EtablissementController.getAllEtablissementFuture(),
        ]),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return Layout(
              reunion: widget.reunion,
              data: snapshot.data[0] as List<Compte>,
              etablissements: snapshot.data[1] as List<Etablissement>,
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text("Error"),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

class Layout extends StatefulWidget {
  const Layout(
      {super.key,
      required this.data,
      required this.reunion,
      required this.etablissements});

  final List<Compte> data;
  final List<Etablissement> etablissements;
  final Reunion reunion;

  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  late TextEditingController subjectController;
  late TextEditingController dateController;
  DateTime? selectedDate;
  Compte? selectedProfesseur;
  Etablissement? selectedEtablissement;
  List<String> selectedParticipants = [];

  @override
  void initState() {
    dateController = TextEditingController();
    subjectController = TextEditingController();
    subjectController.text = widget.reunion.subject;
    selectedDate = widget.reunion.date;
    dateController.text = selectedDate.toString();
    selectedParticipants = widget.reunion.participants;
    for (Compte element in widget.data) {
      if (element.id == widget.reunion.profId) selectedProfesseur = element;
    }
    super.initState();
  }

  @override
  void dispose() {
    dateController.dispose();
    subjectController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          Center(
            child: SizedBox(
              width: size.width * 0.7,
              height: size.height * 0.7,
              child: Row(
                children: [
                  const Spacer(),
                  Column(
                    children: [
                      const Spacer(),
                      const Text("Subject:"),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: size.width * 0.3,
                        child: CustomTextField(
                          controller: subjectController,
                          icon: Icons.subject,
                          labelText: "Subject",
                          hintText: "Subject",
                          obscureText: false,
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text("Date:"),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: size.width * 0.3,
                        height: size.height * 0.1,
                        child: DateTimePicker(
                          controller: dateController,
                          type: DateTimePickerType.dateTimeSeparate,
                          initialDate: selectedDate,
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100),
                          icon: const Icon(Icons.event),
                          dateLabelText: 'Date',
                          timeLabelText: "Hour",
                          onChanged: (val) {
                            setState(() {
                              selectedDate = DateTime.parse(val);
                            });
                          },
                        ),
                      ),
                      const Spacer(),
                    ],
                  ),
                  const Spacer(),
                  Column(
                    children: [
                      const Spacer(),
                      Row(
                        children: [
                          const Text("Professeur:"),
                          DropdownButton2(
                            hint: const Text("Select User"),
                            value: selectedProfesseur,
                            //searchController: searchControllerForAdding,
                            items: [
                              for (Compte user in widget.data)
                                if (user.accType == 2)
                                  DropdownMenuItem(
                                    value: user,
                                    child: Text(user.name),
                                  )
                            ],
                            onChanged: (value) => setState(() {
                              selectedProfesseur = value;
                            }),
                          )
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          const Text("Etablissement:"),
                          DropdownButton2(
                            hint: const Text("Select Etablissement"),
                            value: selectedEtablissement,
                            //searchController: searchControllerForAdding,
                            items: [
                              for (Etablissement etab in widget.etablissements)
                                DropdownMenuItem(
                                  value: etab,
                                  child: Text(etab.name),
                                )
                            ],
                            onChanged: (value) => setState(() {
                              selectedEtablissement = value;
                            }),
                          )
                        ],
                      ),
                      const Spacer(),
                      const Text("Participants:"),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: size.width * 0.3,
                        height: size.height * 0.3,
                        child: ListView.builder(
                          itemCount: widget.data.length,
                          itemBuilder: (context, index) {
                            return CheckboxListTile(
                              title: Text(widget.data[index].name),
                              value: selectedParticipants
                                  .contains(widget.data[index].id),
                              onChanged: (value) {
                                setState(() {
                                  if (value == true) {
                                    selectedParticipants
                                        .add(widget.data[index].id);
                                  } else {
                                    selectedParticipants
                                        .remove(widget.data[index].id);
                                  }
                                });
                              },
                            );
                          },
                        ),
                      ),
                      const Spacer(),
                    ],
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ),
          const Spacer(),
          _buildButtons(),
        ],
      ),
    );
  }

  _buildButtons() {
    return Row(
      children: [
        const Spacer(),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("Cancel"),
        ),
        const SizedBox(width: 10),
        ElevatedButton(
          onPressed: () {
            ReunionController.updateReunion(Reunion(
              uid: widget.reunion.uid,
              subject: subjectController.text,
              date: selectedDate ?? DateTime.now(),
              participants: selectedParticipants,
              profId: selectedProfesseur!.id,
              idEtablissement: selectedEtablissement?.uid ?? "",
            ));
            Navigator.pop(context);
          },
          child: const Text("Modify"),
        ),
      ],
    );
  }
}
