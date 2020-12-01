import 'package:flutter/material.dart';
import 'package:flutter_app/screens/contacts_list.dart';
import 'package:flutter_app/screens/dashboard.dart';
import 'package:flutter_app/screens/formulario_de_contatos.dart';

import 'database/app_database.dart';
import 'models/contact.dart';

void main() {
  runApp(BytebankApp());
  save(Contact(1,'ana',2000)).then((id){
    findAll().then((contacts) => debugPrint(contacts.toString()));
  });

}

class BytebankApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primaryColor: Colors.green[900],
          accentColor: Colors.blueAccent[700],
          buttonTheme: ButtonThemeData(
            buttonColor: Colors.blueAccent[700],
            textTheme: ButtonTextTheme.primary,
          )
      ),

      home: Dashboard(), //ContactsList(),
    );
  }
}



