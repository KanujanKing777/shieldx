import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_map/flutter_map.dart'; 
import 'package:latlong2/latlong.dart' as latlng; 

void main() {
  runApp(SafeWalkApp());
}

class SafeWalkApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeWalkScreen(),
    );
  }
}

class SafeWalkScreen extends StatefulWidget {
  @override
  _SafeWalkScreenState createState() => _SafeWalkScreenState();
}

class _SafeWalkScreenState extends State<SafeWalkScreen> {
  latlng.LatLng _currentPosition = latlng.LatLng(0.0, 0.0);
  List<latlng.LatLng> _routeCoordinates = [];
  final MapController _mapController = MapController();

  @override
  void initState() {
    super.initState();
    _startLocationTracking();
  }

  Future<void> _startLocationTracking() async {
    Geolocator.getPositionStream().listen((Position position) {
      setState(() {
        _currentPosition = latlng.LatLng(position.latitude, position.longitude);
        _routeCoordinates.add(_currentPosition);
      });
      _mapController.move(_currentPosition, 14.0);
    });
  }

  void _shareLocationWithContacts() {
    print('Sharing location with contacts...');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: FlutterMap(
        mapController: _mapController,
        options: MapOptions(
          center: _currentPosition,
          zoom: 14.0,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: ['a', 'b', 'c'],
            
          ),
          MarkerLayer(
            markers: [
              Marker(
                width: 80.0,
                height: 80.0,
                point: _currentPosition,
                child: Icon(
                  Icons.location_pin,
                  color: Colors.red,
                  size: 40.0,
                ),
              ),
            ],
          ),
          PolylineLayer(
            polylines: [
              Polyline(
                points: _routeCoordinates,
                strokeWidth: 4.0,
                color: Colors.blue,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class LocationService {
  static final LocationService _instance = LocationService._internal();

  factory LocationService() {
    return _instance;
  }

  LocationService._internal();

  Future<List<double>> getCurrentLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        await Geolocator.openLocationSettings();
        return [0.0, 0.0];
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return [0.0, 0.0];
        }
      }

      if (permission == LocationPermission.deniedForever) {
        return [0.0, 0.0];
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      return [position.latitude, position.longitude];
    } catch (e) {
      print("Error getting location: $e");
      return [0.0, 0.0];
    }
  }
}
