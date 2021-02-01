import 'package:flutter/material.dart';
import 'package:personal_expense/data/dbhelper/contact.dart';
import 'package:personal_expense/data/dbhelper/dbhelper.dart';
import 'data/dbhelper/crud.dart';
import './widget/new_transaction.dart';
import './widget/transactionlist.dart';
import './data/transaction.dart';
import './widget/chart.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: Colors.black,
          fontFamily: 'OpenSans',
          appBarTheme: AppBarTheme(
            textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                    fontFamily: 'ProductSans',
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
          )),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transaction = [
    //   Transaction(
    //        id: 't1', title: 'New Shoes', amount: 2000, date: DateTime.now()),
    //    Transaction(
    //        id: 't2', title: 'New Clothes', amount: 1000, date: DateTime.now()),
  ];

  CRUD dbHelper = CRUD();
  Future<List<Contact>> future;

  List<Transaction> get _recentTransaction {
    return _transaction.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  Future<List<Transaction>> get _allTransaction async {
    List<Transaction> ex = List<Transaction>();
    List<Contact> list = await updateListView();
    _transaction.clear();
    list.forEach((e) {
      setState(() {
        _transaction.add(e.transaction);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _allTransaction;
  }

  Future<List<Contact>> updateListView() async {
    setState(() {
      future = dbHelper.getContactList();
    });
    return await future;
  }

  void _addTransaction(String title, double amount, DateTime chosenDate) async {
    String id = DateTime.now().toString();
    Transaction target =
        Transaction(id: id, title: title, amount: amount, date: chosenDate);
    var contact = Contact(id, title, amount, chosenDate);
    if (contact != null) {
      int result = await dbHelper.insert(contact);
      if (result > 0) {
        print("duh");
        _allTransaction;
      }
    }
    // setState(() {
    //   _transaction.add(target
    //       );
    // });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            child: NewTransaction(_addTransaction),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: Text("Personal Expense App"),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () {
            _startAddNewTransaction(context);
          },
        )
      ],
    );
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              width: double.infinity,
              child: Card(
                child: Container(
                  width: double.infinity,
                  color: Colors.black,
                  child: Text("Chart"),
                ),
                elevation: 5,
              ),
            ),
            Container(
                height: (MediaQuery.of(context).size.height -
                        appBar.preferredSize.height -
                        MediaQuery.of(context).padding.top) *
                    0.3,
                child: Chart(_recentTransaction)),
            Container(
                height: (MediaQuery.of(context).size.height -
                        appBar.preferredSize.height -
                        MediaQuery.of(context).padding.top) *
                    0.7,
                child: TransactionList(_transaction)),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _startAddNewTransaction(context);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
