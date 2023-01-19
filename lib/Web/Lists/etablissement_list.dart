import 'package:flutter/material.dart';
import 'package:searchbar_animation/searchbar_animation.dart';
import '../../Core/Database/Controllers/etablissement_controller.dart';
import '../../Core/Database/Controllers/users_controller.dart';
import '../../Core/Database/Models/etablissement.dart';
import '../ControlPopUps/etablissement_pop_ups.dart';
import '../Widgets/scrollable_widget.dart';

class EtablissementListPage extends StatelessWidget {
  const EtablissementListPage({Key? key}) : super(key: key);

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
  late TextEditingController searchController;
  String searchQuery = "";

  @override
  void initState() {
    searchController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          _buildSearchBar(size),
          Expanded(
            child: ScrollableWidget(
              child: Padding(
                padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
                child: Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 10,
                  children: [
                    if (searchQuery.isEmpty)
                      for (Etablissement etablissement in widget.data)
                        EtablissementCard(
                            size: size, etablissement: etablissement),
                    if (searchQuery.isNotEmpty)
                      for (Etablissement etablissement in widget.data)
                        if (etablissement.name.toLowerCase().contains(
                              searchQuery.toLowerCase(),
                            ))
                          EtablissementCard(
                              size: size, etablissement: etablissement)
                  ],
                ),
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

  _buildSearchBar(Size size) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SearchBarAnimation(
          textEditingController: searchController,
          isOriginalAnimation: false,
          buttonBorderColour: Colors.black45,
          buttonWidget: const Icon(Icons.search),
          secondaryButtonWidget: const Icon(Icons.close),
          trailingWidget: const Icon(Icons.search),
          onChanged: (String value) {
            setState(() {
              searchQuery = value;
            });
          },
        ),
      ],
    );
  }

  _buildButtons() {
    return [const Spacer(), const AddEtablissement()];
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
    return SizedBox(
      width: widget.size.width * 0.3,
      height: widget.size.height * 0.3,
      child: Card(
          child: Stack(
        children: [
          Column(
            children: [
              Container(
                width: double.infinity,
                color: Theme.of(context).primaryColor,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(widget.etablissement.name),
                  ),
                ),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Responsable: "),
                  FutureBuilder(
                    future: UsersController.getAccount(
                        widget.etablissement.idResponsable),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        return Text(snapshot.data.name);
                      } else if (snapshot.hasError) {
                        return const Text("Error");
                      } else {
                        return const Text("Loading");
                      }
                    },
                  ),
                ],
              ),
              const Spacer(),
            ],
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Row(
              children: [
                ModifyEtablissement(etablissement: widget.etablissement),
                IconButton(
                  splashRadius: 10,
                  onPressed: () {
                    EtablissementController.deleteEtablissement(
                        widget.etablissement.uid);
                  },
                  icon: const Icon(Icons.delete),
                ),
              ],
            ),
          ),
        ],
      )),
    );
  }
}
