import 'package:flutter/material.dart';


class AnimalAttackPost extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('How to Handle Animal Attacks'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Image.network('https://cdn.mos.cms.futurecdn.net/BGHpe7iEEdztUaBPxfMVpH-1200-80.jpg'), // Add your image in the assets folder
            SizedBox(height: 16.0),
            Text(
              'Tips for Handling Animal Attacks:',
              style: Theme.of(context).textTheme.headline6,
            ),
            SizedBox(height: 8.0),
            Text(
              '1. Stay Calm: Avoid panicking or making sudden movements. Try to stay as calm as possible to assess the situation.\n\n'
              '2. Avoid Eye Contact: Direct eye contact can be perceived as a threat. Try to keep the animal in your peripheral vision.\n\n'
              '3. Back Away Slowly: If the animal is aggressive, slowly and steadily back away without turning your back.\n\n'
              '4. Use a Barrier: If possible, use objects like backpacks or jackets as a barrier between you and the animal.\n\n'
              '5. Make Noise: Loud noises can help scare the animal away. Yell, use a whistle, or bang objects together.\n\n'
              '6. Protect Yourself: If attacked, protect vital areas like your head and neck. Curl into a ball if necessary.\n\n'
              '7. Seek Medical Help: After an attack, seek medical attention immediately, especially if bitten or scratched.\n\n'
              '8. Report the Incident: Inform local authorities about the incident to prevent future attacks.',
              style: TextStyle(fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
  }
}
