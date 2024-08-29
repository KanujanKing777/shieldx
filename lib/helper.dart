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

class _DataScreenState extends State<DataScreen> {
  final DatabaseReference _database = FirebaseDatabase.instance.ref();
  late final Future<List<double>> data;

  @override
  void initState() {
    super.initState();
    data = LocationService().getCurrentLocation();
    _sendData();
  }

  void _sendData() async {
    print("\n\n\nHello\n\n\n");
    String? currentLocation = await data.toString();
    _database.child("patients").push().set({
      "name": user?.displayName ?? "Unknown",
      "problem": widget.problem,
      "currentLocation": currentLocation
    }).then((_) {
      print("Data sent successfully!");
    }).catchError((error) {
      print("Failed to send data: $error");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Sending data...'));
  }
}
