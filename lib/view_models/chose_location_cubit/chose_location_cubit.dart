import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talabat_online/model/location_item_model.dart';

part 'chose_location_state.dart';

class ChoseLocationCubit extends Cubit<ChoseLocationState> {
  ChoseLocationCubit() : super(ChoseLocationInitial());
  String selectedLacationID = dummyLocations.first.id;
  void fetchLocation() {
    emit(FetchingLocation());
    Future.delayed(Duration(seconds: 1), () {
      emit(FetchedLocation(dummyLocations));
    });
  }

  void addLocation(String location) {
    emit(LocationAdding());
    Future.delayed(Duration(seconds: 1), () {
      final siplltedLocation = location.split('-');
      final locationItem = LoactionItemModel(
        id: DateTime.now().toIso8601String(),
        city: siplltedLocation[0],
        country: siplltedLocation[1],
      );
      dummyLocations.add(locationItem);
      emit(LocationAded());
      emit(FetchedLocation(dummyLocations));
    });
  }

  void selectLocation(String id) {
    selectedLacationID = id;
    final chosenLocation = dummyLocations
        .firstWhere((location) => location.id == selectedLacationID);
    emit(ChosenLocation(location: chosenLocation));
  }

  void confirmAddress() {
    emit(ConfirmAddressLeading());
    Future.delayed(Duration(seconds: 1), () {
      var chosenAddress = dummyLocations
          .firstWhere((location) => location.id == selectedLacationID);
      var previousAddress = dummyLocations.firstWhere(
          (location) => location.isChosen == true,
          orElse: () => dummyLocations.first);
      previousAddress = previousAddress.copyWith(isChosen: false);
      chosenAddress = chosenAddress.copyWith(isChosen: true);
      final previousIndex = dummyLocations
          .indexWhere((location) => location.id == previousAddress.id);
      final chosenIndex = dummyLocations
          .indexWhere((location) => location.id == chosenAddress.id);
      dummyLocations[previousIndex] = previousAddress;
      dummyLocations[chosenIndex] = chosenAddress;
      emit(ConfirmAddressLoaded());
    });
  }
}
