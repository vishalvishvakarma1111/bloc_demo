import 'package:flutter/material.dart';
import 'package:psspl_bloc_demo/main.dart';
import 'package:psspl_bloc_demo/my_imports.dart';
import 'package:psspl_bloc_demo/whether_app/models/location.dart';
import 'package:psspl_bloc_demo/whether_app/view/home/bloc/whether_bloc.dart';
import 'package:psspl_bloc_demo/whether_app/view/search_view/bloc/search_bloc.dart';
import 'package:psspl_bloc_demo/whether_app/view/search_view/search_view.dart';

class WhetherHomeView extends StatelessWidget {
  const WhetherHomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WhetherBloc(),
      child: BlocConsumer<WhetherBloc, WhetherState>(
        listener: (context, state) {
          if (state is WhetherError) {
            showSnackBar(state.error);
          } else if (state is WhetherLoaded) {
            showSnackBar("Whether loaded successfully");
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text("Flutter whether"),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.settings,
                  ),
                ),
                const SizedBox(
                  height: 20,
                  width: 20,
                ),
                IconButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (BuildContext context) {
                      return SearchView();
                    })).then((value) {
                      print(
                          "--------- print() ---value print  ${value == null}");
                      if (value != null) {
                        Location location = value as Location;
                        context.read<WhetherBloc>().add(WhetherApiEvent(
                            lat: location.latitude ?? "0.0",
                            long: location.longitude ?? "0.0",
                            city: location.name ?? ""));
                      }
                    });
                  },
                  icon: const Icon(
                    Icons.search_rounded,
                  ),
                ),
              ],
            ),
            body: Container(
              width: double.maxFinite,
              decoration: decoration,
              child: Visibility(
                visible: state is WhetherLoader,
                replacement: Visibility(
                  visible: state.whetherResponse != null,
                  replacement: const Center(
                    child: Text("Please search for whether"),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "City name ${state.cityName}",
                        style: TextStyle(fontSize: 25, color: Colors.white),
                      ),
                      const SizedBox(
                        height: 20,
                        width: 20,
                      ),
                      Text(
                        "Temperature : ${state.whetherResponse?.currentWeather?.temperature}",
                        style: const TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                        width: 20,
                      ),
                      Text(
                        "Whether ${getWhetherString(
                          int.parse(state.whetherResponse?.currentWeather
                                  ?.weathercode ??
                              "0"),
                        )}",
                        style: TextStyle(fontSize: 25, color: Colors.white),
                      ),
                      Text(
                        "Whether ${state.whetherResponse?.currentWeather?.time ?? ""}",
                        style: TextStyle(fontSize: 25, color: Colors.white),
                      ),
                    ],
                  ),
                ),
                child: const Center(child: CircularProgressIndicator()),
              ),
            ),
          );
        },
      ),
    );
  }

  String getWhetherString(int code) {
    switch (code) {
      case 0:
        return "Clear";
      case 1:
      case 2:
      case 3:
      case 45:
      case 48:
        return "CLOUDY";
      case 51:
      case 53:
      case 55:
      case 56:
      case 57:
      case 61:
      case 63:
      case 65:
      case 66:
      case 67:
      case 80:
      case 81:
      case 82:
      case 95:
      case 96:
      case 99:
        return "RAINY";
      case 71:
      case 73:
      case 75:
      case 77:
      case 85:
      case 86:
        return "SNOWY";
      default:
        return "UNKNOWN";
    }
  }
}
