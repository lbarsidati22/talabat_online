import 'package:talabat_online/model/add_to_cart_model.dart';

sealed class CheckoutState {}

final class CheckoutInitial extends CheckoutState {}

final class CheckoutLoaded extends CheckoutState {
  final List<AddToCartModel> cartItem;
  final double totalAmount;
  final int numOfPrudact;

  CheckoutLoaded({
    required this.cartItem,
    required this.totalAmount,
    required this.numOfPrudact,
  });
}

final class CheckoutError extends CheckoutState {
  final String message;

  CheckoutError({
    required this.message,
  });
}

final class CheckoutLeading extends CheckoutState {}
