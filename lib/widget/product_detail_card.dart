import 'package:flutter/material.dart';
import 'package:stock_app/models/stock_entry_model.dart';

class ProductDetailCard extends StatelessWidget {
  final StockEntryModel stockEntry;
  const ProductDetailCard({
    super.key,
    required this.stockEntry,
  });

  @override
  Widget build(BuildContext context) {
    final buy = stockEntry.quantity[0] == '+';
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: buy ? Colors.blue : Colors.red,
          child: buy
              ? const Icon(
                  Icons.download,
                  color: Colors.white,
                )
              : const Icon(
                  Icons.upload,
                  color: Colors.white,
                ),
        ),
        title: Text(
          stockEntry.quantity.toString(),
        ),
        trailing: Text(
          stockEntry.price.toString(),
          style: TextStyle(
            color: buy ? Colors.red : Colors.blue,
          ),
        ),
      ),
    );
  }
}
