// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/models/login_response.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<LoadAlbums>(_onLoadAlbums);
    on<FilterAlbums>(_onFilterAlbums);
  }

  Future<void> _onLoadAlbums(LoadAlbums event, Emitter<HomeState> emit) async {
    emit(HomeLoading());
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedResponse = prefs.getString('login_response');

      if (savedResponse == null) {
        emit(HomeError("No saved login data found."));
        return;
      }

      final data = jsonDecode(savedResponse);
      final loginResponse = LoginResponse.fromJson(data);
      final albums = loginResponse.data?.albums ?? [];
      final profileImage = loginResponse.data?.profileImage ?? "";

      emit(HomeLoaded(
        albums: albums,
        filteredAlbums: albums,
        profileImage: profileImage,
      ));
    } catch (e) {
      emit(HomeError("Failed to load albums: $e"));
    }
  }

  void _onFilterAlbums(FilterAlbums event, Emitter<HomeState> emit) {
    if (state is HomeLoaded) {
      final currentState = state as HomeLoaded;
      final lowerQuery = event.query.toLowerCase();

      final filtered = currentState.albums.where((album) {
        final nameMatch = album.name.toLowerCase().contains(lowerQuery);
        final idMatch = album.id.toString().toLowerCase().contains(lowerQuery);
        return nameMatch || idMatch;
      }).toList();

      emit(currentState.copyWith(filteredAlbums: filtered));
    }
  }
}
