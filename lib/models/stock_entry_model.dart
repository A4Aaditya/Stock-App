class StockEntryModel {
  StockEntryModel({
    required this.docId,
    required this.price,
    required this.productId,
    required this.quantity,
  });
  final String productId;
  final String docId;
  final num price;
  final String quantity;

  factory StockEntryModel.fromMap(Map<String, dynamic> json, String docId) {
    return StockEntryModel(
      docId: docId,
      price: json['price'],
      productId: json['doc_id'],
      quantity: json['quantity'],
    );
  }
}
