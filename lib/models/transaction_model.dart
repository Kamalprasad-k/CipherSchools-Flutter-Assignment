import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat.yMd();

const uuid = Uuid();

enum TransactionType {
  income,
  expense,
}

const transactionTypeIcons = {
  TransactionType.income: Icons.add,
  TransactionType.expense: Icons.remove,
};

enum Category {
  food,
  shopping,
  travel,
  subscription,
}

const categoryIcons = {
  Category.food: FontAwesomeIcons.burger,
  Category.shopping: FontAwesomeIcons.shoppingBag,
  Category.travel: FontAwesomeIcons.plane,
  Category.subscription: FontAwesomeIcons.dollarSign,
};

class Transaction {
  Transaction({
    required this.amount,
    required this.description,
    required this.category,
    required this.date,
    required this.type,
  }) : id = uuid.v4();

  final String id;
  final String description;
  final double amount;
  final DateTime date;
  final Enum category;
  final Enum type;

  String get formattedDate {
    return formatter.format(date);
  }
}
