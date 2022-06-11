import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:workorder/Screens/OptionSelectionScreen.dart';

Marker getMarker(
    {required String id,
    required double latitude,
    required double longitude,
    required String title,
    context}) {
  return Marker(
      markerId: MarkerId(id),
      position: LatLng(
        latitude,
        longitude,
      ),
      infoWindow: InfoWindow(title: title + 'Branch'),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => OptionSelectionScreen(
                      city: title,
                    )));
      });
}
