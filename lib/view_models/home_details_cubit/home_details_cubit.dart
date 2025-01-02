import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:talabat_online/model/add_to_cart_model.dart';
import 'package:talabat_online/model/prudact_item_model.dart';

part 'home_details_state.dart';

class PrudactDetailsCubit extends Cubit<PrudactDetailsState> {
  PrudactDetailsCubit() : super(PrudactDetailsInitial());
  int quantity = 1;
  PrudactSize? selectedSize;
  void getPrudactDetails(String id) {
    emit(PrudactDetailsLeading());
    Future.delayed((Duration(seconds: 2)), () {
      final selectedPrudact = dummyProducts.firstWhere(
        (item) => item.id == id,
      );
      emit(PrudactDetailsLoaded(prudacts: selectedPrudact));
    });
  }

  void selectSize(PrudactSize size) {
    selectedSize = size;
    emit(SelectedSizeLoaded(size: size));
  }

  void icrementCounter(String prudactId) {
    quantity++;
    emit(QuantityCounterLoaded(value: quantity));
  }

  void decrementCounter(String prudactId) {
    quantity--;
    emit(QuantityCounterLoaded(value: quantity));
  }

  void addToCart(String prudactId) {
    emit(PrudactAddingToCart());
    print('your carts length is : $dummyCart');
    final cartItem = AddToCartModel(
      prudact: dummyProducts.firstWhere((item) => item.id == prudactId),
      id: DateTime.now().toIso8601String(),
      size: selectedSize!,
      quantity: quantity,
    );
    dummyCart.add(cartItem);
    print('your carts length is : ${dummyCart.length}');
    Future.delayed((Duration(seconds: 2)), () {
      emit(PrudactAdedToCart(prudactId: prudactId));
    });
  }
}
