import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talabat_online/model/add_to_cart_model.dart';
import 'package:talabat_online/model/payment_cart_model.dart';
import 'package:talabat_online/view_models/checkout_cubit/checkout_state.dart';

class CheckoutCubit extends Cubit<CheckoutState> {
  CheckoutCubit() : super(CheckoutInitial());
  void getCartItems() {
    emit(CheckoutLeading());
    final cartItems = dummyCart;
    final subtotal = cartItems.fold(
        0.0,
        (previousValue, element) =>
            previousValue + (element.prudact.price * element.quantity));
    final numOfPrudact = cartItems.fold(
        0, (previouseValue, element) => previouseValue + element.quantity);
    final PaymentCartModel chosenPaymentCart = dummyPaymentCard.firstWhere(
        (paymentCart) => paymentCart.isChosen == true,
        orElse: () => dummyPaymentCard.first);
    emit(CheckoutLoaded(
      chosenPaymentCarts: chosenPaymentCart,
      cartItem: cartItems,
      totalAmount: subtotal + 10,
      numOfPrudact: numOfPrudact,
    ));
  }
}
