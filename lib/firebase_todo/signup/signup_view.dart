import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:psspl_bloc_demo/firebase_todo/home/homeview.dart';
import 'package:psspl_bloc_demo/firebase_todo/signup/signup_bloc/signup_bloc.dart';

import '../../main.dart';
class SignUpView extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  SignUpView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignupBloc(),
      child: BlocConsumer<SignupBloc, SignupState>(
        listener: (context, state) {
          if (state is SignupFailure) {
            showSnackBar(state.errorMsg);
          }
          if (state is SignupSuccess) {
            Navigator.pushAndRemoveUntil(context,
                MaterialPageRoute(builder: (BuildContext context) {
              return const HomeView();
            }), (route) => false);
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                        hintText: "Enter email",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20))),
                  ),
                  const SizedBox(height: 30),
                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: "Enter password",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  state is SignupLoader
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : MaterialButton(
                          minWidth: double.maxFinite,
                          onPressed: () {
                            BlocProvider.of<SignupBloc>(context).add(
                                SignupTapped(
                                    email: emailController.text.trim(),
                                    password: passwordController.text.trim()));
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
