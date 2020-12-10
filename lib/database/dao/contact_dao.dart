
import 'package:flutter_app/models/contact.dart';
import 'package:sqflite/sqflite.dart';
import '../app_database.dart';

// DAO -> Data Access Object :Contact Dao (Objeto de acesso de Dados),

class ContactDao {


  static const String tableName = 'contacts';
  static const String _Id = 'id';
  static const String _Nome = 'name';
  static const String _Account = 'account_number';

  static const String TABLE_SQL = 'CREATE TABLE $tableName ('
  '$_Id INTEGER PRIMARY KEY, '
  '$_Nome TEXT, '
  '$_Account INTEGER) ';


  Future<int> save(Contact contact) async {
    Map<String, dynamic> contactMap = toMap(contact); // cria o Map

    Database database = await createDatabase();
    return database.insert(tableName,
        contactMap); // 2º return para inserir a tabela contacts no database que é o nosso banco
  }

  Map<String, dynamic> toMap(Contact contact) {
    Map<String, dynamic> contactMap = Map();
    contactMap[_Nome] = contact.name;
    contactMap[_Account] = contact.accountNumber;
    return contactMap;
  }

  Future<List<Contact>> findAll() async {
    Database database = await createDatabase();
    // o createDataBase retorna o  Banco, 1º return para entrar no database.query
    List<Map<String, dynamic>> rows = await database.query(tableName);

    // query = select, o query retorna as info do banco, ele pega as info do banco como e estamos num future (.then) damos um 2º return
    List<Contact> contacts = toList(rows);
    return contacts; // 3º return, este é o mais interno.
  }

  List<Contact> toList(List<Map<String, dynamic>> rows) {
      List<Contact> contacts = List();
    for (Map<String, dynamic> row in rows) {
      Contact contact = Contact(
        row[_Id],
        row[_Nome],
        row[_Account],
      );
      contacts.add(contact);
    }
    return contacts;
  }
}



/* FAZENDO ESTE MESMO CODIGO USANDO FUTURE
Future<Database> createDatabase() {
  // createDataBase ( eu nomeei assim) é uma função onde guardo os parametros ( como o caminhoCompletoDoBanco) que vou passar ao openDataBase ( que é algo do dicionario do flutter, não se pode nomear)
  return getDatabasesPath().then((diretorioDosBancos) {
    final String caminhoCompletoDoBanco =
    join(diretorioDosBancos, 'bytebank.db');

    return openDatabase(
      caminhoCompletoDoBanco,
      onCreate: (database, version) {
        // retorna o banco, o openDataBase é quem abre ou cria o banco( se ele não existe), ele procura no banco as info que estão no caminhoCompletoDoBanco.
        database.execute('CREATE TABLE contacts ('
            'id INTEGER PRIMARY KEY, '
            'name TEXT, '
            'account_number INTEGER) ');
      },
      version: 1,
      // onDowngrade: onDatabaseDowngradeDelete,
    );
  });
}

Future<int> save(Contact contact) {
  Map<String, dynamic> contactMap = Map();
  contactMap['name'] = contact.name;
  contactMap['account_number'] = contact.accountNumber; // cria o Map

  return createDatabase().then((database) {
    // 1º return para poder entrar no database
    return database.insert('contacts',
        contactMap); // 2º return para inserir a tabela contacts no database que é o nosso banco
  });
}

Future<List<Contact>> findAll() {
  return createDatabase().then((database) {
    // o createDataBase retorna o  Banco, 1º return para entrar no database.query
    return database.query('contacts').then((rows) {
      // query = select, o query retorna as info do banco, ele pega as info do banco como e estamos num future (.then) damos um 2º return
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
*/
