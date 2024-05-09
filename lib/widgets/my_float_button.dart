import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:project_cipherx/pages/add_expense_page.dart';
import 'package:project_cipherx/pages/add_income_page.dart';

class MyFloatingButton extends StatelessWidget {
  const MyFloatingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SpeedDial(
        backgroundColor: Colors.deepPurple,
        activeIcon: Icons.close,
        elevation: 0,
        spacing: 10,
        iconTheme: const IconThemeData(color: Colors.white),
        childMargin: const EdgeInsets.all(10),
        children: [
          SpeedDialChild(
            elevation: 1,
            child: Icon(
              FontAwesomeIcons.moneyBillAlt,
              color: Colors.red.shade400,
            ),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddExpenseSheet(),
              ),
            ),
          ),
          SpeedDialChild(
            elevation: 1,
            child: Icon(
              FontAwesomeIcons.moneyBill,
              color: Colors.green.shade400,
            ),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddIncomeSheet(),
              ),
            ),
          ),
        ],
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      );
  }
}