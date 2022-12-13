part of 'demo_cubit.dart';

@immutable
abstract class DemoState {
  DemoState();
}

class DemoInitial extends DemoState {}

class DemoLoadedState extends DemoState {
  final bool isChecked;
  final bool showLoader;

  DemoLoadedState(this.isChecked, this.showLoader);

  DemoLoadedState copyWith(bool? isChecked, bool? showLoader) {
    return DemoLoadedState(
        isChecked ?? this.isChecked, showLoader ?? this.showLoader);
  }
}
