import 'package:flutter/material.dart';
import 'package:flutter_app/database/app_database.dart';
import 'package:flutter_app/database/dao/contact_dao.dart';
import 'package:flutter_app/models/contact.dart';

class ContactForm extends StatefulWidget {
  @override
  _ContactFormState createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final TextEditingController nameController = TextEditingController();

  final TextEditingController accountNumberController = TextEditingController();
  final ContactDao dao = ContactDao();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Contact'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextField(
              controller: nameController,
              style: TextStyle(fontSize: 24.0),
              decoration: InputDecoration(labelText: 'Full name'),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: TextField(
                controller: accountNumberController,
                keyboardType: TextInputType.number,
                style: TextStyle(fontSize: 24.0),
                decoration: InputDecoration(
                    labelText: 'Account Number', hintText: '8000'),
              ),
            ),
            SizedBox(
              child: RaisedButton(
                child: Text('Create'),
                onPressed: () {
                  final String name = nameController.text;
                  final int accountNumber =
                      int.tryParse(accountNumberController.text);
                  final Contact newContact = Contact(0,name,accountNumber);
                  dao.save(newContact).then((id) =>  Navigator.pop(context));

                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
