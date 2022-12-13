import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:psspl_bloc_demo/firebase_todo/add_notes/add_notes_view.dart';
import 'package:psspl_bloc_demo/firebase_todo/home/bloc/home_bloc.dart';
import 'package:psspl_bloc_demo/firebase_todo/login/login_view.dart';
import 'package:psspl_bloc_demo/main.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc()..add(HomeLoadNotesEvent(const [])),
      child: BlocConsumer<HomeBloc, HomeState>(
        listener: (context, state) {
          if (state is FailureState) {
            showSnackBar(state.errorMsf);
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: getAppBar(context, state),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (BuildContext context) {
                    return AddNotesView();
                  }),
                );
              },
              child: const Icon(Icons.add),
            ),
            body: Container(
              child: state is LoaderState
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : state is HomeLoaded
                      ? state.notesList.isEmpty
                          ? const Center(
                              child: Text("No Notes added yet"),
                            )
                          : ListView.builder(
                              itemCount: state.notesList.length,
                              itemBuilder: (BuildContext context, int index) {
                                var item = state.notesList[index];

                                return (item.loader ?? false)
                                    ? const Center(
                                        child: CircularProgressIndicator(),
                                      )
                                    : ListTile(
                                        onLongPress: () {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                  title: const Text("Alert!"),
                                                  content:
                                                      const Text("Edit notes"),
                                                  actions: [
                                                    TextButton(
                                                        onPressed: () =>
                                                            Navigator.pop(
                                                                context),
                                                        child:
                                                            const Text("No")),
                                                    TextButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (BuildContext
                                                                          context) {
                                                            return AddNotesView(
                                                                item: item);
                                                          }));
                                                        },
                                                        child:
                                                            const Text("No")),
                                                  ]);
                                            },
                                          );
                                        },
                                        title: Text(
                                          item.title ?? "",
                                          style: const TextStyle(
                                            fontSize: 20,
                                          ),
                                        ),
                                        subtitle: Text(
                                          item.description ?? "",
                                          style: const TextStyle(
                                            fontSize: 17,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        trailing: IconButton(
                                          icon: const Icon(
                                            Icons.delete,
                                          ),
                                          onPressed: () {
                                            showDialog(
                                                context: context,
                                                builder: (BuildContext
                                                    dialogContext) {
                                                  return AlertDialog(
                                                    title: const Text("Alert!"),
                                                    content: const Text(
                                                        "Delete notes"),
                                                    actions: [
                                                      TextButton(
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child:
                                                              const Text("No")),
                                                      TextButton(
                                                          onPressed: () async {
                                                            Navigator.pop(
                                                                context);

                                                            BlocProvider.of<
                                                                        HomeBloc>(
                                                                    context)
                                                                .add(
                                                              HomeDeleteNoteEvent(
                                                                notes: item,
                                                                notesList: state
                                                                    .notesList,
                                                              ),
                                                            );
                                                          },
                                                          child:
                                                              const Text("Yes"))
                                                    ],
                                                  );
                                                });
                                          },
                                        ),
                                      );
                              },
                            )
                      : const SizedBox.shrink(),
            ),
          );
        },
      ),
    );
  }
}

PreferredSizeWidget getAppBar(BuildContext context, HomeState state) {
  return AppBar(
    title: const Text(
      "Home",
    ),
    actions: [
      IconButton(
          onPressed: () async {
            BlocProvider.of<HomeBloc>(context).add(
                HomeLoadNotesEvent(state is HomeLoaded ? state.notesList : []));
          },
          icon: const Icon(
            Icons.refresh,
          )),
      IconButton(
          onPressed: () async {
            try {
              FirebaseAuth.instance.signOut().then((value) {
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                  builder: (BuildContext context) {
                    return LoginView();
                  },
                ), (route) => false);
              });
            } catch (e) {
              print(e);
            }
          },
          icon: const Icon(
            Icons.logout,
          ))
    ],
  );
}
