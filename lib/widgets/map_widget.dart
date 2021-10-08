import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_example/model/poeple_list.dart';
import 'package:map_example/person_details/person_details_screen.dart';

class MapWidget extends StatefulWidget {
  final List<People> peoples;
  final bool enableMarkerClick;
  final LatLng center;

  MapWidget({this.peoples, this.enableMarkerClick = true, this.center});

  @override
  _MapWidgetState createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  Set<Marker> _markers = Set();
  Completer<GoogleMapController> _controller = Completer();

  @override
  void initState() {
    if (widget.peoples == null || widget.peoples == null) {
      throw Exception("Person list cannot be null.");
    }
    Marker resultMarker;
    People people;
    for (var i = 0; i < widget.peoples.length; i++) {
      people = widget.peoples[i];
      var location = people.location;
      var name = people.name.first + ' ' + people.name.last;
      if (location.lat != null && location.long != null) {
        resultMarker = Marker(
            markerId: MarkerId(i.toString()),
            infoWindow: InfoWindow(
              title: name,
              onTap: () => widget.enableMarkerClick ? _onMarkerTapped(i) : null,
            ),
            position: LatLng(location.lat, location.long));
        _markers.add(resultMarker);
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      onMapCreated: _onMapCreated,
      initialCameraPosition: CameraPosition(
        target: widget.center,
        zoom: 9.0,
      ),
      markers: _markers,
    );
  }

  void _onMapCreated(GoogleMapController controller) =>
      _controller.complete(controller);

  void _onMarkerTapped(int index) =>
      PersonDetailsScreen.open(context, widget.peoples[index]);
}
