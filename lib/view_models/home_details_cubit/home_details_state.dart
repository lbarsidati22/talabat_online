part of 'home_details_cubit.dart';

@immutable
sealed class PrudactDetailsState {}

final class PrudactDetailsInitial extends PrudactDetailsState {}

final class PrudactDetailsLoaded extends PrudactDetailsState {
  final PrudactItemModel prudacts;

  PrudactDetailsLoaded({required this.prudacts});
}

final class PrudactDetailsError extends PrudactDetailsState {
  final String message;

  PrudactDetailsError({
    required this.message,
  });
}

final class PrudactDetailsLeading extends PrudactDetailsState {}

final class PrudactAddingToCart extends PrudactDetailsState {}

final class PrudactAdedToCart extends PrudactDetailsState {
  final String prudactId;

  PrudactAdedToCart({required this.prudactId});
}

final class SelectedSizeLoaded extends PrudactDetailsState {
  final PrudactSize size;

  SelectedSizeLoaded({
    required this.size,
  });
}

final class QuantityCounterLoaded extends PrudactDetailsState {
  final int value;

  QuantityCounterLoaded({required this.value});
}
