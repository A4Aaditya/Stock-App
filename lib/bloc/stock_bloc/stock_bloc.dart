import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_app/bloc/stock_bloc/stock_event.dart';
import 'package:stock_app/bloc/stock_bloc/stock_state.dart';
import 'package:stock_app/repository/stock_entry_repository.dart';

class StockBloc extends Bloc<StockEvent, StockState> {
  final StockEntryRepository _repository;
  StockBloc(this._repository) : super(StockInitialState()) {
    on<StockFetchEvent>(_fetchStock);
    on<StockAddEvent>(_addStock);
  }

  FutureOr<void> _fetchStock(
    StockFetchEvent event,
    Emitter<StockState> emit,
  ) async {
    emit(StockLoadingState());
    try {
      final response = await _repository.getStockEntry(event.docId);
      if (response.isNotEmpty) {
        emit(StockFetchedState(stockModelEntry: response));
      } else {
        emit(StockErrorState(message: 'Something went wrong'));
      }
    } catch (e) {
      emit(StockErrorState(message: e.toString()));
    }
  }

  FutureOr<void> _addStock(
    StockAddEvent event,
    Emitter<StockState> emit,
  ) async {
    emit(StockLoadingState());
    try {
      final response = await _repository.addStockEntry(event.stockData);
      if (response == true) {
        add(StockFetchEvent(docId: event.docId));
        emit(StockAddedState());
      } else {
        emit(StockErrorState(message: 'Something went wrong'));
      }
    } catch (e) {
      emit(StockErrorState(message: e.toString()));
    }
  }
}
