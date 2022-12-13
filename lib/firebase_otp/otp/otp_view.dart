import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:psspl_bloc_demo/firebase_otp/otp/bloc/otp_bloc.dart';
import 'package:psspl_bloc_demo/firebase_otp/otp/bloc/otp_event.dart';
import 'package:psspl_bloc_demo/firebase_otp/otp/bloc/otp_state.dart';
import 'package:psspl_bloc_demo/firebase_todo/home/homeview.dart';

import '../../main.dart';

class OtpView extends StatelessWidget {
  final controller = TextEditingController();
  String phone;
  String verificationId;

  OtpView({Key? key, required this.phone, required this.verificationId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OtpBloc(),
      child: Scaffold(
        appBar: AppBar(title: const Text("Otp ")),
        body: BlocConsumer<OtpBloc, OtpState>(
          listener: (context, state) {
            if (state is OtpSuccessState) {
              showSnackBar("Otp Sent successfully");
            } else if (state is ErrorState) {
              showSnackBar(state.msg);
            } else if (state is OtpSuccessState) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (BuildContext context) {
                return const HomeView();
              }));
            }
          },
          builder: (context, state) {
            return Container(
              decoration: decoration,
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 50,
                    width: 20,
                  ),
                  Text(
                    "Otp sent to the $phone",
                    style: const TextStyle(fontSize: 40, color: Colors.red),
                  ),
                  Visibility(
                    visible: state is ResendOtpLoaderState,
                    replacement: TextButton(
                      onPressed: () => context
                          .read<OtpBloc>()
                          .add(ResendOtpEvent(phone: phone)),
                      child: const Text("Resend Otp"),
                    ),
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                  TextField(
                    controller: controller,
                    maxLength: 6,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        hintText: "Enter phone",
                        prefixIcon: const Icon(Icons.mobile_friendly),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20))),
                  ),
                  const SizedBox(
                    width: 40,
                  ),
                  Visibility(
                    visible: state is OtpLoaderState,
                    replacement: MaterialButton(
                      height: 45,
                      minWidth: double.maxFinite,
                      onPressed: () {
                        context.read<OtpBloc>().add(SubmitEvent(
                            verificationId: verificationId,
                            otp: controller.text.trim()));
                      },
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
