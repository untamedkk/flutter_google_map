import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_example/model/poeple_list.dart';
import 'package:map_example/widgets/map_widget.dart';

class PeopleMapViewWidget extends StatelessWidget {
  final List<People> peoples;
  final bool enableMarkerClick;

  PeopleMapViewWidget(this.peoples, {this.enableMarkerClick = true});

  @override
  Widget build(BuildContext context) {
    LatLng _center;
    /**
     * A normal work around if any lat or long is null set it to 0. As some of data having null values.
     */
    if (peoples.length == 1) {
      var lat = peoples[0].location.lat ?? 0.0;
      var long = peoples[0].location.long ?? 0.0;
      _center = LatLng(lat, long);
    } else {
      final index = peoples.length ~/ 2;
      var lat = peoples[index].location.lat ?? 0.0;
      var long = peoples[index].location.long ?? 0.0;
      _center = LatLng(lat, long);
    }
    return MapWidget(
      peoples: peoples,
      enableMarkerClick: enableMarkerClick,
      center: _center,
    );
  }
}
