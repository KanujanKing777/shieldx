import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';

class LocationScreen extends StatefulWidget {
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  LocationData? _currentLocation;
  Location _location = Location();

  @override
  void initState() {
    super.initState();
    _initLocationTracking();
  }

  Future<void> _initLocationTracking() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await _location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await _location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await _location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _location.onLocationChanged.listen((LocationData locationData) {
      setState(() {
        _currentLocation = locationData;
      });
    });
  }
 MapController controller = MapController(
                            initPosition: GeoPoint(latitude: 9.66656, longitude: 80.0456704),
                            areaLimit: BoundingBox( 
                                east: 10.4922941, 
                                north: 47.8084648, 
                                south: 45.817995, 
                                west:  5.9559113,
                      ),
            );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Center(
        child: _currentLocation == null
            ? Text('Getting location...')
            : Column(
              children: [
                // Text(
                //   'Latitude: ${_currentLocation!.latitude}\nLongitude: ${_currentLocation!.longitude}',
                //   textAlign: TextAlign.center,
                // ),
                Expanded(child: 
                OSMFlutter( 
        controller:controller,
        osmOption: OSMOption(
              userTrackingOption: UserTrackingOption(
              enableTracking: true,
              unFollowUser: false,
            ),
            zoomOption: ZoomOption(
                  initZoom: 8,
                  minZoomLevel: 3,
                  maxZoomLevel: 19,
                  stepZoom: 1.0,
            ),
            userLocationMarker: UserLocationMaker(
                personMarker: MarkerIcon(
                    icon: Icon(
                        Icons.location_history_rounded,
                        color: Colors.red,
                        size: 48,
                    ),
                ),
                directionArrowMarker: MarkerIcon(
                    icon: Icon(
                        Icons.double_arrow,
                        size: 48,
                    ),
                ),
            ),
            roadConfiguration: RoadOption(
                    roadColor: Colors.yellowAccent,
            ),
            markerOption: MarkerOption(
                defaultMarker: MarkerIcon(
                    icon: Icon(
                      Icons.person_pin_circle,
                      color: Colors.blue,
                      size: 56,
                    ),
                )
            ),
        )
    ),)
              ])
      ),
    );
  }
  
  @override
    void dispose() {
    controller.dispose();
    super.dispose();
  }
}
