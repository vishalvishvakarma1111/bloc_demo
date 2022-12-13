part of 'home_tab_bloc.dart';

@immutable
abstract class HomeTabEvent {}

class HomeTapEvent extends HomeTabEvent {
  final int index;

  HomeTapEvent({required this.index});
}
