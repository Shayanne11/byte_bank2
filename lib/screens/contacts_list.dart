import 'package:flutter/material.dart';
import 'package:flutter_app/database/app_database.dart';
import 'package:flutter_app/models/contact.dart';
import 'package:flutter_app/screens/formulario_de_contatos.dart';

class ContactsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Contact> contacts = List(); // vai vir do Banco

    return Scaffold(
      appBar: AppBar(
        title: Text('Contacts'),
      ),
      body: FutureBuilder(
        future: findAll(),
        builder: (context, snapshot) {
          List<Contact> contacts = snapshot.data;
          return ListView.builder(
              itemCount: contacts.length,
              itemBuilder: (context, index) {
                Contact contact = contacts[index];
                return ContactItem(contact);
              });
        }, // builder
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(
                builder: (context) => ContactForm(),
              ))
              .then((newContact) => debugPrint(newContact.toString()));
        },// onPressed
        child: Icon(Icons.add),
      ),
    );
  }
}

class ContactItem extends StatelessWidget {
  final Contact contact;

  ContactItem(this.contact);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(
          'Alex',
          style: TextStyle(fontSize: 24.0),
        ),
        subtitle: Text(
          '1000',
          style: TextStyle(fontSize: 16.0),
        ),
      ),
    );
  }
}
