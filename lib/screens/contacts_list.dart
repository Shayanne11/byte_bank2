import 'package:flutter/material.dart';
import 'package:flutter_app/database/app_database.dart';
import 'package:flutter_app/database/dao/contact_dao.dart';
import 'package:flutter_app/models/contact.dart';
import 'package:flutter_app/screens/formulario_de_contatos.dart';

class ContactsList extends StatefulWidget {
  @override
  _ContactsListState createState() => _ContactsListState();
}

class _ContactsListState extends State<ContactsList> {
  ContactDao dao = ContactDao(); // crie o objeto para poder chamar os métodos da classe

  @override
  Widget build(BuildContext context) {
    List<Contact> contacts = List(); // vai vir do Banco

    return Scaffold(
      appBar: AppBar(
        title: Text('Transfer'),
      ),
      body: FutureBuilder<List<Contact>>(
          initialData: List(),
          // cria lista vazia, que é passada como promeiro dado para o snapshot
          future:
              Future.delayed(Duration(seconds: 2)).then((value) => dao.findAll()),
          // o 'future:' tem varios estados, mostrado pelo snapshot.
          builder: (context, snapshot) {
            // o snapshot verifica varias vezes o contacts,

            switch (snapshot.connectionState) {

              case ConnectionState.none:
                break;

              case ConnectionState.waiting:
                return Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      Text('Loading...'),
                    ],
                  ),
                );
                break;

              case ConnectionState.active:
                break;

              case ConnectionState.done:
                final List<Contact> contacts = snapshot.data;
                return ListView.builder(
                  itemBuilder: (context, index) {
                    final Contact contact = contacts[index];
                    return ContactItem(contact);
                  },
                  itemCount: contacts.length,
                );
                break;
            }// switch
            return Text('Erro desconhecido! Entre em contato com o nosso suporte.');
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(
                builder: (context) => ContactForm(),
              ))
              .then((newContact) => setState (() =>debugPrint('Recarregando a Lista...')));
        }, // onPressed
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
          contact.name,
          style: TextStyle(fontSize: 24.0),
        ),
        subtitle: Text(
          contact.accountNumber.toString(),
          style: TextStyle(fontSize: 16.0),
        ),
      ),
    );
  }
}
