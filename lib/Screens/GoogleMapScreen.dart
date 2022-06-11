import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../Utils/AppBar.dart';
import '../Utils/Marker.dart';

class GoogleMapScreen extends StatefulWidget {
  const GoogleMapScreen({Key? key}) : super(key: key);

  @override
  State<GoogleMapScreen> createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {
  List<String> id = ['id-1', 'id-2', 'id-3', 'id-4', 'id-5'];
  List<double> latitude = [31.5204, 33.6844, 24.8607, 30.1575, 30.1798];
  List<double> longitude = [74.3587, 73.0479, 67.0011, 71.5249, 66.9750];
  List<String> _title = ['Lahore ', 'Islamabad', 'Karachi', 'Multan', 'Queta'];
  Set<Marker> _markers = {};
  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      for (int i = 0; i < id.length; i++) {
        _markers.add(
          getMarker(
              id: id[i],
              latitude: latitude[i],
              longitude: longitude[i],
              title: _title[i],
              context: context),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: getAppBar(title: 'Maps', context: context),
        body: Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
              child: Text(
                'Tap on one of the points to Select Location',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.normal,
                    color: Colors.black),
              ),
            ),
            Expanded(
              child: GoogleMap(
                markers: _markers,
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(
                    target: LatLng(
                      30.3753,
                      69.3451,
                    ),
                    zoom: 5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
