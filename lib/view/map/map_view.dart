// ignore_for_file: implementation_imports

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:my_orders/core/locationHelper/location_helper.dart';

import 'component/location_card.dart';

class MapView extends StatefulWidget {
  const MapView({Key? key}) : super(key: key);

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  static Position? position;
  final Completer<GoogleMapController> _mapController = Completer();

  //===============================================================
  static final CameraPosition _myCurrentLocationCameraPosition = CameraPosition(
      target: LatLng(position!.latitude, position!.longitude),
      bearing: 0.0,
      tilt: 0.0,
      zoom: 17.0);

  Future<void> getMyCurrentLocation() async =>
      position = await LocationHelper.getCurrentLocation().whenComplete(() {
        setState(() {});
      });

  Future<void> _goToMyCurrentLocation() async {
    final GoogleMapController controller = await _mapController.future;
    controller.animateCamera(
        CameraUpdate.newCameraPosition(_myCurrentLocationCameraPosition));
  }

  Widget buildMap() {
    return GoogleMap(
      initialCameraPosition: _myCurrentLocationCameraPosition,
      mapType: MapType.normal,
      myLocationEnabled: true,
      zoomControlsEnabled: false,
      myLocationButtonEnabled: false,
      onMapCreated: (GoogleMapController controller) {
        _mapController.complete(controller);
      },
    );
  }

  @override
  void initState() {
    super.initState();
    getMyCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            position != null
                ? buildMap()
                : const Center(
                    child: CupertinoActivityIndicator(
                        animating: true, radius: 32.0)),
            const LocationCard(),
          ],
        ),
        // floatingActionButtonLocation: FloatingActionButtonLocation.miniStartTop,
        // floatingActionButton: Container(
        //   margin: const EdgeInsets.fromLTRB(0, 12, 8, 0),
        //   child: FloatingActionButton(
        //     backgroundColor: AppColors.redColor,
        //     onPressed: _goToMyCurrentLocation,
        //     child: const Icon(Icons.place, color: Colors.white),
        //   ),
        // ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
