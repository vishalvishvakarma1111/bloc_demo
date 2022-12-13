import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:psspl_bloc_demo/firebase_todo/home/homeview.dart';
import 'package:psspl_bloc_demo/firebase_todo/home_tabs/home_tab_view.dart';
import 'package:psspl_bloc_demo/firebase_todo/login/bloc/login_bloc.dart';
import 'package:psspl_bloc_demo/firebase_todo/signup/signup_view.dart';
class LoginView extends StatelessWidget {
  final c1 = TextEditingController();
  final c2 = TextEditingController();

  LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc()..add(LoginInitialEvent()),
      child: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          // TODO: implement listener

          if (state is LoginErrorState) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(content: Text(state.msg)),
              );
          }
          if (state is LoginSuccess) {
            Navigator.pushAndRemoveUntil(context,
                MaterialPageRoute(builder: (BuildContext context) {
              return const HomeTabView();
            }), (route) => false);
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: Container(
              padding: const EdgeInsets.all(20),
              child: state is LoginInitial
                  ? const SizedBox.shrink()
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextField(
                          controller: c1,
                          decoration: InputDecoration(
                              hintText: "Enter email",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20))),
                        ),
                        const SizedBox(height: 30),
                        TextField(
                          controller: c2,
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: "Enter password",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        state is LoginLoadedState && state.loader
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : MaterialButton(
                                minWidth: double.maxFinite,
                                onPressed: () {
                                  BlocProvider.of<LoginBloc>(context).add(
                                      LoginBtnTapEvent(
                                          email: c1.text, pwd: c2.text));
                                },
                                color: Colors.blue,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                child: const Text(
                                  "Login",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                        MaterialButton(
                          minWidth: double.maxFinite,
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(
                                builder: (BuildContext context) {
                              return SignUpView();
                            }));
                          },
                          color: Colors.blue,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          child: const Text(
                            "Don\'t have account signup",
                            style: TextStyle(color: Colors.white),
                          ),
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
