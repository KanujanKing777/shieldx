import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:shieldxworking/main.dart';
import 'package:shieldxworking/latlong.dart';

class DataScreen extends StatefulWidget {
  final String problem;
  DataScreen({required this.problem});

  @override
  _DataScreenState createState() => _DataScreenState();
}

class _DataScreenState extends State<DataScreen>
    with SingleTickerProviderStateMixin {
  final DatabaseReference _database = FirebaseDatabase.instance.ref();
  late final Future<List<double>> data;
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isSendingData = true; 
  bool _isSearching = false; 
  bool _peopleFound = false; 

  @override
  void initState() {
    super.initState();
    data = LocationService().getCurrentLocation();
    _sendData();

    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    // Define the animation
    _animation = Tween<double>(begin: 50, end: 100).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _sendData() async {
    String? currentLocation = await data.toString();
    _database.child("patients").push().set({
      "name": user?.displayName ?? "Unknown",
      "problem": widget.problem,
      "currentLocation": currentLocation
    }).then((_) {
      print("Data sent successfully!");
      setState(() {
        _isSendingData = false; 
        _searchForNearbyPeople(); // Start searching for people nearby
      });
    }).catchError((error) {
      print("Failed to send data: $error");
      setState(() {
        _isSendingData = false; // Stop animation on error as well
      });
    });
  }

  void _searchForNearbyPeople() async {
    setState(() {
      _isSearching = true; 
    });

    // Extract the latitude and longitude from user's current location
    List<double> currentLocation = await data;
    double userLatitude = currentLocation[0];
    double userLongitude = currentLocation[1];

    _database.child("patients").once().then((DatabaseEvent event) {
      if (event.snapshot.exists) {
        final Map<dynamic, dynamic> patientsData =
            event.snapshot.value as Map<dynamic, dynamic>;

        for (var entry in patientsData.entries) {
          final Map<dynamic, dynamic> patient = entry.value;
          if (patient["currentLocation"] != null) {
            List<String> locationParts = patient["currentLocation"].split(',');
            double patientLatitude = double.parse(locationParts[0]);
            double patientLongitude = double.parse(locationParts[1]);

            // Check if the location is within the ±100 range
            if ((patientLatitude - userLatitude).abs() <= 100 &&
                (patientLongitude - userLongitude).abs() <= 100) {
              setState(() {
                _peopleFound = true; // People found
              });
              break;
            }
          }
        }
      }
      setState(() {
        _isSearching = false; 
      });
    }).catchError((error) {
      print("Error searching for nearby people: $error");
      setState(() {
        _isSearching = false; 
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Waiting for People Nearby'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); 
          },
        ),
      ),
      body: Center(
        child: _isSendingData || _isSearching
            ? AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return Container(
                    width: _animation.value,
                    height: _animation.value,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.blue.withOpacity(0.5),
                    ),
                    child: Center(
                      child: Text(
                        _isSendingData ? 'Sending data...' : 'Searching...',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                },
              )
            : Text(
                _peopleFound ? 'People found!' : 'No people nearby.',
                style: TextStyle(fontSize: 18, color: _peopleFound ? Colors.green : Colors.red),
              ),
      ),
    );
  }
}
