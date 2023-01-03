import 'package:flutter/material.dart';

import '../../Core/Database/Functions/etablissement_controller.dart';
import '../../Core/Database/Models/etablissement.dart';
import '../Widgets/scrollable_widget.dart';

class EtablissementsTable extends StatefulWidget {
  const EtablissementsTable({super.key});

  @override
  State<EtablissementsTable> createState() => _EtablissementsTableState();
}

class _EtablissementsTableState extends State<EtablissementsTable> {
  Widget _buildDataTable(List<Etablissement> data) {
    return DataTable(
      columns: const [
        DataColumn(label: Text('Uid')),
        DataColumn(label: Text('Nom')),
        DataColumn(label: Text('Email')),
        DataColumn(label: Text('Nom Responsable')),
        DataColumn(label: Text('Edit')),
        DataColumn(label: Text('Delete')),
      ],
      rows: [
        for (final entry in data)
          DataRow(
            cells: [
              DataCell(Text(entry.uid)),
              DataCell(Text(entry.name)),
              DataCell(Text(entry.email)),
              DataCell(
                Text(entry.idResponsable),
              ),
              DataCell(
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {},
                ),
              ),
              DataCell(
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {},
                ),
              ),
            ],
          )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: EtablissmentController.getAllEtablissements(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return ScrollableWidget(
            child: _buildDataTable(snapshot.data),
          );
        } else if (snapshot.hasError) {
          return Center(child: Text(snapshot.error.toString()));
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
