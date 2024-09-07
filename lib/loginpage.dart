import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shieldxworking/main.dart';
import 'package:shieldxworking/signuppage.dart';
import 'package:shared_preferences/shared_preferences.dart';



class LoginPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<LoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _errorMessage = '';

  void _signUp() async {
    setState(() {
      _errorMessage = '';
    });
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      final prefs = await SharedPreferences.getInstance();
  final loginTime = DateTime.now().toIso8601String();
  await prefs.setString('login_time', loginTime);
      print("User Logged in: ${userCredential.user?.email}");
      user = userCredential.user;
      Navigator.pushAndRemoveUntil(
        context, 
        MaterialPageRoute(builder: (context) => MyHomePage(title: 'title',)),
        (Route<dynamic> route) => false,);
    } on FirebaseAuthException catch (e) {
      setState(() {
        _errorMessage = e.message ?? 'An unknown error occurred';
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'An unknown error occurred';
      });
    }
  }
  
  void _signUp2() async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignUpPage())
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Log In'),
        backgroundColor: Colors.black.withOpacity(0.8),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.black, Colors.blueGrey[800]!],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 40),
            TextField(
              controller: _emailController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: "Email",
                labelStyle: TextStyle(color: Colors.white70),
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.black54,
                focusColor: Colors.white,
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: "Password",
                labelStyle: TextStyle(color: Colors.white70),
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.black54,
                focusColor: Colors.white,
              ),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _signUp,
              style: ElevatedButton.styleFrom(
                primary: Colors.blueGrey[800],
                padding: EdgeInsets.symmetric(vertical: 16),
              ),
              child: Text("Login", style: TextStyle(color: Colors.white),),
            ),
            SizedBox(height: 50),
            Row(
              children: [
                Text(
                  'New to ShieldX? ',
                  style: TextStyle(color: Colors.white),
                ),
                ElevatedButton(
                  onPressed: _signUp2,
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blueGrey[600],
                  ),
                  child: Text("Signup", style: TextStyle(color: Colors.white),),
                ),
              ],
            ),
            TextButton(onPressed: (){
              _emailController.text = "kanujan@gmail.com";
              _passwordController.text = "pira2512";
              _signUp();
            }, child: Text("Singin with a Demo Account")),
            if (_errorMessage.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(
                  _errorMessage,
                  style: TextStyle(color: Colors.red, fontSize: 16),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
Future<void> checkSession() async {
  final prefs = await SharedPreferences.getInstance();
  final loginTime = prefs.getString('login_time');
  
  if (loginTime != null) {
    final loginDateTime = DateTime.parse(loginTime);
    final currentDateTime = DateTime.now();
    
    if (currentDateTime.difference(loginDateTime).inDays >= 7) {
      // Session expired, prompt user to re-login
      await FirebaseAuth.instance.signOut();
    }
  }
}