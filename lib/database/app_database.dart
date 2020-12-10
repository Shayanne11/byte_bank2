import 'package:flutter_app/database/dao/contact_dao.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter_app/models/contact.dart';

// CODIGO COM ASYNC ( ver versão com future .then em contact_dao)
Future<Database> createDatabase() async {
  // createDataBase ( eu nomeei assim) é uma função onde guardo os parametros ( como o caminhoCompletoDoBanco) que vou passar ao openDataBase ( que é algo do dicionario do flutter, não se pode nomear)
  String diretorioDosBancos = await getDatabasesPath();
  String caminhoCompletoDoBanco = join(diretorioDosBancos, 'bytebank.db');

  return openDatabase(
    caminhoCompletoDoBanco,
    onCreate: (db, version) {
      // retorna o banco, o openDataBase é quem abre ou cria o banco( se ele não existe), ele procura no banco as info que estão no caminhoCompletoDoBanco.
      db.execute(ContactDao.TABLE_SQL);
    },
    version: 1,
    // onDowngrade: onDatabaseDowngradeDelete,
  );
}
