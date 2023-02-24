import 'package:flutter/material.dart';
import 'package:stock_app/models/new_product_model.dart';

class ProductDetailTopSection extends StatelessWidget {
  final NewProductModel product;
  const ProductDetailTopSection({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: double.maxFinite,
      color: Colors.blue,
      child: Padding(
        padding: const EdgeInsets.only(top: 12, left: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 40,
              child: Text(
                product.productName[0],
                style: const TextStyle(
                  fontSize: 40,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              product.productName,
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
