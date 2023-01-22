import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

import '../../Core/Database/Controllers/users_controller.dart';

class UserFilesPage extends StatefulWidget {
  const UserFilesPage({Key? key}) : super(key: key);

  @override
  State<UserFilesPage> createState() => _UserFilesPageState();
}

class _UserFilesPageState extends State<UserFilesPage> {
  late DropzoneViewController dropZoneController;
  UploadTask? uploadTask;
  double progress = 0;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text("User Files"),
        ),
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: size.height,
                width: size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: size.width / 2,
                        height: size.height * 0.3,
                        child: Stack(
                          children: [
                            DottedBorder(
                              color: Colors.black,
                              strokeWidth: 2,
                              dashPattern: const [10, 10],
                              borderType: BorderType.RRect,
                              radius: const Radius.circular(20),
                              child: DropzoneView(
                                operation: DragOperation.copy,
                                cursor: CursorType.grab,
                                onCreated: (DropzoneViewController controller) {
                                  dropZoneController = controller;
                                },
                                onDrop: (value) async {
                                  String userId =
                                      UsersController.currentUser!.id;
                                  String fileName = await dropZoneController
                                      .getFilename(value);
                                  Uint8List data = await dropZoneController
                                      .getFileData(value);
                                  try {
                                    final String path =
                                        'files/$userId/$fileName';
                                    final Reference ref =
                                        FirebaseStorage.instance.ref(path);
                                    setState(() {
                                      uploadTask = ref.putData(data);
                                    });
                                    await uploadTask!.whenComplete(() {
                                      setState(() {
                                        progress = 0;
                                      });
                                    });

                                    setState(() {
                                      uploadTask = null;
                                    });
                                  } catch (e) {
                                    if (kDebugMode) {
                                      print(e);
                                    }
                                  }
                                },
                              ),
                            ),
                            const Center(
                              child: Text(
                                "Drag and Drop Files Here",
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: FutureBuilder(
                        future: FirebaseStorage.instance
                            .ref('files/${UsersController.currentUser!.id}')
                            .listAll(),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
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
                                          await snapshot.data.items[index]
                                              .delete();
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
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: StreamBuilder(
                stream: uploadTask?.snapshotEvents,
                builder: (BuildContext context,
                    AsyncSnapshot<TaskSnapshot> snapshot) {
                  if (snapshot.hasData) {
                    progress = snapshot.data!.bytesTransferred /
                        snapshot.data!.totalBytes;
                    return SizedBox(
                        height: 50,
                        width: size.width,
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            LinearProgressIndicator(
                              color: Colors.green,
                              backgroundColor: Colors.grey,
                              value: progress,
                            ),
                            Center(
                              child: Text(
                                "${(progress * 100).toStringAsFixed(2)} %",
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            ),
                          ],
                        ));
                  } else if (snapshot.hasError) {
                    return const Text("Error");
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            ),
          ],
        ));
  }
}
