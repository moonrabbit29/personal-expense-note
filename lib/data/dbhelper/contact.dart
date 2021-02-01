import 'package:intl/intl.dart';

import '../transaction.dart';

class Contact {
  Transaction _transaction;

  Contact(String id, String title, double amount, DateTime date) {
    this._transaction =
        Transaction(id: id, title: title, amount: amount, date: date);
  }

  Contact.fromMap(Map<String, dynamic> map) {
    this._transaction = Transaction(
        id: map['id'],
        title: map['title'],
        amount: double.parse(map['amount']),
        date: DateTime.parse(map['date']));
  }

  set transaction(Transaction transaction) {
    this._transaction = transaction;
  }

  Transaction get transaction {
    return this._transaction;
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();
    map['id'] = transaction.id;
    map['title'] = transaction.title;
    map['amount'] = transaction.amount;
    map['date'] = DateFormat('yyyy-MM-dd HH:mm:ss').format(transaction.date);
    return map;
  }
}
