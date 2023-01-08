import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:searchbar_animation/searchbar_animation.dart';
import '../../Core/Database/Controllers/etablissement_controller.dart';
import '../../Core/Database/Controllers/users_controller.dart';
import '../../Core/Database/Models/compte.dart';
import '../../Core/Database/Models/etablissement.dart';
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
  late TextEditingController nameController;
  late TextEditingController emailController;
  String searchQuery = "";
  late Compte? selectedUser;

  late TextEditingController searchControllerForAdding;

  @override
  void initState() {
    nameController = TextEditingController();
    emailController = TextEditingController();
    searchControllerForAdding = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    searchControllerForAdding.dispose();
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
                padding: const EdgeInsets.all(8.0),
                child: Wrap(
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
          isOriginalAnimation: false,
          buttonBorderColour: Colors.black45,
          buttonWidget: const Icon(Icons.search),
          secondaryButtonWidget: const Icon(Icons.close),
          textEditingController: TextEditingController(),
          trailingWidget: const Icon(Icons.search),
          onChanged: (String value) {
            setState(() {
              searchQuery = value;
            });
          },
          onEditingComplete: () {
            debugPrint('onEditingComplete');
          },
          onPressButton: (bool? value) {
            debugPrint('onPressButton');
          },
        ),
      ],
    );
  }

  _buildButtons() {
    return [
      const Spacer(),
      ElevatedButton(
        onPressed: _addEtablissement,
        child: const Text("Add Etablissement"),
      ),
    ];
  }

  _addEtablissement() {
    Get.defaultDialog(
      title: "Add Etablissement",
      content: Padding(
        padding: const EdgeInsets.all(25.0),
        child: StreamBuilder(
          stream: UsersController.getAllAccountsStream(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasData) {
              selectedUser = snapshot.data[0];
              return Column(
                children: [
                  TextField(
                    controller: nameController,
                    cursorColor: Theme.of(context).primaryColor,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).primaryColor, width: 2.0),
                      ),
                      focusColor: Theme.of(context).primaryColor,
                      contentPadding: const EdgeInsets.all(15),
                      border: const OutlineInputBorder(),
                      labelText: 'Name',
                      labelStyle:
                          TextStyle(color: Theme.of(context).primaryColor),
                      prefixIcon: Icon(
                        Icons.business,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: emailController,
                    cursorColor: Theme.of(context).primaryColor,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).primaryColor, width: 2.0),
                      ),
                      focusColor: Theme.of(context).primaryColor,
                      contentPadding: const EdgeInsets.all(15),
                      border: const OutlineInputBorder(),
                      labelText: 'Email',
                      labelStyle:
                          TextStyle(color: Theme.of(context).primaryColor),
                      prefixIcon: Icon(
                        Icons.email,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  DropdownButton2(
                    hint: const Text("Select User"),
                    value: selectedUser,
                    searchController: searchControllerForAdding,
                    items: [
                      for (Compte user in snapshot.data)
                        DropdownMenuItem(
                          value: user,
                          child: Text(user.name),
                        )
                    ],
                    onChanged: (value) => setState(() {
                      selectedUser = value;
                    }),
                  )
                ],
              );
            } else if (snapshot.hasError) {
              selectedUser = null;
              return const Center(
                child: Text("Error"),
              );
            } else {
              selectedUser = null;
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            EtablissementController.createEtablissement(
              Etablissement(
                  name: nameController.text,
                  idResponsable: selectedUser!.id,
                  email: emailController.text),
            );
            Get.back();
          },
          child: const Text("Add"),
        ),
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: const Text("Cancel"),
        ),
      ],
    );
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
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController searchControllerForModifying;
  late Compte? selectedUser;

  @override
  void initState() {
    nameController = TextEditingController(text: widget.etablissement.name);
    emailController = TextEditingController(text: widget.etablissement.email);
    searchControllerForModifying = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    searchControllerForModifying.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size.width * 0.35,
      height: widget.size.height * 0.3,
      child: Card(
          child: Stack(
        children: [
          Column(
            children: [
              Container(
                width: double.infinity,
                color: Colors.blue,
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
                  Text(widget.etablissement.idResponsable),
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
                IconButton(
                  splashRadius: 10,
                  onPressed: _editEtablissement,
                  icon: const Icon(Icons.edit),
                ),
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

  _editEtablissement() {
    Get.defaultDialog(
      title: "Add Etablissement",
      content: Padding(
        padding: const EdgeInsets.all(25.0),
        child: StreamBuilder(
          stream: UsersController.getAllAccountsStream(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasData) {
              selectedUser = snapshot.data[0];
              return Column(
                children: [
                  TextField(
                    controller: nameController,
                    cursorColor: Theme.of(context).primaryColor,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).primaryColor, width: 2.0),
                      ),
                      focusColor: Theme.of(context).primaryColor,
                      contentPadding: const EdgeInsets.all(15),
                      border: const OutlineInputBorder(),
                      labelText: 'Name',
                      labelStyle:
                          TextStyle(color: Theme.of(context).primaryColor),
                      prefixIcon: Icon(
                        Icons.business,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: emailController,
                    cursorColor: Theme.of(context).primaryColor,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).primaryColor, width: 2.0),
                      ),
                      focusColor: Theme.of(context).primaryColor,
                      contentPadding: const EdgeInsets.all(15),
                      border: const OutlineInputBorder(),
                      labelText: 'Email',
                      labelStyle:
                          TextStyle(color: Theme.of(context).primaryColor),
                      prefixIcon: Icon(
                        Icons.email,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  DropdownButton2(
                    hint: const Text("Select User"),
                    value: selectedUser,
                    searchController: searchControllerForModifying,
                    items: [
                      for (Compte user in snapshot.data)
                        DropdownMenuItem(
                          value: user,
                          child: Text(user.name),
                        )
                    ],
                    onChanged: (value) => setState(() {
                      selectedUser = value;
                    }),
                  )
                ],
              );
            } else if (snapshot.hasError) {
              selectedUser = null;
              return const Center(
                child: Text("Error"),
              );
            } else {
              selectedUser = null;
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            EtablissementController.updateEtablissement(Etablissement(
              name: nameController.text,
              idResponsable: selectedUser!.id,
              email: emailController.text,
            ));
            Get.back();
          },
          child: const Text("Modify"),
        ),
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: const Text("Cancel"),
        ),
      ],
    );
  }
}
