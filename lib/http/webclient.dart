import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app/models/contact.dart';
import 'package:flutter_app/models/transaction.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http_client_with_interceptor.dart';
import 'package:http_interceptor/interceptor_contract.dart';
import 'package:http_interceptor/models/request_data.dart';
import 'package:http_interceptor/models/response_data.dart';


HttpClientWithInterceptor httpClient = HttpClientWithInterceptor.build(
  interceptors: [LoggingInterceptor()],
);

class LoggingInterceptor implements InterceptorContract {
  // interceptores
  @override
  Future<RequestData> interceptRequest({RequestData data}) async {
    debugPrint('Requisição: ${data.url}');
    debugPrint('Headers: ${data.headers}');
    debugPrint('Body: ${data.body}');

    return data;
  }

  @override
  Future<ResponseData> interceptResponse({ResponseData data}) async {
    debugPrint('Resposta: ${data.statusCode}');
    debugPrint('Headers: ${data.headers}');
    debugPrint('Body: ${data.body}');
    return data;
  }
}

Future<List<Transaction>> findAllTransactions() async {


  Response response =
      await httpClient.get('http://192.168.1.2:8080/transactions').timeout(Duration(seconds: 5));
  List<dynamic> decodedJson = jsonDecode(response
      .body); //decodifica a string da resposta para uma lista de qqr coisa

  List<Transaction> transactions = List(); // cria a lista de transações
  for (Map<String, dynamic> json in decodedJson) {
    // converte o Map(representa o json) em transaction
    Map<String, dynamic> jsonContact = json[
        'contact']; //cria uma variavel jsonContact para se referir à contact
    Contact contact = Contact(
        0,
        jsonContact['name'],
        jsonContact[
            'accountNumber']); // chama a variavel jsonContact para acessar o name e accoudentro do contact

    Transaction transaction = Transaction(json['value'],
        contact); // este é o objeto da transação ( dentro dele tem as info)
    transactions.add(transaction); // adicionando a transação na lista
  }

  debugPrint('Transações decodificadas do JSON: $transactions');
  return transactions;
}

Future<Transaction>saveTransaction(Transaction transaction)async {
  Map<String,dynamic> transactionMap ={
    'value': transaction.value,
    'contact':{
      'name':transaction.contact.name,
      'accountNumber': transaction.contact.accountNumber,
    }
  };
  String transationJson = jsonEncode(transactionMap);

  Response response = await httpClient.post('http://192.168.1.2:8080/transactions', body: transationJson, headers:{
    'Content-Type': 'application/json',
    'password' :'1000'
  });

  Map<String, dynamic> responseJson = jsonDecode(response.body);
  Map<String, dynamic> jsonContact = responseJson['contact']; //cria uma variavel jsonContact para se referir à contact
  Contact contact = Contact(
      0,
      jsonContact['name'],
      jsonContact['accountNumber']); // chama a variavel jsonContact para acessar o name e accoudentro do contact
  return Transaction(responseJson['value'], contact);
}