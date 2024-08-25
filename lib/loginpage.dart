import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
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
      // Sign-up successful
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
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            
            
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: "Email"),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: "Password"),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _signUp,
              child: Text("Login"),
            ),
            SizedBox(height: 50),
            Row(children: [Text('New to shieldx, '),
            ElevatedButton(
              onPressed: _signUp2,
              child: Text("Signup"),
            ),],),
            if (_errorMessage.isNotEmpty)
              Text(
                _errorMessage,
                style: TextStyle(color: Colors.red),
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