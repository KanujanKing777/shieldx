import 'package:flutter/material.dart';
import 'package:shieldxworking/main.dart';


class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            // Profile Picture
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage('https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png'), // Replace with your image asset or network image
            ),
            SizedBox(height: 16),
            // Name
            Text(
              '${user?.displayName?.split(' ')[0]}',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            // Email
            Text(
              '${user?.email}',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 16),
            // Divider
            Divider(),
            // Additional Info
            ListTile(
              leading: Icon(Icons.phone),
              title: Text('Emergency Contact No'),
              subtitle: TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: '${user?.displayName?.split(' ')[1]}',
            ),
            keyboardType: TextInputType.number,
          ),
            ),
            ListTile(
              leading: Icon(Icons.location_city),
              title: Text('Address'),
              subtitle: TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Realtime location',
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
            ElevatedButton(
      onPressed: () {
        // Define what happens when the button is pressed
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Data Saved"),
          ),
        );
      },
      style: ElevatedButton.styleFrom(
        primary: Colors.green, // Set the background color to green
        onPrimary: Colors.white, // Set the text color to white
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