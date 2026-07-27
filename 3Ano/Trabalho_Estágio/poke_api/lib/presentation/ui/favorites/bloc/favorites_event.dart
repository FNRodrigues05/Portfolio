part of 'favorites_bloc.dart';

@immutable
abstract class FavoritesEvent extends Equatable {
  const FavoritesEvent();
}

class LoadFavoritesEvent extends FavoritesEvent {
  const LoadFavoritesEvent();

  @override
  List<Object?> get props => [];
}
