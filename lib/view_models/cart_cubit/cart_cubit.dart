import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talabat_online/model/add_to_cart_model.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());
  int quantity = 1;
  void getCartItems() {
    emit(CartLeading());
    emit(CartLoaded(cartItems: dummyCart, subtotal: _subtotal));
  }

  void icrementCounter(String prudactId, [int? initialValue]) {
    if (initialValue != null) {
      quantity = initialValue;
    }
    quantity++;
    final index = dummyCart.indexWhere(
      (item) => item.prudact.id == prudactId,
    );
    dummyCart[index] = dummyCart[index].copyWith(
      quantity: quantity,
    );
    emit(QuantityCounterLoaded(value: quantity, prudactId: prudactId));
    emit(SubtotalUpdate(subtotal: _subtotal));
  }

  void decrementCounter(String prudactId, [int? initialValue]) {
    if (initialValue != null) {
      quantity = initialValue;
    }
    if (quantity > 1) {
      quantity--;
    }
    final index = dummyCart.indexWhere(
      (item) => item.prudact.id == prudactId,
    );
    dummyCart[index] = dummyCart[index].copyWith(
      quantity: quantity,
    );
    emit(QuantityCounterLoaded(value: quantity, prudactId: prudactId));
    emit(SubtotalUpdate(subtotal: _subtotal));
  }

  double get _subtotal => dummyCart.fold(0,
      (prevuseValue, item) => prevuseValue + (item.prudact.price * quantity));
}
