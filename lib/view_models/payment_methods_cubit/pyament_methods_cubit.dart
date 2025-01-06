import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talabat_online/model/payment_cart_model.dart';

part 'pyament_methods_state.dart';

class PyamentMethodsCubit extends Cubit<PyamentMethodsState> {
  PyamentMethodsCubit() : super(PyamentMethodsInitial());

  void addNewCard(
    String cardNumber,
    String cardHolderName,
    String expiryDate,
    String cvv,
  ) {
    emit(AddNewCardLeading());
    final newCart = PaymentCartModel(
      id: DateTime.now().toIso8601String(),
      cardNumber: cardNumber,
      cardHolderName: cardHolderName,
      expiryDate: expiryDate,
      cvv: cvv,
    );
    Future.delayed((Duration(seconds: 1)), () {
      dummyPaymentCard.add(newCart);
      emit(AddNewCardLoaded());
    });
  }

  void fetchPaymentMethods() {
    emit(FetchingPaymentMethods());
    Future.delayed(Duration(seconds: 1), () {
      if (dummyPaymentCard.isNotEmpty) {
        emit(FetchedPaymentMethods(dummyPaymentCard));
        final chosenPaymentMethod = dummyPaymentCard.firstWhere(
            (paymantCart) => paymantCart.isChosen == true,
            orElse: () => dummyPaymentCard.first);
        emit(PaymentMethodsChosen(chosenPaymnt: chosenPaymentMethod));
      } else {
        emit(FetchPaymentMethodsError('No Paymant Methods Found!'));
      }
    });
  }
}
