import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mercanova/infrastructure/database.dart';
import 'package:mercanova/infrastructure/models/product.dart';

part 'shopping_cart_state.dart';

class ShoppingCartCubit extends Cubit<ShoppingCartState> {
  ShoppingCartCubit() : super(ShoppingCartState());

  List<Product> get products => state.products;
  double get totalPrice => (state.products.isEmpty)
    ? 0
    : state.products.map((product) => product.price).reduce((a,b) => a+b);

/*
  void addProduct(Product newProduct) {
    List<Product> copyOfProducts = List.from(state.products);
    if(copyOfProducts.any((product) => product.id == newProduct.id)) return;

    copyOfProducts.add(newProduct);

    emit(
      ShoppingCartState(
        products: copyOfProducts
      )
    );
  }
*/
  void addProduct(Product newProduct) { 
    emit(
      ShoppingCartState(
        products: database
      )
    );
  }
}