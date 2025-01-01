import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'home_details_state.dart';

class HomeDetailsCubit extends Cubit<HomeDetailsState> {
  HomeDetailsCubit() : super(HomeDetailsInitial());
}
