import 'package:stock_app/models/stock_entry_model.dart';

abstract class StockState {}

class StockInitialState extends StockState {}

class StockLoadingState extends StockState {}

class StockErrorState extends StockState {
  StockErrorState({required this.message});
  final String message;
}

class StockAddedState extends StockState {}

class StockFetchedState extends StockState {
  StockFetchedState({required this.stockModelEntry});
  final List<StockEntryModel> stockModelEntry;
}
