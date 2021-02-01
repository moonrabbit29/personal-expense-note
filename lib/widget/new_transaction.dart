import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function _addTransaction;
  NewTransaction(this._addTransaction);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime _selectedDate;

  void submitData() {
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);
    if(amountController.text.isEmpty) return;

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) return;
    widget._addTransaction(enteredTitle, enteredAmount,_selectedDate);
    Navigator.of(context).pop();
  }

  void presentDatePicker(){
    showDatePicker(
      context: context, 
      initialDate: DateTime.now(), 
      firstDate:DateTime(2021), 
      lastDate: DateTime.now()
      ).then((pickedDate){
        if(pickedDate==null){
          return;
        }else{
          setState(() {
            _selectedDate = pickedDate;
          });
          
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              autofocus: true,
              controller: titleController,
              onSubmitted: (_) => submitData,
              // onChanged: (value) {
              //   titleInput = value;
              // },
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              //   onChanged: (val) => amountInput = val,
              //   autofocus: true,
              controller: amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) {
                submitData();
              },
            ),
            Container(
              height: 70,
              child: Row(
                children: <Widget>[
                  Text(_selectedDate==null?"No Date Chose!":DateFormat.yMd().format(_selectedDate)),
                  FlatButton(
                      onPressed: (){
                        presentDatePicker();
                      },
                      child: Text('Choose Date',style: TextStyle(
                        fontWeight: FontWeight.bold),),
                      textColor: Colors.red)
                ],
              ),
            ),
            RaisedButton(
              child: Text('Add Transaction',style: TextStyle(fontWeight: FontWeight.bold),),
              textColor: Colors.black,
              onPressed: submitData,
              color: Colors.white,
              
            )
          ],
        ),
      ),
    );
  }
}
