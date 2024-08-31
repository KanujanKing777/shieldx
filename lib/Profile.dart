import 'package:flutter/material.dart';
import 'package:shieldxworking/latlong.dart';
import 'package:shieldxworking/main.dart';


class ProfilePage extends StatefulWidget {
  
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
    List<double> _location = [0.0, 0.0];

  @override
  void initState() {
    super.initState();
    _fetchLocation();
  }

  Future<void> _fetchLocation() async {
    LocationService locationService = LocationService(); 
    List<double> location = await locationService.getCurrentLocation();
    setState(() {
      _location = location;
    });
  }
  bool _showProfile = false;
  bool _accessLocation = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage('https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png'), // Replace with your image asset or network image
            ),
            SizedBox(height: 16),
            Text(
              '${user?.displayName?.split(' ')[0]}',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              '${user?.email}',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 16),
            Divider(),
            ListTile(
              leading: Icon(Icons.phone),
              title: Text('Emergency Contact No'),
              subtitle: TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: '${user?.displayName?.split(' ').last}',
            ),
            keyboardType: TextInputType.number,
          ),
            ),
            ListTile(
              leading: Icon(Icons.location_city),
              title: Text('Location'),
              subtitle: TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: '$_location',
            ),
            keyboardType: TextInputType.number,
            readOnly: true,
          ),
            ),
            ListTile(
              leading: Icon(Icons.work),
              title: Text('Occupation/Profession'),
              subtitle: TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: '${user?.photoURL}',
            ),
            keyboardType: TextInputType.text,
          ),
            ),
            CheckboxListTile(
            title: Text('Show My Profile'),
            value: _showProfile,
            onChanged: (bool? value) {
              setState(() {
                _showProfile = value ?? false;
              });
            },
          ),
          Divider(),
          CheckboxListTile(
            title: Text('Access Location'),
            value: _accessLocation,
            onChanged: (bool? value) {
              setState(() {
                _accessLocation = value ?? false;
              });
            },
          ),
          Divider(),
          
            ElevatedButton(
      onPressed: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Data Saved"),
          ),
        );
      },
      style: ElevatedButton.styleFrom(
        primary: Colors.green, 
        onPrimary: Colors.white, 
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        textStyle: TextStyle(fontSize: 16),
      ),
      child: Text("Save"),
    ),
          ],
        ),
      );
  }
}
