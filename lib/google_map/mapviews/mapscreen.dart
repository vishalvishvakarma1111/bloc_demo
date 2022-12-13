import 'dart:async';

import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:psspl_bloc_demo/util/const.dart';

class MapScreenView extends StatefulWidget {
  const MapScreenView({Key? key}) : super(key: key);

  @override
  State<MapScreenView> createState() => _MapScreenViewState();
}

class _MapScreenViewState extends State<MapScreenView> {
  Completer<GoogleMapController> _controller = Completer();

  final CameraPosition _kGooglePlex = const CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  CustomInfoWindowController customInfoWindowController =
      CustomInfoWindowController();

  Set<Marker> markers = {};

  final CameraPosition _kLake = const CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  void initState() {
    markers = {
      Marker(
        markerId: const MarkerId("marker_id"),
        position: const LatLng(37.43296265331129, -122.08832357078792),
        onTap: () {
          customInfoWindowController.addInfoWindow!(
            SizedBox(
              height: 100,
              child: Stack(
                children: [
                  Container(
                    height: 80,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    alignment: Alignment.center,
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "Asdfsdf",
                                style: TextStyle().bold.copyWith(fontSize: 14),
                              ),
                              Text(
                                "j-17777",
                                style:
                                    TextStyle().normal.copyWith(fontSize: 12),
                              ),
                              Text(
                                "local & online deal available!local",
                                style: TextStyle().normal.copyWith(
                                    fontSize: 12,
                                    overflow: TextOverflow.ellipsis),
                              ),
                            ],
                          ),
                        ),
                        const Icon(
                          Icons.info_outline,
                          color: Colors.blue,
                        ),
                      ],
                    ),
                  ),
                  const Positioned(
                    bottom: -25,
                    right: 0,
                    left: 0,
                    child: Icon(
                      Icons.arrow_drop_down_sharp,
                      color: Colors.white,
                      size: 80,
                    ),
                  ),
                ],
              ),
            ),
            const LatLng(37.43296265331129, -122.08832357078792),
          );
        },
      ),
      Marker(
        markerId: const MarkerId("marker_id"),
        position: const LatLng(20.5937, 78.9629),
        onTap: () {
          print("--------- print() ---- " );
          customInfoWindowController.addInfoWindow!(
            SizedBox(
              height: 100,
              child: Stack(
                children: [
                  Container(
                    height: 80,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    alignment: Alignment.center,
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "Asdfsdf",
                                style: TextStyle().bold.copyWith(fontSize: 14),
                              ),
                              Text(
                                "j-17777",
                                style:
                                    TextStyle().normal.copyWith(fontSize: 12),
                              ),
                              Text(
                                "local & online deal available!local",
                                style: TextStyle().normal.copyWith(
                                    fontSize: 12,
                                    overflow: TextOverflow.ellipsis),
                              ),
                            ],
                          ),
                        ),
                        const Icon(
                          Icons.info_outline,
                          color: Colors.blue,
                        ),
                      ],
                    ),
                  ),
                  const Positioned(
                    bottom: -25,
                    right: 0,
                    left: 0,
                    child: Icon(
                      Icons.arrow_drop_down_sharp,
                      color: Colors.white,
                      size: 80,
                    ),
                  ),
                ],
              ),
            ),
            const LatLng(20.5937, 78.9629),
          );
        },
      ),
    };
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.normal,
            onTap: (position) {
              customInfoWindowController.hideInfoWindow!();
            },
            onCameraMove: (position) {
              customInfoWindowController.onCameraMove!();
            },
            compassEnabled: true,
            initialCameraPosition: _kGooglePlex,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
              customInfoWindowController.googleMapController = controller;
            },
            markers: markers,
            myLocationButtonEnabled: true,
            myLocationEnabled: true,
            mapToolbarEnabled: true,
          ),
          CustomInfoWindow(
            controller: customInfoWindowController,
            height: 100,
            width: 250,
            offset: 50,
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerTop,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToTheLake,
        label: const Text('To the lake!'),
        icon: const Icon(Icons.directions_boat),
      ),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}
