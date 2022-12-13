import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:psspl_bloc_demo/whether_app/models/location.dart';
import 'package:psspl_bloc_demo/whether_app/network/api_client.dart';

part 'search_event.dart';

part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final ApiClient apiClient = ApiClient();

  SearchBloc() : super(SearchInitial()) {
    on<SearchEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<SubmitEvent>(_search);
  }

  FutureOr<void> _search(SubmitEvent event, Emitter<SearchState> emit) async {
    emit(SearchLoader());
    LocationResponse res = await apiClient.locationSearch(event.query);
    if (res.statusCode == 200) {
      emit(SearchSuccess(res.results.first));
    } else {
      emit(ErrorState("Something went wrong"));
    }
  }
}
