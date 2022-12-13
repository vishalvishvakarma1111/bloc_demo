import 'package:flutter/material.dart';
import 'package:psspl_bloc_demo/main.dart';

import '../firebase_otp/otp_login/otpLogin/otp_login_bloc.dart';
import '../my_imports.dart';
import 'cubit/demo_cubit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginCubitDemo extends StatelessWidget {
  final c1 = TextEditingController();
  final c2 = TextEditingController();

  LoginCubitDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DemoCubit()..addLoadedState(),
      child: BlocConsumer<DemoCubit, DemoState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return Scaffold(
            body: state is DemoLoadedState
                ? Container(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          child: Text("Set locale to spansish"),
                          onPressed: () {
                            MyApp.setLocale(context, const Locale("es", ""));
                          },
                        ),
                        TextButton(
                          child: Text("English"),
                          onPressed: () {
                            MyApp.setLocale(context, const Locale("en", ""));
                          },
                        ),
                        TextButton(
                          child: Text("Hindi"),
                          onPressed: () {
                            MyApp.setLocale(context, const Locale("hi"));
                          },
                        ),
                        Text(
                          AppLocalizations.of(context).helloWorld,
                          style: TextStyle(fontSize: 50),
                        ),
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
                        Visibility(
                          visible: state.showLoader,
                          replacement: MaterialButton(
                            minWidth: double.maxFinite,
                            onPressed: () {
                              context.read<DemoCubit>().showLoader();
                            },
                            color: Colors.blue,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            child: const Text(
                              "Login",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                        CheckboxListTile(
                          title: const Text("i am agree"),
                          value: state.isChecked,
                          onChanged: (bool? value) {
                            context.read<DemoCubit>().onChanged(value ?? false);
                          },
                        ),
                      ],
                    ),
                  )
                : const SizedBox(
                    height: 20,
                    width: 20,
                  ),
          );
        },
      ),
    );
  }
}
