import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter_app/models/contact.dart';

Future<Database> createDatabase() { // createDataBase ( eu nomeei assim) é uma função onde guardo os parametros ( como o caminhoCompletoDoBanco) que vou passar ao openDataBase ( que é algo do dicionario do flutter, não se pode nomear)
  return getDatabasesPath().then((diretorioDosBancos) {
    final String caminhoCompletoDoBanco = join(diretorioDosBancos, 'bytebank.db');

    return openDatabase(caminhoCompletoDoBanco, onCreate: (database, version) { // retorna o banco, o openDataBase é quem abre ou cria o banco( se ele não existe), ele procura no banco as info que estão no caminhoCompletoDoBanco.
      database.execute('CREATE TABLE contacts ('
          'id INTEGER PRIMARY KEY, '
          'name TEXT, '
          'account_number INTEGER) ');
    }, version: 1);
  });
}

Future<int> save(Contact contact) {
  Map<String, dynamic> contactMap = Map();
  contactMap['name'] = contact.name;
  contactMap['account_number'] = contact.accountNumber;// cria o Map

  return createDatabase().then((database) { // 1º return para poder entrar no database
    return database.insert('contacts', contactMap); // 2º return para inserir a tabela contacts no database que é o nosso banco
  });
}

Future<List<Contact>> findAll() {
  return createDatabase().then((database) { // o createDataBase retorna o  Banco, 1º return para entrar no database.query
    return database.query('contacts').then((rows) { // query = select, o query retorna as info do banco, ele pega as info do banco como e estamos num future (.then) damos um 2º return
      List<Contact> contacts = List();
      for (Map<String, dynamic> row in rows) {
        Contact contact =
            Contact(row['id'], row['name'], row['account_number']);
        contacts.add(contact);
      }
      return contacts; // 3º return, este é o mais interno.
    });
  });
}
