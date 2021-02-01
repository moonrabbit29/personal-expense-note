import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expense/data/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _transaction;
  TransactionList(this._transaction);
  @override
  Widget build(BuildContext context) {
    return this._transaction.isEmpty
        ? Column(
            children: <Widget>[
              Text("No Transaction Added Yet",
                  style: Theme.of(context).textTheme.headline6),
              Image.asset("assets/images/Waiting.jpg"),
            ],
          )
        : ListView.builder(
            itemBuilder: (ctx, index) {
              return Card(
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: Row(
                    children: <Widget>[
                      CircleAvatar(
                        radius: 30,
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: FittedBox(
                              child: Text(
                            '\$ ${_transaction[index].amount}',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          )),
                        ),
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            _transaction[index].title,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.orangeAccent,
                                fontSize: 24),
                          ),
                          Text(
                            DateFormat('yyyy-MM-dd')
                                .format(_transaction[index].date),
                            style: TextStyle(
                                color: Colors.orangeAccent, fontSize: 15),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
            itemCount: _transaction.length,
          );
  }
}
