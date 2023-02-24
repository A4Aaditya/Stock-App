import 'package:stock_app/models/new_product_model.dart';

abstract class ProductState {}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductError extends ProductState {
  ProductError({required this.message});
  final String message;
}

class ProductAddedState extends ProductState {}

class ProductLoadedState extends ProductState {
  ProductLoadedState({required this.products});
  final List<NewProductModel> products;
}
