import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_app/bloc/stock_bloc/stock_bloc.dart';
import 'package:stock_app/bloc/stock_bloc/stock_event.dart';
import 'package:stock_app/bloc/stock_bloc/stock_state.dart';
import 'package:stock_app/constants/snack_bar.dart';
import 'package:stock_app/models/new_product_model.dart';
import 'package:stock_app/screens/add_product_stock.dart';
import 'package:stock_app/widget/product_detail_top_section.dart';
import 'package:stock_app/widget/product_detail_widget.dart';

class NewAddStockScreen extends StatefulWidget {
  final NewProductModel product;
  const NewAddStockScreen({
    super.key,
    required this.product,
  });

  @override
  State<NewAddStockScreen> createState() => _NewAddStockScreenState();
}

class _NewAddStockScreenState extends State<NewAddStockScreen> {
  @override
  void initState() {
    super.initState();
    productNameController.text = widget.product.productName;
    fetchStockEntry();
  }

  final productNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final name = widget.product.productName;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text(name),
      ),
      body: Column(
        children: [
          ProductDetailTopSection(product: widget.product),
          BlocConsumer<StockBloc, StockState>(
            listener: (context, state) {
              if (state is StockErrorState) {
                final snackBar = customSnackBar(
                  text: state.message,
                  color: Colors.red,
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              } else if (state is StockAddedState) {
                final snackBar = customSnackBar(
                  text: 'Stock added successfully',
                  color: Colors.green,
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
            },
            builder: (context, state) {
              if (state is StockFetchedState) {
                return ProductDetailWidget(
                  stockEntries: state.stockModelEntry,
                  fetchStockEntry: fetchStockEntry,
                );
              }

              return const Text('NO Data to Show');
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: navigateToAddProductStock,
        label: const Icon(
          Icons.add,
          size: 40,
        ),
      ),
    );
  }

  InputDecoration inputDecoration(String labelText) {
    return InputDecoration(
      labelText: labelText,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  void navigateToAddProductStock() {
    final route = MaterialPageRoute(
      builder: (context) => AddProductStock(product: widget.product),
    );
    Navigator.push(context, route);
  }

  Future<void> fetchStockEntry() async {
    final bloc = context.read<StockBloc>();
    final event = StockFetchEvent(docId: widget.product.docId);
    bloc.add(event);
  }
}
