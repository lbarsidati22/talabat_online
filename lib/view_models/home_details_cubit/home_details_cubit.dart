import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:talabat_online/model/prudact_item_model.dart';

part 'home_details_state.dart';

class PrudactDetailsCubit extends Cubit<PrudactDetailsState> {
  PrudactDetailsCubit() : super(PrudactDetailsInitial());
  int quantity = 1;
  void getPrudactDetails(String id) {
    emit(PrudactDetailsLeading());
    Future.delayed((Duration(seconds: 2)), () {
      final selectedPrudact = dummyProducts.firstWhere(
        (item) => item.id == id,
      );
      emit(PrudactDetailsLoaded(prudacts: selectedPrudact));
    });
  }

  void icrementCounter(String prudactId) {
    quantity++;
    emit(QuantityCounterLoaded(value: quantity));
  }

  void decrementCounter(String prudactId) {
    quantity--;
    emit(QuantityCounterLoaded(value: quantity));
  }
}
