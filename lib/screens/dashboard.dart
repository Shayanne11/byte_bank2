import 'package:flutter/material.dart';
import 'package:flutter_app/screens/contacts_list.dart';
import 'package:flutter_app/screens/transactions_list.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset('images/bytebank_logo.png'),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  FutureItem('Transfer', Icons.monetization_on, onClick:() => _showContactList(context),
                    //nós decidimos chamar de onclick
                   //*3 do primeiro botão
                  ), ////*1,*2 e *3
                  FutureItem('Transaction Feed', Icons.description, onClick:() => _showTransactionList(context),
                  ),
                  //*1 e *2, do segundo botão
                ], // children do ROW
              ),
            ),
          ], // children
        ),
      ),
    );
  }

  void _showContactList(BuildContext context){
    Navigator.of(context).push(MaterialPageRoute(
      builder: (ctx) => ContactsList(),
    ));
  }

  void _showTransactionList(BuildContext context){
    Navigator.of(context).push(MaterialPageRoute(
      builder: (ctx) => TransactionsList(),
    ));
  }
}


class FutureItem extends StatelessWidget {

  String label; // nomeei label, vai servir para que eu modifique só uma vez os campos do texto do botão(*1)
  IconData icon; // nomeei icon, vai servir para que eu modifique só uma vez os icone do botão(*2)
  Function onClick; // *3
  FutureItem(this.label, this.icon, {@required this.onClick}); // não esquecer do construtor

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: Theme
            .of(context)
            .primaryColor,
        child: InkWell(
          onTap: () {
            onClick();
          },
          child: Container(
            padding: const EdgeInsets.all(8.0),
            height: 100,
            width: 150,
            child: Column( // tire o color daqui para ter o efeito de apertar o botão
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  icon,
                  color: Colors.white,
                  size: 40.0,
                ),
                Text(
                  label,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

