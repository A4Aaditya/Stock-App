import 'package:flutter/material.dart';
import 'package:stock_app/models/stock_entry_model.dart';
import 'package:stock_app/widget/product_detail_card.dart';

class ProductDetailWidget extends StatelessWidget {
  final List<StockEntryModel> stockEntries;
  final Function() fetchStockEntry;

  const ProductDetailWidget(
      {super.key, required this.stockEntries, required this.fetchStockEntry});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: RefreshIndicator(
        onRefresh: () {
          return fetchStockEntry();
        },
        child: ListView.builder(
          itemCount: stockEntries.length,
          itemBuilder: (context, index) {
            final stockEntry = stockEntries[index];

            return ProductDetailCard(stockEntry: stockEntry);
          },
        ),
      ),
    );
  }
}
