part of 'profile_bloc.dart';

@immutable
abstract class ProfileEvent {}

class LogoutEvent extends ProfileEvent {}

class UpdateProfileEvent extends ProfileEvent {
  final Profile profile;

  UpdateProfileEvent({required this.profile});
}

class LoadProfile extends ProfileEvent {}

class LogoutTapEvent extends ProfileEvent {}

class SelectPhotoEvent extends ProfileEvent {
  final Profile profile;

  SelectPhotoEvent({required this.profile});
}
