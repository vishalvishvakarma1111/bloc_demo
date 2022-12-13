import 'package:flutter/material.dart';
import 'package:psspl_bloc_demo/firebase_otp/otp/otp_view.dart';
import 'package:psspl_bloc_demo/firebase_otp/otp_login/otpLogin/otp_login_bloc.dart';
import 'package:psspl_bloc_demo/main.dart';
import 'package:psspl_bloc_demo/my_imports.dart';

class OtpLoginView extends StatelessWidget {
  final controller = TextEditingController();

  OtpLoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OtpLoginBloc(),
      child: Scaffold(
        appBar: AppBar(title: const Text("Login ")),
        body: BlocConsumer<OtpLoginBloc, OtpLoginState>(
          listener: (context, state) {
            if (state is ErrorState) {
              showSnackBar(state.msg);
            } else if (state is OtpLoginSuccess) {
              Navigator.push(context, MaterialPageRoute(
                builder: (BuildContext context) {
                  return OtpView(
                    verificationId: state.verificationId,
                    phone: state.phone,
                  );
                },
              ));
            }
          },
          builder: (context, state) {
            return Container(
              decoration: decoration,
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const SizedBox(
                    height: 50,
                    width: 20,
                  ),
                  const Text(
                    "Login With otp",
                    style: TextStyle(fontSize: 40, color: Colors.red),
                  ),
                  const SizedBox(
                    height: 120,
                    width: 20,
                  ),
                  TextField(
                    controller: controller,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        hintText: "Enter phone",
                        prefixIcon: const Icon(Icons.mobile_friendly),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20))),
                  ),
                  const SizedBox(
                    height: 40,
                    width: 40,
                  ),
                  Visibility(
                    visible: state is LoaderState,
                    replacement: MaterialButton(
                      height: 45,
                      minWidth: double.maxFinite,
                      onPressed: () => context
                          .read<OtpLoginBloc>()
                          .add(SubmitEvent(controller.text.trim())),
                      color: Colors.blue,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: const Text(
                        "Submit",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
