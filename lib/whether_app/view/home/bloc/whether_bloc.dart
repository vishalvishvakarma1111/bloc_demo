import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:psspl_bloc_demo/whether_app/models/whether_resp.dart';
import 'package:psspl_bloc_demo/whether_app/network/api_client.dart';

part 'whether_event.dart';

part 'whether_state.dart';

class WhetherBloc extends Bloc<WhetherEvent, WhetherState> {
  ApiClient client = ApiClient();

  WhetherBloc() : super(const WhetherInitial()) {
    on<WhetherEvent>((event, emit) {});
    on<WhetherApiEvent>(_getWhetherDetail);
  }

  FutureOr<void> _getWhetherDetail(
      WhetherApiEvent event, Emitter<WhetherState> emit) async {
    emit(const WhetherLoader());
    WhetherResponse res = await client.getWhetherDetails(event.lat, event.long);
    if (res.status) {
      emit(WhetherLoaded(res, event.city));
    } else {
      emit(WhetherError(res.message));
    }
  }
}
