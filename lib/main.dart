import 'package:flutter/material.dart';
import 'package:shieldxworking/signuppage.dart';
import 'package:shieldxworking/textswitcher.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shieldxworking/Profile.dart';
import 'package:shieldxworking/settings.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';
import 'package:shieldxworking/realtime.dart';
import 'package:shieldxworking/loginpage.dart';


User? user;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await checkSession();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      home: user==null ? LoginPage() : MyHomePage(title: 'abc'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});


  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }
    int _currentIndex = 0;

   void onTappedBar(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
 
  
final List<Choice> choices = [
    Choice(title: 'Drowning', icon: Icons.water),
    Choice(title: 'Choking', icon: Icons.list_sharp),
    Choice(title: 'Heart Attack', icon: Icons.heart_broken),
    Choice(title: 'Animal Attack', icon: Icons.pets),
    Choice(title: 'Theft/Terrorist', icon: Icons.local_police),
    Choice(title: 'Others', icon: Icons.other_houses),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Shield X', style: TextStyle(color: Colors.white),),
        toolbarHeight: 95.0,
      ),
      body: (_currentIndex == 0) ? 
      Center(
        child: GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 4.0,
        mainAxisSpacing: 4.0,
      ),
      itemCount: choices.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            
              _showPopup(context, index);
            
          },
          child: Center(child: Card(
            color: Color.fromARGB(255, 17, 75, 123),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(choices[index].icon, size: 60.0, color: Colors.white),
                  Text(choices[index].title, style: TextStyle(color: Colors.white)),
                ],
              ),
            ),
          ),
        ));
      },
    )
      ) 
      : (_currentIndex == 1) ?
      LocationScreen()
      : (_currentIndex == 2) ?
      ProfilePage()
      :
      Center(child: SettingsPage(),),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.white,
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
        onTap: onTappedBar,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.call),
            label: 'Emergency',
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.gps_fixed),
            label: 'GPS',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          )
        ],
      ),
    );
  }
}
class Choice {
  const Choice({required this.title, required this.icon});
  final String title;
  final IconData icon;
}
void _showPopup(BuildContext context, index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Whom do you want to call'),
          actions: <Widget>[
            TextButton(
              child: Text('Emergency Contact'),
              onPressed: () {
                _makeEmergencyCall(1);
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Ambulence/Hospital nearby'),
              onPressed: () {
                _makeEmergencyCall(2);
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Experts/People nearby'),
              onPressed: () {
                Navigator.of(context).pop();
                showDialog(
                  context:context,
                  builder:(BuildContext context) {
                    return AlertDialog(
                  title: TextSwitcher(),
                );
                
              });
              },
            ),
          ],
        );
      },
    );
  }
  void _makeEmergencyCall(int a) async {
    String number = '011';
    if(a==1){
      number = '${user?.displayName?.split(' ')[1]}';
    }
    final Uri callUri = Uri(scheme: 'tel', path: number);
    if (await canLaunchUrl(callUri)) {
      await launchUrl(callUri);
    } else {
      // Handle the situation when the phone cannot make calls
      print('Could not launch $callUri');
    }
  }
