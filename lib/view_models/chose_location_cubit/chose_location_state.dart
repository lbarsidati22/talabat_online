part of 'chose_location_cubit.dart';

sealed class ChoseLocationState {}

final class ChoseLocationInitial extends ChoseLocationState {}

final class FetchingLocation extends ChoseLocationState {}

final class FetchedLocation extends ChoseLocationState {
  final List<LoactionItemModel> locations;

  FetchedLocation(this.locations);
}

final class FetchLocationError extends ChoseLocationState {}

final class LocationAdding extends ChoseLocationState {}

final class LocationAded extends ChoseLocationState {
  // final LoactionItemModel locations;

  // LocationAded(this.locations);
}

final class LocationError extends ChoseLocationState {}

final class ChosenLocation extends ChoseLocationState {
  final LoactionItemModel location;

  ChosenLocation({required this.location});
}

final class ConfirmAddressLeading extends ChoseLocationState {}

final class ConfirmAddressLoaded extends ChoseLocationState {}

final class ConfirmAddressError extends ChoseLocationState {}
