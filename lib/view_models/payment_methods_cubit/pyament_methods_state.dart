part of 'pyament_methods_cubit.dart';

sealed class PyamentMethodsState {}

final class PyamentMethodsInitial extends PyamentMethodsState {}

final class FetchingPaymentMethods extends PyamentMethodsState {}

final class FetchedPaymentMethods extends PyamentMethodsState {
  final List<PaymentCartModel> paymantCarts;

  FetchedPaymentMethods(this.paymantCarts);
}

final class FetchPaymentMethodsError extends PyamentMethodsState {
  final String message;

  FetchPaymentMethodsError(this.message);
}

final class AddNewCardLeading extends PyamentMethodsState {}

final class AddNewCardLoaded extends PyamentMethodsState {}

final class AddNewCardError extends PyamentMethodsState {
  final String message;

  AddNewCardError(this.message);
}

final class PaymentMethodsChosen extends PyamentMethodsState {
  final PaymentCartModel chosenPaymnt;

  PaymentMethodsChosen({required this.chosenPaymnt});
}
