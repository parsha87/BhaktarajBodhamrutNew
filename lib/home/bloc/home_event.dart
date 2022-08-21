part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class HomeEventFetch extends HomeEvent {}

class HomeEventLogout extends HomeEvent {
  HomeEventLogout(this.context);

  final BuildContext context;
}
