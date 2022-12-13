part of 'whether_bloc.dart';

@immutable
abstract class WhetherState {
  final WhetherResponse? whetherResponse;
  final String? cityName;

  const WhetherState(this.whetherResponse, this.cityName);
}

class WhetherInitial extends WhetherState {
  const WhetherInitial() : super(null, null);
}

class WhetherLoader extends WhetherState {
  const WhetherLoader() : super(null, null);
}

class WhetherError extends WhetherState {
  final String error;

  const WhetherError(this.error) : super(null, null);
}

class WhetherLoaded extends WhetherState {
  const WhetherLoaded(super.whetherResponse, super.cityName);
}
