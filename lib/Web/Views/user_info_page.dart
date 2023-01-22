import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:widget_circular_animator/widget_circular_animator.dart';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

import '../../Core/Database/Models/compte.dart';

class UserInfoPage extends StatefulWidget {
  const UserInfoPage({Key? key, required this.user}) : super(key: key);

  final Compte user;
  @override
  State<UserInfoPage> createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "User Info:",
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 20),
              UserInfo(user: widget.user),
              const SizedBox(height: 20),
              const Divider(),
              const Text(
                "Files:",
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: FutureBuilder(
                  future: FirebaseStorage.instance
                      .ref('files/${widget.user.id}')
                      .listAll(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data.items.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            leading: const Icon(Icons.folder),
                            title: Text(snapshot.data.items[index].name),
                            trailing: Wrap(
                              children: <Widget>[
                                IconButton(
                                  onPressed: () async {
                                    String url = await snapshot
                                        .data.items[index]
                                        .getDownloadURL();
                                    html.AnchorElement anchorElement =
                                        html.AnchorElement(href: url);
                                    anchorElement.download = url;
                                    anchorElement.click();
                                  },
                                  icon: const Icon(Icons.download),
                                ),
                                IconButton(
                                  onPressed: () async {
                                    await snapshot.data.items[index].delete();
                                    setState(() {});
                                  },
                                  icon: const Icon(Icons.delete),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    } else if (snapshot.hasError) {
                      return const Text("Error");
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class UserInfo extends StatelessWidget {
  const UserInfo({Key? key, required this.user}) : super(key: key);

  final Compte user;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return IntrinsicHeight(
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: size.width * 0.1,
              right: size.width * 0.1,
            ),
            child: WidgetCircularAnimator(
              innerColor: Theme.of(context).primaryColor,
              outerColor: Theme.of(context).primaryColor,
              size: size.height * 0.5,
              child: CircularProfileAvatar(
                "",
                cacheImage: true,
                radius: size.height * 0.4,
                backgroundColor: Colors.transparent,
                borderWidth: 0,
                borderColor: Colors.transparent,
                child: Icon(
                  Icons.person,
                  size: size.height * 0.1,
                ),
              ),
            ),
          ),
          VerticalDivider(
            thickness: 5,
            color: Theme.of(context).primaryColor,
          ),
          SizedBox(width: size.width * 0.1),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Row(
                children: [
                  const Text("Name: "),
                  const SizedBox(width: 10),
                  Text(user.name),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Email: "),
                  const SizedBox(width: 10),
                  Text(user.email),
                ],
              ),
              const Spacer(),
            ],
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
