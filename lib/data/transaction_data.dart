import 'package:flutter/material.dart';
import 'package:project_cipherx/data/hive_database.dart';
import 'package:project_cipherx/models/transaction_model.dart';

class TransactionData extends ChangeNotifier {
// List of All transaction
  List<Transaction> overallTransactionList = [];

// get transaction list
  List<Transaction> getAllTransactionList() {
    return overallTransactionList;
  }

  //show data to display
  final db = HiveDataBase();
  void showData() {
    if (db.readData().isNotEmpty) {
      overallTransactionList = db.readData();
    }
  }

//add new transaction
  void addNewTransaction(Transaction newTransaction) {
    overallTransactionList.add(newTransaction);
    notifyListeners();
    db.saveData(overallTransactionList);
  }

  //delete transaction
  void removeTransaction(Transaction transaction) {
    overallTransactionList.remove(transaction);
    notifyListeners();
    db.saveData(overallTransactionList);
  }
}
