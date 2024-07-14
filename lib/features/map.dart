import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Polyline Example'),
      ),
      body: TextButton(
        onPressed: () async {
          PolylinePoints polylinePoints = PolylinePoints();
          PolylineResult result =
              await polylinePoints.getRouteBetweenCoordinates(
            googleApiKey: 'AIzaSyAR4tJT0ipvb2m2Ba95xbke-PomEZUzRRY',
            request: PolylineRequest(
              origin: const PointLatLng(29.432316, 30.696244),
              destination: const PointLatLng(29.428251, 30.698143),
              mode: TravelMode.driving,
              wayPoints: [
                PolylineWayPoint(location: "Sabo, Yaba Lagos Nigeria")
              ],
            ),
          );
          print(result.points);
        },
        child: const Text('sdlfls'),
      ),
    );
  }
}
