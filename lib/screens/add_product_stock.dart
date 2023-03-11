import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:stock_app/bloc/stock_bloc/stock_bloc.dart';
import 'package:stock_app/bloc/stock_bloc/stock_event.dart';
import 'package:stock_app/bloc/stock_bloc/stock_state.dart';
import 'package:stock_app/models/new_product_model.dart';
import 'package:stock_app/provider/theme_provider.dart';

class AddProductStock extends StatefulWidget {
  final NewProductModel product;

  const AddProductStock({
    super.key,
    required this.product,
  });

  @override
  State<AddProductStock> createState() => _AddProductStockState();
}

class _AddProductStockState extends State<AddProductStock> {
  final priceController = TextEditingController();
  final quantityController = TextEditingController();
  String? radioGroupValue;
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        title: const Text('Add Stock'),
        elevation: 0.0,
      ),
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(8),
          width: double.maxFinite,
          height: 350,
          decoration: BoxDecoration(
            color: provider.isDarkMode ? Colors.black : Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Row(
                children: [
                  const Text(
                    'Type',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Radio(
                    value: '+',
                    groupValue: radioGroupValue,
                    onChanged: (value) {
                      setState(() {
                        radioGroupValue = value;
                      });
                    },
                  ),
                  const Text(
                    'BUY',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Radio(
                    value: '-',
                    groupValue: radioGroupValue,
                    onChanged: (value) {
                      setState(() {
                        radioGroupValue = value;
                      });
                    },
                  ),
                  const Text(
                    'SELL',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              headerText('Quantity'),
              const SizedBox(height: 10),
              TextFormField(
                controller: quantityController,
                keyboardType: TextInputType.number,
                decoration: inputDecoration(),
              ),
              const SizedBox(height: 10),
              headerText('Price'),
              const SizedBox(height: 10),
              TextFormField(
                controller: priceController,
                keyboardType: TextInputType.number,
                decoration: inputDecoration(),
              ),
              const SizedBox(height: 10),
              BlocConsumer<StockBloc, StockState>(
                listener: (context, state) {
                  if (state is StockAddedState) {}
                },
                builder: (context, state) {
                  if (state is StockLoadingState) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return ElevatedButton(
                    onPressed: savePressed,
                    child: const Text('Save'),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration inputDecoration() {
    return InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  /// stockAddEvent
  void savePressed() {
    final bloc = context.read<StockBloc>();
    final event = StockAddEvent(stockData: data, docId: widget.product.docId);
    bloc.add(event);
    Navigator.pop(context);
  }

  /// add notification for stock
  void addNotification() {}

  /// get add stock
  Map<String, dynamic> get data {
    final price = double.parse(priceController.text);
    final qunatity = double.parse(quantityController.text);
    final docId = widget.product.docId;
    return {
      'price': price,
      'quantity': '$radioGroupValue  $qunatity',
      'doc_id': docId,
    };
  }

  /// get notification body
  Map<String, dynamic> get notificationData {
    final price = double.parse(priceController.text);
    final qunatity = double.parse(quantityController.text);
    final userId = FirebaseAuth.instance.currentUser?.uid;

    return {
      'product_name': widget.product.productName,
      'user_id': userId,
      'price': price,
      'quantity': '$radioGroupValue  $qunatity',
    };
  }

  Text headerText(String headerName) {
    return Text(
      headerName,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
