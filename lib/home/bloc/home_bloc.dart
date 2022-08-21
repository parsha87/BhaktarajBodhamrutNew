import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/sharedprefs/shared_preference_helper.dart';
import '../data/models/bhajans.dart';
import '../data/repository/home_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(this.homeRepository) : super(HomeInitial()) {
    on<HomeEventFetch>(_fetchHomeProducts);
    on<HomeEventLogout>(_logOutUserFromApp);
  }
  final HomeRepository homeRepository;

  Future<void> _fetchHomeProducts(
    HomeEventFetch event,
    Emitter<HomeState> emit,
  ) async {
    try {
      emit(HomeLoading());
      final data = homeRepository.products;
      emit(HomeLoaded(bhajans: data));
    } catch (e) {
      emit(HomeError(error: e.toString()));
    }
  }

  FutureOr<void> _logOutUserFromApp(
    HomeEventLogout event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoading());
    try {
      await homeRepository.logout();
      await SharedPreferences.getInstance().then((_prefs) async {
        await SharedPreferenceHelper(_prefs).setIsLoggedIn(isLoggedIn: false);
        await SharedPreferenceHelper(_prefs).setIsNewuser(isNewUser: false);
      }).then((value) {
        Navigator.pushNamedAndRemoveUntil(
          event.context,
          '/signin',
          (route) => false,
        );
      });
    } catch (e) {
      emit(HomeError(error: e.toString()));
    }
  }
}
