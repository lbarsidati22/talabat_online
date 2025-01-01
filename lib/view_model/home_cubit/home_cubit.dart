import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talabat_online/model/home_carousel_item_model.dart';
import 'package:talabat_online/model/prudact_item_model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  void getHomeData() {
    emit(HomelLeading());
    Future.delayed((Duration(seconds: 1)), () {
      emit(HomelLoaded(
        prudact: dummyProducts,
        carouselItem: dummyHomeCarouselItems,
      ));
    });
  }
}
