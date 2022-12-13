import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:http/http.dart' as http;
import 'package:psspl_bloc_demo/cubit_demo/login_cubt.dart';
import 'package:psspl_bloc_demo/firebase_options.dart';
import 'package:psspl_bloc_demo/firebase_otp/otp_login/otp_loginview.dart';
import 'package:psspl_bloc_demo/google_map/mapviews/mapscreen.dart';
import 'package:psspl_bloc_demo/main_bloc/main_bloc.dart';
import 'package:psspl_bloc_demo/native_code_demo/check_battery_level.dart';
import 'package:psspl_bloc_demo/splash.dart';
import 'package:psspl_bloc_demo/timer_demo/timer_view.dart';
import 'package:psspl_bloc_demo/util/style.dart';
import 'package:psspl_bloc_demo/util/theme_pref.dart';
import 'package:psspl_bloc_demo/whether_app/view/home/homeview.dart';
import 'dark_theme_demo/dark_theme_demo.dart';
import 'my_imports.dart';
import 'native_code_demo/native_view/native_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  static void setLocale(BuildContext context, Locale newLocale) async {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();

    state?.setState(() {
      state._locale = newLocale;
    });
  }

  static _MyAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>()!;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale = const Locale('ar', 'ps');

  bool darkTheme = false;

  @override
  void initState() {
    super.initState();
    DarkThemePref.setDarkTheme(true);
    DarkThemePref.getTheme().then((value) {
      setState(() {
        darkTheme = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: _locale,
      scaffoldMessengerKey: snackbarKey,
      title: 'Flutter Demo',
      navigatorKey: navigationKey,

      debugShowCheckedModeBanner: false,

      /// for localization support
      localizationsDelegates:   [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''), // English, no country code
        Locale('es', ''), // Spanish, no country code
        Locale('hi', ''), // hindi, no country code
      ],
      theme: Style.themeData(darkTheme, context),

/*
      home: BlocProvider(
        child: PostView(),
        create: (_) => PostBloc(httpClient: http.Client())..add(PostFetched()),
      ),
*/
      // home: const CheckBatteryLeveView(), // native code for android
//         home: const MapScreenView(), /// google map
      //home: LoginCubitDemo(), /// cubit and localization aap
      home: const DarkThemeView(),

      /// app for dark and light theme
      //  home: const NativeView(), // native view for android
//        home: const SplashView(), //  firebase todo app
      //  home: const TimerView(), // timer app
      // home: const WhetherHomeView(), // a whether  app
      // home: OtpLoginView(), // a firebase otp  app
    );

    /*BlocProvider(
      create: (context) => MainBloc()..add(InitEvent()),
      child: BlocConsumer<MainBloc, MainState>(
        listener: (context, state) {
          if (state is InternetLostState) {
            SnackBar snackBar = const SnackBar(
                backgroundColor: Colors.red, content: Text("Internet lost "));
            snackbarKey.currentState?.showSnackBar(snackBar);
          } else if (state is InternetGainedState) {
            SnackBar snackBar = const SnackBar(
                backgroundColor: Colors.green, content: Text("Connected to Internet "));
            snackbarKey.currentState?.showSnackBar(snackBar);
          }
        },
        builder: (context, state) {
          return MaterialApp(
            scaffoldMessengerKey: snackbarKey,
            title: 'Flutter Demo',
            navigatorKey: navigationKey,
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            debugShowCheckedModeBanner: false,
*/ /*
      home: BlocProvider(
        child: PostView(),
        create: (_) => PostBloc(httpClient: http.Client())..add(PostFetched()),
      ),
*/ /*
            home: const SplashView(), //  firebase todo app
            //  home: const TimerView(), // timer app
            // home: const WhetherHomeView(), // a whether  app
            // home: OtpLoginView(), // a firebase otp  app
          );
        },
      ),
    );*/
  }

  void changeTheme(bool isDark) {
    setState(() {
      darkTheme = isDark;
    });
  }
}

final GlobalKey<ScaffoldMessengerState> snackbarKey =
    GlobalKey<ScaffoldMessengerState>();
final GlobalKey<NavigatorState> navigationKey = GlobalKey<NavigatorState>();

showSnackBar(String msg) {
  final SnackBar snackBar = SnackBar(content: Text(msg));
  snackbarKey.currentState?.showSnackBar(snackBar);
}

get decoration => const BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Colors.yellow,
          Colors.tealAccent,
        ],
        begin: Alignment.topLeft,
        end: Alignment.topRight,
      ),
    );
