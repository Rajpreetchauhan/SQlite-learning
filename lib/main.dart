import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Controller/appcontroller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  AppController appController = Get.put(AppController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
        "SQl Experiment",
      )),
      body: Obx(() {
        return ListView.builder(
          itemCount: appController.userlist.value.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title:
                  Text(appController.userlist.value[index].username.toString()),
              subtitle:
                  Text(appController.userlist.value[index].password.toString()),
              trailing: Wrap(
                spacing: -16,
                children: [
                  IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        Get.bottomSheet(textfieldtomakechanges(
                          textfieldbuttonname: "Update",
                          onpressed: () {
                            appController.updatefunction(
                              appController.userlist.value[index].username,
                              appController.userlist.value[index].password,
                            );
                          },
                        ));
                      }),
                  IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        appController.deleteuser(
                            appController.userlist.value[index].username);
                      }),
                ],
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.bottomSheet(textfieldtomakechanges(
              onpressed: () {
                appController.adduser(appController.userid.value.text.trim(),
                    appController.userid.value.text.trim());
                Get.back();
              },
              textfieldbuttonname: 'Add',
            ));
          },
          child: const Icon(Icons.add)),
    );
  }
}

class textfieldtomakechanges extends StatelessWidget {
  textfieldtomakechanges(
      {required this.textfieldbuttonname, required this.onpressed});

  final String textfieldbuttonname;
  final Function() onpressed;
  final AppController appController = AppController();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 250,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: appController.userid.value,
            ),
            TextField(
              controller: appController.userpassword.value,
            ),
            Row(
              children: [
                TextButton(
                    onPressed: onpressed, child: Text(textfieldbuttonname)),
              ],
            )
          ],
        ),
      ),
    );
    ;
  }
}
