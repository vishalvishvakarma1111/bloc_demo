part of 'profile_bloc.dart';

@immutable
abstract class ProfileState {
  final Profile? profile;

  const ProfileState(this.profile);
}

class ProfileInitial extends ProfileState {
  const ProfileInitial() : super(null);
}

class ProfileLoader extends ProfileState {
  const ProfileLoader() : super(null);
}

class ProfileUpdateLoader extends ProfileState {
  const ProfileUpdateLoader() : super(null);
}

class ProfileLoaded extends ProfileState {
  final Profile profile;

  const ProfileLoaded({required this.profile}) : super(null);

  ProfileLoaded copyData(Profile? profiles) {
    return ProfileLoaded(profile: profiles ?? this.profile);
  }
}

class ProfileLogoutLoader extends ProfileState {
  const ProfileLogoutLoader() : super(null);
}

class ProfileError extends ProfileState {
  final String msg;

  const ProfileError({required this.msg}) : super(null);
}

class ProfileSuccess extends ProfileState {
  const ProfileSuccess() : super(null);
}
