// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:math';

class EditBiodata extends StatefulWidget {
  @override
  _EditBioState createState() => _EditBioState();
}

class _EditBioState extends State<EditBiodata> {
  Map data = {};

  Future<Database> database() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'demo.db');

    Database database = await openDatabase(path, version: 1);
    return database;
  }

  final name = TextEditingController();
  final room = TextEditingController();

  Future<void> editData(String name, String room, id) async {
    Database db = await database();
    await db.transaction((txn) async {
      await txn.rawInsert('UPDATE Biodata SET name = ?, room = ? WHERE id = ?',
          [name, room, id]);
    });
  }

  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context)?.settings.arguments as Map;
    name.text = data['name'];
    room.text = data['room'];
    editItem() {
      if (name.text.isEmpty || room.text.isEmpty) {
        showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('Form Kosong'),
            content: const Text('Silahkan isi semua form'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'OK'),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      } else {
        editData(name.text, room.text, data['id']);
        Navigator.pop(context);
        Navigator.pushReplacementNamed(context, '/home');
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Tambah Biodata"),
        backgroundColor: Colors.black87,
        // leading: IconButton(
        //   icon: Icon(Icons.arrow_back),
        //   onPressed: () {
        //     Navigator.pushReplacementNamed(context, '/home');
        //   },
        // ),
        elevation: 0,
      ),
      body: SafeArea(
        child: Container(
          height: double.infinity,
          padding: EdgeInsets.all(10),
          color: Colors.black87,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Colors.grey[850],
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                child: TextField(
                  controller: name,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    border: InputBorder.none,
                    hintStyle: TextStyle(color: Colors.grey[600]),
                    hintText: 'Nama',
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.grey[850],
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                child: TextField(
                  controller: room,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    border: InputBorder.none,
                    hintStyle: TextStyle(color: Colors.grey[600]),
                    hintText: 'Kelas',
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton.icon(
                onPressed: editItem,
                style: ElevatedButton.styleFrom(primary: Colors.green),
                icon: Icon(
                  Icons.edit,
                  color: Colors.white,
                ),
                label: Text("Edit", style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
