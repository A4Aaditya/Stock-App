class NotificationModel {
  final String productName;
  final String userId;
  final String quantity;
  final num price;
  NotificationModel({
    required this.productName,
    required this.userId,
    required this.quantity,
    required this.price,
  });
  factory NotificationModel.fromMap(Map<String, dynamic> json) {
    return NotificationModel(
      productName: json['product_name'],
      userId: json['user_id'],
      quantity: json['quantity'],
      price: json['price'],
    );
  }
}
