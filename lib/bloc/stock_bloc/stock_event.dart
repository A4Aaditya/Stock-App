abstract class StockEvent {}

class StockFetchEvent extends StockEvent {
  StockFetchEvent({required this.docId});
  final String docId;
}

class StockAddEvent extends StockEvent {
  StockAddEvent({
    required this.stockData,
    required this.docId,
  });
  final Map<String, dynamic> stockData;
  final String docId;
}
