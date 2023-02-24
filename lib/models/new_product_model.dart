class NewProductModel {
  final String productName;
  final String? userId;
  final String docId;

  NewProductModel({
    required this.productName,
    required this.docId,
    required this.userId,
  });

  factory NewProductModel.fromMap(Map<String, dynamic> json, String docId) {
    return NewProductModel(
      productName: json['product_name'],
      userId: json['user_id'],
      docId: docId,
    );
  }
}
