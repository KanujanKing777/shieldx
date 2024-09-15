import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shieldxworking/Profile.dart';
import 'package:shieldxworking/settings.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';
import 'package:shieldxworking/loginpage.dart';
import 'package:shieldxworking/helper.dart';
import 'package:shieldxworking/animalattack.dart';
import 'package:shieldxworking/safewalk.dart';
import 'package:shieldxworking/chatbot.dart';

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
      SafeWalkScreen()
      : (_currentIndex == 2) ?
      ProfilePage()
      :
      Center(child: SettingsPage(),),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ChatScreen()),
          );
        },
        child: Icon(Icons.chat),
        backgroundColor: Colors.blue[700],
      ),
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
List<String> problems = ["Drowning", "Choking", "Heart Attack", "Animal Attack", 
  "Theft/Terrorist", "Others"];
void _showPopup(BuildContext context, index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {

Widget _buildDialogButton(
  BuildContext context,
  String label,
  Color color,
  VoidCallback onPressed,
) {
  return TextButton(
    child: Text(
      label,
      style: TextStyle(
        color: color,
        fontSize: 17.0
      ),
    ),
    onPressed: onPressed,
  );
}

return AlertDialog(
  title: Text(
    'Choose an option below to get assistance',
    style: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: Color.fromARGB(255, 205, 205, 205)
    ),
  ),
  backgroundColor: const Color.fromARGB(255, 9, 9, 9),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(15),
  ),
  actions: <Widget>[
    _buildDialogButton(
      context,
      'Emergency Contact',
      const Color.fromARGB(255, 248, 124, 116),
      () {
        _makeEmergencyCall(1);
        Navigator.of(context).pop();
      },
    ),
    _buildDialogButton(
      context,
      'Ambulance/Hospital Nearby',
      const Color.fromARGB(255, 108, 184, 247),
      () {
        _makeEmergencyCall(2);
        Navigator.of(context).pop();
      },
    ),
    _buildDialogButton(
      context,
      'Experts/People Nearby',
      const Color.fromARGB(255, 141, 249, 145),
      () {
        Navigator.of(context).pop();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DataScreen(problem: problems[index]),
          ),
        );
      },
    ),
    _buildDialogButton(
      context,
      'Info for First Aid',
      const Color.fromARGB(255, 252, 203, 128),
      () {
        Navigator.of(context).pop();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AnimalAttackPost(),
          ),
        );
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
