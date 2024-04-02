import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:contactapp/product/model/product_model.dart';
import 'package:contactapp/product/service/product_service.dart';
import 'package:equatable/equatable.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductInitial()) {
    on<ProductGetAllEvent>((event, emit) async {
      try {
        emit(ProductLoading());
        final List<Product>? products = await getAllProducts();
        emit(ProductSuccess(products: products!));
      } catch (e) {
        log("Product Bloc Error : $e");
        emit(ProductFailed());
      }
    });
  }
}
