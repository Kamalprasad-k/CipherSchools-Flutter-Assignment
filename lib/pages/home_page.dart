import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_cipherx/data/transaction_data.dart';
import 'package:project_cipherx/models/transaction_model.dart';
import 'package:project_cipherx/pages/account_page.dart';
import 'package:project_cipherx/pages/transaction_page.dart';
import 'package:project_cipherx/widgets/my_float_button.dart';
import 'package:project_cipherx/components/total_expense.dart';
import 'package:project_cipherx/components/total_income.dart';
import 'package:project_cipherx/components/transaction_list.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void navigatorbar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();

    // Show data on startup
    Provider.of<TransactionData>(context, listen: false).showData();
  }

  double getTotalExpense(List<Transaction> transactions) {
    double totalExpense = 0;
    for (var transaction in transactions) {
      if (transaction.type == TransactionType.expense) {
        totalExpense += transaction.amount;
      }
    }
    return totalExpense;
  }

  double getTotalIncome(List<Transaction> transactions) {
    double totalIncome = 0;
    for (var transaction in transactions) {
      if (transaction.type == TransactionType.income) {
        totalIncome += transaction.amount;
      }
    }
    return totalIncome;
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).colorScheme;

    double initialBalance = 100000; // Initial balance

    var transactionData = Provider.of<TransactionData>(context);

    List<Transaction> addedTransactions =
        transactionData.getAllTransactionList();

    // Calculate total expense
    double totalExpense = getTotalExpense(addedTransactions);

    // Calculate total income
    double totalIncome = getTotalIncome(addedTransactions);

    // Calculate account balance
    double accountBalance = initialBalance + totalIncome - totalExpense;

    Widget mainContent = Center(
      child: Column(
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
    if (addedTransactions.isNotEmpty) {
      setState(() {
        mainContent = const TransactionList();
      });
    }

    Widget activeScreen = const SizedBox(); // Initialize with an empty widget

    if (_selectedIndex == 0) {
      activeScreen = mainContent; // Show main content on Home screen
    } else if (_selectedIndex == 1) {
      activeScreen = const TransactionPage(); // Transaction screen
    } else if (_selectedIndex == 2) {
      activeScreen = const AccountPage(); // Transaction screen
    }

    return Scaffold(
      appBar: _selectedIndex == 0
          ? AppBar(
              leading: Padding(
                padding: const EdgeInsets.all(6.0),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: theme.primary,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AccountPage(),
                          ),
                        );
                      },
                      child: CircleAvatar(
                        backgroundColor: Colors.white70,
                        child: Icon(
                          Icons.person,
                          size: 32,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              actions: const [
                Align(
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
                    child: Icon(
                      Icons.notifications_rounded,
                      color: Colors.deepPurple,
                      size: 30,
                    ),
                  ),
                ),
              ],
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [const Color(0xFFFBC5AC), theme.background],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
              ),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(320),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Account Balance',
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      '₹${accountBalance.toStringAsFixed(0)}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 38.0,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IncomeContainer(
                            totalIncome: totalIncome,
                          ),
                          const SizedBox(
                            width: 2,
                          ),
                          ExpenseContainer(totalExpense: totalExpense),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Recent Transactions',
                            style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const TransactionPage(),
                                ),
                              );
                            },
                            style: const ButtonStyle(
                              shadowColor: MaterialStatePropertyAll(
                                Colors.transparent,
                              ),
                            ),
                            child: const Text('See All'),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          : null,
      floatingActionButton: const MyFloatingButton(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: navigatorbar,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_filled,
              size: 30,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              FontAwesomeIcons.exchange,
            ),
            label: 'Transactions',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              size: 30,
            ),
            label: 'Account',
          ),
        ],
      ),
      body: activeScreen,
    );
  }
}
