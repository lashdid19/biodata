// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<Database> database() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'demo.db');

    Database database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE Biodata (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL, room TEXT NOT NULL, color TEXT NOT NULL)');
    });
    return database;
  }

  Future<List> showData() async {
    Database db = await database();
    List<Map> list = await db.rawQuery('SELECT * FROM Biodata');
    return list;
  }

  Future<void> deleteData(id) async {
    Database db = await database();
    await db.rawDelete('DELETE FROM Biodata WHERE id = ?', [id]);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Text("Daftar Biodata"),
        elevation: 0,
      ),
      body: SafeArea(
        child: Container(
          height: double.infinity,
          padding: EdgeInsets.fromLTRB(10, 10, 10, 80),
          color: Colors.black87,
          child: FutureBuilder(
            future: showData(),
            initialData: [],
            builder: (context, AsyncSnapshot snapshot) {
              var list = snapshot.data;
              return ListView.builder(
                shrinkWrap: true,
                itemCount: list.length,
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      Expanded(
                          flex: 10,
                          child: Container(
                              padding: EdgeInsets.all(10.0),
                              margin: EdgeInsets.only(bottom: 20.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      InkWell(
                                          onTap: () => Navigator.pushNamed(
                                              context, '/show-biodata',
                                              arguments: list[index]),
                                          child: Hero(
                                              tag: list[index]['id'],
                                              child: CircleAvatar(
                                                backgroundColor: Color(
                                                    int.parse("0x" +
                                                        list[index]['color'])),
                                                child: Text(
                                                  list[index]['name'][0],
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      color: Colors.white),
                                                ),
                                              ))),
                                      SizedBox(width: 20),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            list[index]['name'],
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          SizedBox(height: 5),
                                          Text(
                                            list[index]['room'],
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  IconButton(
                                    onPressed: () =>
                                        deleteData(list[index]['id']),
                                    icon: Icon(Icons.close_rounded),
                                    color: Colors.white,
                                  )
                                ],
                              )))
                    ],
                  );
                },
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => {
          Navigator.pushReplacementNamed(context, '/add-biodata'),
        },
        elevation: 0,
        backgroundColor: Colors.white,
        icon: Icon(
          Icons.add,
          color: Colors.black,
        ),
        label: Text(
          "Tambah",
          style: TextStyle(color: Colors.black),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
