part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<Album> albums;
  final List<Album> filteredAlbums;
  final String profileImage;

  const HomeLoaded({
    required this.albums,
    required this.filteredAlbums,
    required this.profileImage,
  });

  HomeLoaded copyWith({
    List<Album>? albums,
    List<Album>? filteredAlbums,
    String? profileImage,
  }) {
    return HomeLoaded(
      albums: albums ?? this.albums,
      filteredAlbums: filteredAlbums ?? this.filteredAlbums,
      profileImage: profileImage ?? this.profileImage,
    );
  }

  @override
  List<Object?> get props => [albums, filteredAlbums, profileImage];
}

class HomeError extends HomeState {
  final String message;
  const HomeError(this.message);

  @override
  List<Object?> get props => [message];
}
