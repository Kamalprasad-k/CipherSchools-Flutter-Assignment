import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_cipherx/components/transaction_card.dart';
import 'package:project_cipherx/data/transaction_data.dart';
import 'package:project_cipherx/models/transaction_model.dart';
import 'package:provider/provider.dart';

class TransactionPage extends StatefulWidget {
  const TransactionPage({super.key});

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'All Transactions',
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
        ),
      ),
      body: Consumer<TransactionData>(
        builder: (context, value, child) {
          List<Transaction> transactions = value.getAllTransactionList();
          transactions = transactions.reversed.toList(); 

          if (transactions.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 60,
                  ),
                  Image.asset(
                    'lib/assets/images/no transaction.png',
                    height: 200,
                    width: 200,
                  ),
                  Text(
                    'No transactions found! Add some...',
                    style: GoogleFonts.poppins(),
                  )
                ],
              ),
            );
          }

          return ListView.builder(
            itemCount: transactions.length,
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
      ),
    );
  }
}
