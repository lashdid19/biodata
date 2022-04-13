// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors
import 'package:flutter/material.dart';

class ShowBiodata extends StatefulWidget {
  @override
  _ShowBioState createState() => _ShowBioState();
}

class _ShowBioState extends State<ShowBiodata> {
  Map data = {};

  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context)?.settings.arguments as Map;

    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Biodata"),
        backgroundColor: Colors.black87,
        elevation: 0,
      ),
      body: SafeArea(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          color: Colors.black87,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Hero(
                tag: data['id'],
                child: CircleAvatar(
                  backgroundColor: Color(int.parse("0x" + data['color'])),
                  minRadius: 40,
                  maxRadius: 65,
                  child: Text(
                    data['name'][0],
                    style: TextStyle(fontSize: 50, color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Text(
                data['name'],
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              Text(
                ("Kelas : " + data['room']),
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w300),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushReplacementNamed(
            context, '/edit-biodata',
            arguments: data),
        elevation: 0,
        backgroundColor: Colors.green,
        child: Icon(Icons.edit),
      ),
    );
  }
}
