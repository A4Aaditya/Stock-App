import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_app/bloc/product_bloc/product_bloc.dart';
import 'package:stock_app/bloc/product_bloc/product_event.dart';
import 'package:stock_app/bloc/product_bloc/product_state.dart';
import 'package:stock_app/constants/snack_bar.dart';
import 'package:stock_app/widget/product_card.dart';

class NewHome extends StatefulWidget {
  const NewHome({super.key});

  @override
  State<NewHome> createState() => _NewHomeState();
}

class _NewHomeState extends State<NewHome> {
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  final productNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Home',
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0.0,
      ),
      body: SafeArea(
        child: BlocConsumer<ProductBloc, ProductState>(
          listener: (context, state) {
            if (state is ProductError) {
              final snackBar =
                  customSnackBar(text: state.message, color: Colors.red);
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            } else if (state is ProductAddedState) {
              final snackBar =
                  customSnackBar(text: 'Product Created', color: Colors.green);
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
          },
          builder: (context, state) {
            if (state is ProductLoadedState) {
              return ProductCard(
                products: state.products,
              );
            } else if (state is ProductLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return const SizedBox();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: createProduct,
        label: const Text('Create Product'),
        backgroundColor: Colors.indigo,
      ),
    );
  }

  /// fetch the product
  Future<void> fetchData() async {
    final bloc = context.read<ProductBloc>();
    final event = FetchNewProductEvent();
    bloc.add(event);
  }

  /// Show dialog of create product
  Future<void> createProduct() async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(' Add New Product'),
          content: TextFormField(
            controller: productNameController,
            decoration: inputDecoration(),
          ),
          actions: [
            ElevatedButton(
              onPressed: create,
              child: const Text('Create'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  /// Input Decoration
  InputDecoration inputDecoration() {
    return InputDecoration(
      labelText: 'Product Name',
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  /// On create is pressed
  Future<void> create() async {
    final bloc = context.read<ProductBloc>();
    final event = AddNewProductEvent(product: data);
    bloc.add(event);
    Navigator.pop(context);
  }

  /// get map of product
  Map<String, dynamic> get data {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    final productName = productNameController.text.trim();
    return {
      'product_name': productName,
      'user_id': userId,
    };
  }
}
