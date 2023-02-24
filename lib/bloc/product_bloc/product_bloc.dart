import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_app/bloc/product_bloc/product_event.dart';
import 'package:stock_app/bloc/product_bloc/product_state.dart';
import 'package:stock_app/repository/product_repository.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final userId = FirebaseAuth.instance.currentUser?.uid;
  final ProductRepository _repository;
  ProductBloc(this._repository) : super(ProductInitial()) {
    on<AddNewProductEvent>(_addProduct);
    on<FetchNewProductEvent>(_fetchProduct);
  }

  FutureOr<void> _addProduct(
    AddNewProductEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductLoading());
    try {
      final response = await _repository.addProduct(event.product);
      if (response == true) {
        add(FetchNewProductEvent());
        emit(ProductAddedState());
      } else {
        emit(ProductError(
            message: 'Unable to add product ! Something went wrong'));
      }
    } catch (e) {
      emit(ProductError(message: e.toString()));
    }
  }

  FutureOr<void> _fetchProduct(
    FetchNewProductEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductLoading());
    try {
      final response = await _repository.getProduct(userId);
      if (response.isNotEmpty) {
        emit(ProductLoadedState(products: response));
      } else {
        emit(ProductError(
            message: 'Unable to loadProduct ! Something went wrong'));
      }
    } catch (e) {
      emit(ProductError(message: e.toString()));
    }
  }
}
