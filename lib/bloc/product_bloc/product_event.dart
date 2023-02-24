abstract class ProductEvent {}

class AddNewProductEvent extends ProductEvent {
  AddNewProductEvent({required this.product});
  final Map<String, dynamic> product;
}

class FetchNewProductEvent extends ProductEvent {}
