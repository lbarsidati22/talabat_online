import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talabat_online/model/payment_cart_model.dart';

part 'pyament_methods_state.dart';

class PyamentMethodsCubit extends Cubit<PyamentMethodsState> {
  PyamentMethodsCubit() : super(PyamentMethodsInitial());
  String selectedPaymentID = dummyPaymentCard.first.id;
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

  void changPaymentMethods(String id) {
    selectedPaymentID = id;
    var tempChosenPaymentMethod = dummyPaymentCard
        .firstWhere((paymentCart) => paymentCart.id == selectedPaymentID);
    emit(PaymentMethodsChosen(chosenPaymnt: tempChosenPaymentMethod));
  }

  void confirmPaymentMethods() {
    emit(ConfirmPaymentLeading());
    Future.delayed(Duration(seconds: 1), () {
      var chosenPaymentMethods = dummyPaymentCard
          .firstWhere((paymentCart) => paymentCart.id == selectedPaymentID);
      var previousPaymentMethod = dummyPaymentCard.firstWhere(
          (prevouseCart) => prevouseCart.isChosen == true,
          orElse: () => dummyPaymentCard.first);
      previousPaymentMethod = previousPaymentMethod.copyWith(isChosen: false);
      chosenPaymentMethods = chosenPaymentMethods.copyWith(isChosen: true);
      final previouseIndex = dummyPaymentCard.indexWhere(
          (paymentIndex) => paymentIndex.id == previousPaymentMethod.id);
      final chosenIndex = dummyPaymentCard.indexWhere(
          (paymentIndex) => paymentIndex.id == chosenPaymentMethods.id);
      dummyPaymentCard[previouseIndex] = previousPaymentMethod;
      dummyPaymentCard[chosenIndex] = chosenPaymentMethods;
      emit(ConfirmPaymentLoaded());
    });
  }
}
