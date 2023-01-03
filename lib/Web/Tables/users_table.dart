import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_integre/Core/Database/Functions/users_controller.dart';

import '../../Core/Database/Models/Accounts/compte.dart';
import '../Widgets/scrollable_widget.dart';

class UsersTablePage extends StatefulWidget {
  const UsersTablePage({super.key});

  @override
  State<UsersTablePage> createState() => _UsersTablePageState();
}

class _UsersTablePageState extends State<UsersTablePage> {
  bool passwordVisible = false;

  _buildButtons() {
    return [
      ElevatedButton(
        onPressed: () {
          setState(() {
            passwordVisible = !passwordVisible;
          });
        },
        child: Icon(passwordVisible ? Icons.visibility : Icons.visibility_off),
      ),
      ElevatedButton(
        child: const Text("Add Account"),
        onPressed: () {},
      ),
      ElevatedButton(
        child: const Text("Delete Selected Accounts"),
        onPressed: () {},
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return StreamBuilder(
      stream: UsersController.getAllAccounts(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return Padding(
            padding: EdgeInsets.all(size.width * 0.05),
            child: Column(
              children: [
                ScrollableWidget(
                  child: UsersTable(
                    data: snapshot.data,
                    passwordVisible: passwordVisible,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: _buildButtons(),
                  ),
                )
              ],
            ),
          );
        } else if (snapshot.hasError) {
          return Center(child: Text(snapshot.error.toString()));
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

class UsersTable extends StatefulWidget {
  const UsersTable(
      {super.key, required this.data, required this.passwordVisible});

  final List<Compte> data;
  final bool passwordVisible;

  @override
  State<UsersTable> createState() => _UsersTableState();
}

class _UsersTableState extends State<UsersTable> {
  List<Compte> selectedData = [];

  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late int accType;

  @override
  void initState() {
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DataTable(
      onSelectAll: (isSelectedAll) => setState(() {
        if (isSelectedAll!) {
          selectedData = widget.data;
        } else {
          selectedData = [];
        }
      }),
      columns: const [
        DataColumn(label: Text('Uid')),
        DataColumn(label: Text('Name')),
        DataColumn(label: Text('Email')),
        DataColumn(label: Text('Password')),
        DataColumn(label: Text('Type')),
        DataColumn(label: Text('Edit')),
        DataColumn(label: Text('Delete')),
      ],
      rows: widget.data.map<DataRow>((Compte entry) {
        return DataRow(
          selected: selectedData.contains(entry),
          onSelectChanged: (value) => setState(() {
            final isAdding = value != null && value;
            if (isAdding) {
              selectedData.add(entry);
            } else {
              selectedData.remove(entry);
            }
          }),
          cells: [
            DataCell(Text(entry.id)),
            DataCell(Text(entry.name)),
            DataCell(Text(entry.email)),
            DataCell(
              Text(widget.passwordVisible ? entry.password : "********"),
            ),
            DataCell(
              Text(
                (entry.accType == 0)
                    ? "Admin"
                    : (entry.accType == 1)
                        ? "Responsable"
                        : (entry.accType == 2)
                            ? "Prof"
                            : "Student",
              ),
            ),
            DataCell(
              IconButton(
                splashRadius: 10,
                icon: const Icon(Icons.edit),
                onPressed: () => _editAccount(entry),
              ),
            ),
            DataCell(
              IconButton(
                splashRadius: 10,
                icon: const Icon(Icons.delete),
                onPressed: () {
                  UsersController.deleteAccount(entry.id);
                },
              ),
            ),
          ],
        );
      }).toList(),
    );
  }

  deleteSelecteddata() {
    for (var element in selectedData) {
      UsersController.deleteAccount(element.id);
    }
    setState(() {
      selectedData = [];
    });
  }

  _editAccount(Compte compte) {
    nameController.text = compte.name;
    emailController.text = compte.email;
    passwordController.text = compte.password;
    accType = compte.accType;
    Get.defaultDialog(
      title: "Edit Account",
      content: Column(
        children: [
          TextFormField(
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
              labelStyle: TextStyle(color: Theme.of(context).primaryColor),
              prefixIcon: Icon(
                Icons.person,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          const SizedBox(height: 10),
          TextFormField(
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
              labelStyle: TextStyle(color: Theme.of(context).primaryColor),
              prefixIcon: Icon(
                Icons.email,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: passwordController,
            cursorColor: Theme.of(context).primaryColor,
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Theme.of(context).primaryColor, width: 2.0),
              ),
              focusColor: Theme.of(context).primaryColor,
              contentPadding: const EdgeInsets.all(15),
              border: const OutlineInputBorder(),
              labelText: 'Password',
              labelStyle: TextStyle(color: Theme.of(context).primaryColor),
              prefixIcon: Icon(
                Icons.lock,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          const SizedBox(height: 10),
          ChipsChoice<int>.single(
            value: accType,
            onChanged: (int val) => setState(() => accType = val),
            choiceItems: C2Choice.listFrom<int, String>(
              source: const ['Admin', 'Responsable', 'Prof', 'Student'],
              value: (int index, String item) => index,
              label: (int index, String item) => item,
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: const Text("Cancel"),
        ),
        TextButton(
          onPressed: () {
            UsersController.updateAccount(
              Compte(
                id: compte.id,
                name: nameController.text,
                email: emailController.text,
                password: passwordController.text,
                accType: accType,
              ),
            );
            Get.back();
          },
          child: const Text("Save"),
        ),
      ],
    );
  }
}
