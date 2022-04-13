// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:math';

class AddBiodata extends StatefulWidget {
  @override
  _AddBioState createState() => _AddBioState();
}

class _AddBioState extends State<AddBiodata> {
  Future<Database> database() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'demo.db');

    Database database = await openDatabase(path, version: 1);

    // await database.transaction((txn) async {
    //   Color materialColor =
    //       Colors.primaries[Random().nextInt(Colors.primaries.length)];
    //   String hexColor = materialColor.value.toRadixString(16);
    //   int id1 = await txn.rawInsert(
    //       'INSERT INTO Biodata(name, room, color) VALUES(?, ?, ?)',
    //       ["Adit", "XII RPL 1", hexColor]);
    // });
    return database;
  }

  final name = TextEditingController();
  final room = TextEditingController();

  Future<void> addData(String name, String room) async {
    Database db = await database();
    await db.transaction((txn) async {
      Color materialColor =
          Colors.primaries[Random().nextInt(Colors.primaries.length)];
      String hexColor = materialColor.value.toRadixString(16);
      await txn.rawInsert(
          'INSERT INTO Biodata(name, room, color) VALUES(?, ?, ?)',
          [name, room, hexColor]);
    });
  }

  @override
  Widget build(BuildContext context) {
    addItem() {
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
        addData(name.text, room.text);
        Navigator.pushReplacementNamed(context, '/home');
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Tambah Biodata"),
        backgroundColor: Colors.black87,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/home');
          },
        ),
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
                onPressed: addItem,
                style: ElevatedButton.styleFrom(primary: Colors.white),
                icon: Icon(
                  Icons.add,
                  color: Colors.black,
                ),
                label: Text("Tambah", style: TextStyle(color: Colors.black)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
