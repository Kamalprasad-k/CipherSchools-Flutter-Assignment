import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:project_cipherx/data/transaction_data.dart';
import 'package:project_cipherx/models/transaction_model.dart';
import 'package:provider/provider.dart';

class AddIncomeSheet extends StatefulWidget {
  const AddIncomeSheet({super.key});

  @override
  State<AddIncomeSheet> createState() => _AddIncomeSheetState();
}

class _AddIncomeSheetState extends State<AddIncomeSheet> {
  DateTime? _selectedDate;
  Category? _selectedCategory;
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _incomeController = TextEditingController();

  void datePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(
      now.day,
      now.month,
      now.year - 1,
    );
    final pickedDate = await showDatePicker(
      context: context,
      firstDate: firstDate,
      initialDate: now,
      lastDate: now,
    );
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void saveIncome() {
    //validate income details
    final enteredAmount = double.tryParse(_incomeController.text);
    final invalidAmount = enteredAmount == null || enteredAmount <= 0;

    if (_descriptionController.text.trim().isEmpty ||
        invalidAmount ||
        _selectedDate == null ||
        _selectedCategory == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Invalid Input'),
          content: const Text(
            'Please make sure a valid title, amount, date and category were entered ',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text('Okay'),
            )
          ],
        ),
      );
      return;
    }
    // create transaction
    Transaction newIncome = Transaction(
        amount: enteredAmount,
        category: _selectedCategory!,
        description: _descriptionController.text,
        date: _selectedDate!,
        type: TransactionType.income);
    // add the new income
    Provider.of<TransactionData>(context, listen: false)
        .addNewTransaction(newIncome);

    Navigator.pop(context);
  }

  void clear() {
    _descriptionController.clear();
    _incomeController.clear();
  }

  @override
  Widget build(BuildContext context) {
    List<Category> categories = Category.values;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Income',
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        centerTitle: true,
        foregroundColor: Colors.white,
        flexibleSpace: FlexibleSpaceBar(
          background: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.deepPurple, Colors.white],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(260),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Enter Amount',
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 30.0,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              TextField(
                textAlign: TextAlign.center,
                controller: _incomeController,
                decoration: const InputDecoration(
                  hintText: '₹0',
                  hintStyle: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  border: InputBorder.none,
                ),
                keyboardType: TextInputType.number,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30.0,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                height: 100,
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const SizedBox(
                height: 14,
              ),
              // Dropdown button for selecting category
              DropdownButtonFormField<Category>(
                decoration: const InputDecoration(
                  labelText: 'Select Category',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                ),
                value: _selectedCategory,
                onChanged: (newValue) {
                  setState(() {
                    _selectedCategory = newValue;
                  });
                },
                items: categories.skip(categories.length - 4).map((category) {
                  String categoryName = category.toString().split('.').last;
                  String capitalizedCategoryName =
                      categoryName.substring(0, 1).toUpperCase() +
                          categoryName.substring(1);
                  return DropdownMenuItem<Category>(
                    value: category,
                    child: Text(
                      capitalizedCategoryName,
                      style: GoogleFonts.poppins(),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 26),
              // Text field for short description
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 26),
              // Date picker
              GestureDetector(
                onTap: datePicker,
                child: Container(
                  height: 60,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _selectedDate == null
                              ? 'Select date'
                              : DateFormat('dd/MM/yyyy').format(_selectedDate!),
                          style: const TextStyle(fontSize: 16),
                        ),
                        const Icon(
                          Icons.calendar_today,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                onPressed: saveIncome,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple, // Background color
                  padding: const EdgeInsets.symmetric(
                      vertical: 20, horizontal: 140), // Button padding
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(20), // Button border radius
                  ),
                ),
                child: const Text(
                  'Continue',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
