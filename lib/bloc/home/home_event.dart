part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class LoadAlbums extends HomeEvent {}

class FilterAlbums extends HomeEvent {
  final String query;

  const FilterAlbums(this.query);

  @override
  List<Object> get props => [query];
}
