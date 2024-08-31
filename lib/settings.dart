import 'package:flutter/material.dart';
import 'package:shieldxworking/main.dart';


class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _showProfile = false;
  bool _accessLocation = false;

  @override
  Widget build(BuildContext context) {
    return ListView(
        padding: EdgeInsets.all(16.0),
        children: [
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
          Text('Emergency Contact No'),
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: '${user?.displayName?.split(' ')[1]}',
            ),
            keyboardType: TextInputType.number,
          ),
        //   Divider(),
        //   TextField(
        //     decoration: InputDecoration(
        //       border: OutlineInputBorder(),
        //       hintText: 'Ambulence/Nearby hospital No',
        //     ),
        //     keyboardType: TextInputType.number,
        //   )
         ],
      );
  }
}
