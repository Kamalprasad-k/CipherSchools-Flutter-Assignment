import 'package:hive_flutter/adapters.dart';
import 'package:project_cipherx/models/transaction_model.dart';

class HiveDataBase {
  // Reference our box
  final _myBox = Hive.box('transactions_database');

  // Write data
  void saveData(List<Transaction> allTransactions) {
    List<List<dynamic>> allTransactionsFormatted = [];

    for (var transaction in allTransactions) {
      // Converting each transaction into storable types
      List<dynamic> transactionFormatted = [
        transaction.category.index, // Storing index of enum value
        transaction.amount,
        transaction.description,
        transaction.date,
        transaction.type.index, // Storing index of enum value
      ];
      allTransactionsFormatted.add(transactionFormatted);
    }

    // Storing in db
    _myBox.put("ALL_TRANSACTIONS", allTransactionsFormatted);
  }

  // Read data
  List<Transaction> readData() {
    List savedTransactions = _myBox.get("ALL_TRANSACTIONS") ?? [];
    List<Transaction> allTransactions = [];

    for (int i = 0; i < savedTransactions.length; i++) {
      // Collecting individual data
      int categoryIndex = savedTransactions[i][0];
      double amount = savedTransactions[i][1];
      String description = savedTransactions[i][2];
      DateTime date = savedTransactions[i][3];
      int typeIndex = savedTransactions[i][4];

      // Creating transaction
      Transaction transaction = Transaction(
        amount: amount,
        description: description,
        category: Category.values[categoryIndex], // Retrieving enum value from index
        date: date,
        type: TransactionType.values[typeIndex], // Retrieving enum value from index
      );

      // Adding all transaction to overall list of transactions
      allTransactions.add(transaction);
    }
    return allTransactions;
  }
}
