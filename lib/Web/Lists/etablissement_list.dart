import 'package:flutter/material.dart';
import '../../Core/Database/Controllers/etablissement_controller.dart';
import '../../Core/Database/Models/etablissement.dart';
import '../Widgets/scrollable_widget.dart';

class EttablissementListPage extends StatelessWidget {
  const EttablissementListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: EtablissementController.getAllEtablissements(),
      builder: (BuildContext conntextn, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return EtablissementList(
            data: snapshot.data,
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
    );
  }
}

class EtablissementList extends StatefulWidget {
  const EtablissementList({super.key, required this.data});

  final List<Etablissement> data;

  @override
  State<EtablissementList> createState() => _EtablissementListState();
}

class _EtablissementListState extends State<EtablissementList> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          Expanded(
            child: ScrollableWidget(
              child: Wrap(
                spacing: 10,
                children: [
                  for (Etablissement etablissement in widget.data)
                    EtablissementCard(size: size, etablissement: etablissement),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: _buildButtons(),
            ),
          ),
        ],
      ),
    );
  }

  _buildButtons() {
    return [
      const Spacer(),
      ElevatedButton(
        child: const Text("Add Account"),
        onPressed: () {
          //TODO: add etablissement
        },
      ),
      const SizedBox(width: 10),
      ElevatedButton(
        child: const Text("Delete Selected Accounts"),
        onPressed: () {},
      ),
    ];
  }
}

class EtablissementCard extends StatefulWidget {
  const EtablissementCard(
      {super.key, required this.size, required this.etablissement});
  final Size size;
  final Etablissement etablissement;
  @override
  State<EtablissementCard> createState() => _EtablissementCardState();
}

class _EtablissementCardState extends State<EtablissementCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.size.width * 0.4,
      height: widget.size.height * 0.3,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          const SizedBox(height: 10),
          Text(
            widget.etablissement.name,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            widget.etablissement.email,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            widget.etablissement.idResponsable,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  EtablissementController.deleteEtablissement(
                      widget.etablissement.uid);
                },
              ),
              const SizedBox(width: 10),
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {},
              ),
              const SizedBox(width: 10),
            ],
          ),
        ],
      ),
    );
  }
}
