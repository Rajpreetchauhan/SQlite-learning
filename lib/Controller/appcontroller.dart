import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sqlappuse/Controller/sqlcontroller.dart';
import 'package:sqlappuse/Models/models.dart';

class AppController extends Sqlcontroller {
  @override
  void onInit() {
    getallusers();
    // TODO: implement onInit
    super.onInit();
  }

  var userlist = <Userlogin>[].obs;

  var userid = TextEditingController().obs;
  var userpassword = TextEditingController().obs;

  getallusers() async {
    userlist.clear();
    var dbfile = await db;
    var userdatatable = await dbfile?.rawQuery("SELECT * FROM user");
    for (var element in userdatatable!) {
      userlist.add(Userlogin.fromMap(element));
    }
  }

  adduserdata(name, password) async {
    var dbfile = await db;
    await dbfile?.rawQuery(
        "INSERT INTO user ('username', 'password') VALUES ('$name', '$password')");
    getallusers();
  }

  adduser(name, password) async {
    var dbfile = await db;
    var data = {'username': name, 'password': password};
    await dbfile?.insert("user", data);
    getallusers();
  }

  deleteuser(name) async {
    var dbfile = await db;
    await dbfile?.delete("user", where: "username='$name'");
    getallusers();
  }

  updatefunction(name, password) async {
    var dbfile = await db;
    await dbfile?.update("users", {'username': name},
        where: "password='$password'");
  }
}
