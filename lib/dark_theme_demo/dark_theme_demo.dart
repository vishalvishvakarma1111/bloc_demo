import 'package:flutter/material.dart';
import 'package:psspl_bloc_demo/util/theme_pref.dart';

import '../main.dart';

class DarkThemeView extends StatefulWidget {
  const DarkThemeView({Key? key}) : super(key: key);

  @override
  State<DarkThemeView> createState() => _DarkThemeViewState();
}

class _DarkThemeViewState extends State<DarkThemeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("DarkThemeDemo"),
        backgroundColor: Theme.of(context).hoverColor,
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () async {
                  bool isDark = await DarkThemePref.getTheme();
                  DarkThemePref.setDarkTheme(!isDark);
                  MyApp.of(context).changeTheme(isDark);
                },
                child: Text('Light')),
            TextField(
              decoration: InputDecoration(
                  hintText: "Enter email",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20))),
            ),
            const SizedBox(height: 30),
            TextField(
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
              visible: true,
              replacement: MaterialButton(
                minWidth: double.maxFinite,
                onPressed: () {},
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
          ],
        ),
      ),
    );
  }
}
