import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:psspl_bloc_demo/firebase_todo/add_notes/add_note_bloc.dart';
import 'package:psspl_bloc_demo/firebase_todo/model/ntoes_model.dart';
 import 'package:psspl_bloc_demo/main.dart';

class AddNotesView extends StatefulWidget {
  Notes? item;

  AddNotesView({Key? key, this.item}) : super(key: key);

  @override
  State<AddNotesView> createState() => _AddNotesViewState();
}

class _AddNotesViewState extends State<AddNotesView> {
  final titleController = TextEditingController();
  final descController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    if (widget.item != null) {
      titleController.text = widget.item?.title ?? "";
      descController.text = widget.item?.description ?? "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddNoteBloc(),
      child: BlocConsumer<AddNoteBloc, AddNoteState>(
        listener: (context, state) {
          if (state is ErrorState) {
            showSnackBar(state.errorMsg);
          } else if (state is AddNotesSuccess) {
            showSnackBar(
                "Notes ${widget.item == null ? "added" : "update"} successful");
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
                title: Text("${widget.item == null ? "Add" : "Update"}Notes")),
            body: Container(
              color: Colors.lightGreen[900],
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  TextField(
                    controller: titleController,
                    decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        hintText: "Enter title",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20))),
                  ),
                  const SizedBox(height: 30),
                  TextField(
                    controller: descController,
                    maxLines: 6,
                    decoration: InputDecoration(
                      hintText: "Enter desc",
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  state is LoadingState
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : MaterialButton(
                          height: 45,
                          minWidth: double.maxFinite,
                          onPressed: () {
                            if (widget.item == null) {
                              BlocProvider.of<AddNoteBloc>(context).add(
                                  AddNotesTap(
                                      title: titleController.text.trim(),
                                      desc: descController.text.trim()));
                            } else {
                              BlocProvider.of<AddNoteBloc>(context).add(
                                  UpdateNotesTap(
                                      title: titleController.text.trim(),
                                      desc: descController.text.trim(),
                                      id: widget.item?.id ?? ""));
                            }
                          },
                          color: Colors.blue,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          child: const Text(
                            "Submit",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
