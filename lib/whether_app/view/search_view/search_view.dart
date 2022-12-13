import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:psspl_bloc_demo/main.dart';
import 'package:psspl_bloc_demo/whether_app/view/search_view/bloc/search_bloc.dart';

class SearchView extends StatelessWidget {
  final controller = TextEditingController();

  SearchView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchBloc(),
      child: BlocConsumer<SearchBloc, SearchState>(
        listener: (context, state) {
          if (state is ErrorState) {
            showSnackBar(state.errorMsg);
          } else if (state is SearchSuccess) {
            Navigator.pop(context, state.location);
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text("Flutter whether"),
            ),
            body: Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  TextField(
                    controller: controller,
                  ),
                  const SizedBox(
                    height: 20,
                    width: 20,
                  ),
                  Visibility(
                    visible: state is SearchLoader,
                    replacement: MaterialButton(
                      minWidth: double.maxFinite,
                      onPressed: () {
                        context
                            .read<SearchBloc>()
                            .add(SubmitEvent(controller.text.trim()));
                      },
                      color: Colors.blue,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: const Text(
                        "Submit",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    child: Center(child: CircularProgressIndicator()),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
