import 'package:flutter/material.dart';
import 'package:project_cipherx/data/transaction_data.dart';
import 'package:project_cipherx/components/transaction_card.dart';
import 'package:project_cipherx/models/transaction_model.dart';
import 'package:provider/provider.dart';

class TransactionList extends StatelessWidget {
  const TransactionList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<TransactionData>(
      builder: (context, value, child) {
        List<Transaction> transactions = value.getAllTransactionList();
        transactions = transactions.reversed.toList();

        return ListView.builder(
          itemCount: transactions.length > 10
              ? 10 
              : transactions.length,
          itemBuilder: (context, index) => Dismissible(
            key: ValueKey(transactions[index]),
            background: Container(
              color: const Color.fromARGB(255, 255, 120, 120),
              margin: const EdgeInsets.symmetric(vertical: 6),
            ),
            onDismissed: (direction) {
              // Get the transaction to be removed
              final transactionToRemove = transactions[index];
              // Perform action when transaction is dismissed
              Provider.of<TransactionData>(context, listen: false)
                  .removeTransaction(transactionToRemove);
            },
            child: TransactionItem(transactions[index]),
          ),
        );
      },
    );
  }
}
