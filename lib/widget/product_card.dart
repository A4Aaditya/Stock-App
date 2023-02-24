import 'package:flutter/material.dart';
import 'package:stock_app/models/new_product_model.dart';
import 'package:stock_app/screens/product_detail.dart';

class ProductCard extends StatelessWidget {
  final List<NewProductModel> products;

  const ProductCard({
    super.key,
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return Card(
          child: ListTile(
            onTap: () => navigateToNewAddStock(product, context),
            leading: CircleAvatar(
              child: Text('${index + 1}'),
            ),
            title: Text(
              product.productName,
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
        );
      },
    );
  }

  void navigateToNewAddStock(
    NewProductModel product,
    context,
  ) {
    final route = MaterialPageRoute(
      builder: (context) => NewAddStockScreen(product: product),
    );
    Navigator.push(context, route);
  }
}
