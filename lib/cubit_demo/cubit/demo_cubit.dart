import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'demo_state.dart';

class DemoCubit extends Cubit<DemoState> {
  DemoCubit() : super(DemoInitial());

  addLoadedState() {
    emit(DemoLoadedState(false,false));
  }

  void showLoader() async {
    var lastState = state as DemoLoadedState;

    emit(lastState.copyWith(lastState.isChecked, true));
    await Future.delayed(const Duration(seconds: 5));
    emit(lastState.copyWith(lastState.isChecked, false));
  }

  void onChanged(bool val) {
    var lastState = state as DemoLoadedState;
    emit(lastState.copyWith(val, lastState.showLoader));
  }
}
