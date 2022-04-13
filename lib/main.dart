import 'package:flutter/material.dart';
import 'package:biodata/pages/home.dart';
import 'package:biodata/pages/add_biodata.dart';
import 'package:biodata/pages/show_biodata.dart';
import 'package:biodata/pages/edit_biodata.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/home',
      routes: {
        '/home': (context) => Home(),
        '/add-biodata': (context) => AddBiodata(),
        '/edit-biodata': (context) => EditBiodata(),
        '/show-biodata': (context) => ShowBiodata()
      },
    ));
