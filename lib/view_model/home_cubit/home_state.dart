part of 'home_cubit.dart';

sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomelLeading extends HomeState {}

final class HomelLoaded extends HomeState {
  final List<HomeCarouselItemModel> carouselItem;
  final List<PrudactItemModel> prudact;

  HomelLoaded({
    required this.prudact,
    required this.carouselItem,
  });
}

final class HomeError extends HomeState {
  final String message;

  HomeError({required this.message});
}
