part of 'whether_bloc.dart';

@immutable
abstract class WhetherEvent {}

class WhetherApiEvent extends WhetherEvent {
  final String lat;
  final String long;
  final String city;

  WhetherApiEvent({required this.lat, required this.long, required this.city});
}
