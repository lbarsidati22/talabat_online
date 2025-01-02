part of 'cart_cubit.dart';

sealed class CartState {}

final class CartInitial extends CartState {}

final class CartLeading extends CartState {}

final class CartLoaded extends CartState {
  final List<AddToCartModel> cartItems;
  final double subtotal;

  CartLoaded({
    required this.cartItems,
    required this.subtotal,
  });
}

final class CartError extends CartState {}

final class SubtotalUpdate extends CartState {
  final double subtotal;

  SubtotalUpdate({
    required this.subtotal,
  });
}

final class QuantityCounterLoaded extends CartState {
  final int value;
  final String prudactId;
  QuantityCounterLoaded({
    required this.value,
    required this.prudactId,
  });
}
