import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shieldxworking/main.dart';
import 'package:shieldxworking/signuppage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shieldxworking/signin.dart';
import 'package:shieldxworking/signup.dart';
import 'package:shieldxworking/theme.dart';
import 'package:shieldxworking/bubbleindicator.dart';
import 'dart:ui';

  Color left = Colors.black;
  Color right = Colors.white;

class LoginPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<LoginPage> {
  
  
  void _signUp2() async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignUpPage())
    );
  }
  PageController? pageController;


  @override
  void dispose() {
    pageController?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: SingleChildScrollView(
        child: 
      Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: <Color>[
                  CustomTheme.loginGradientStart,
                  CustomTheme.loginGradientEnd
                ],
                begin: FractionalOffset(0.0, 0.0),
                end: FractionalOffset(1.0, 1.0),
                stops: <double>[0.0, 1.0],
                tileMode: TileMode.clamp),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 75.0),
                child: ClipRRect(
          borderRadius: BorderRadius.circular(20.0), // Rounded corners
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0), // Blur effect
            child: Container(
              width: MediaQuery.of(context).size.width * 0.35,
              height: MediaQuery.of(context).size.width * 0.15,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2), // Semi-transparent white color
                borderRadius: BorderRadius.circular(20.0), // Same as the ClipRRect border radius
                border: Border.all(
                  color: Colors.white.withOpacity(0.3), // Border color
                  width: 1.5,
                ),
              ),
              child: Center(
                child: Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 33,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: _buildMenuBar(context),
              ),
              Expanded(
                flex: 2,
                child: PageView(
                  controller: pageController,
                  physics: const ClampingScrollPhysics(),
                  onPageChanged: (int i) {
                    FocusScope.of(context).requestFocus(FocusNode());
                    if (i == 0) {
                      setState(() {
                        right = Colors.white;
                        left = Colors.black;
                      });
                    } else if (i == 1) {
                      setState(() {
                        right = Colors.black;
                        left = Colors.white;
                      });
                    }
                  },
                  children: <Widget>[
                    ConstrainedBox(
                      constraints: const BoxConstraints.expand(),
                      child: const SignIn(),
                    ),
                    ConstrainedBox(
                      constraints: const BoxConstraints.expand(),
                      child: const SignUp(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      )
      // Container(
      //   decoration: BoxDecoration(
      //     gradient: LinearGradient(
      //       colors: [Colors.black, Colors.blueGrey[800]!],
      //       begin: Alignment.topLeft,
      //       end: Alignment.bottomRight,
      //     ),
      //   ),
      //   padding: const EdgeInsets.all(16.0),
      //   child: Column(
      //     crossAxisAlignment: CrossAxisAlignment.stretch,
      //     children: [
      //       SizedBox(height: 40),
      //       TextField(
      //         controller: _emailController,
      //         style: TextStyle(color: Colors.white),
      //         decoration: InputDecoration(
      //           labelText: "Email",
      //           labelStyle: TextStyle(color: Colors.white70),
      //           border: OutlineInputBorder(),
      //           filled: true,
      //           fillColor: Colors.black54,
      //           focusColor: Colors.white,
      //         ),
      //       ),
      //       SizedBox(height: 16),
      //       TextField(
      //         controller: _passwordController,
      //         style: TextStyle(color: Colors.white),
      //         decoration: InputDecoration(
      //           labelText: "Password",
      //           labelStyle: TextStyle(color: Colors.white70),
      //           border: OutlineInputBorder(),
      //           filled: true,
      //           fillColor: Colors.black54,
      //           focusColor: Colors.white,
      //         ),
      //         obscureText: true,
      //       ),
      //       SizedBox(height: 20),
      //       ElevatedButton(
      //         onPressed: _signUp,
      //         style: ElevatedButton.styleFrom(
      //           primary: Colors.blueGrey[800],
      //           padding: EdgeInsets.symmetric(vertical: 16),
      //         ),
      //         child: Text("Login", style: TextStyle(color: Colors.white),),
      //       ),
      //       SizedBox(height: 50),
      //       Row(
      //         children: [
      //           Text(
      //             'New to ShieldX? ',
      //             style: TextStyle(color: Colors.white),
      //           ),
      //           ElevatedButton(
      //             onPressed: _signUp2,
      //             style: ElevatedButton.styleFrom(
      //               primary: Colors.blueGrey[600],
      //             ),
      //             child: Text("Signup", style: TextStyle(color: Colors.white),),
      //           ),
      //         ],
      //       ),
            
      //       if (_errorMessage.isNotEmpty)
      //         Padding(
      //           padding: const EdgeInsets.only(top: 16.0),
      //           child: Text(
      //             _errorMessage,
      //             style: TextStyle(color: Colors.red, fontSize: 16),
      //           ),
      //         ),
      //     ],
      //   ),
      // ),
    );
    
  }
  Widget _buildMenuBar(BuildContext context) {
    return Container(
      width: 300.0,
      height: 50.0,
      decoration: const BoxDecoration(
        color: Color(0x552B2B2B),
        borderRadius: BorderRadius.all(Radius.circular(25.0)),
      ),
      child: CustomPaint(
        painter: BubbleIndicatorPainter(pageController: pageController),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Expanded(
              child: TextButton(
                style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all(Colors.transparent),
                ),
                onPressed: _onSignInButtonPress,
                child: Text(
                  'Existing',
                  style: TextStyle(
                      color: left,
                      fontSize: 16.0,
                      fontFamily: 'WorkSansSemiBold'),
                ),
              ),
            ),
            //Container(height: 33.0, width: 1.0, color: Colors.white),
            Expanded(
              child: TextButton(
                style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all(Colors.transparent),
                ),
                onPressed: _onSignUpButtonPress,
                child: Text(
                  'New',
                  style: TextStyle(
                      color: right,
                      fontSize: 16.0,
                      fontFamily: 'WorkSansSemiBold'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  void _onSignInButtonPress() {
    pageController?.animateToPage(0,
        duration: const Duration(milliseconds: 500), curve: Curves.decelerate);
  }

  void _onSignUpButtonPress() {
    pageController?.animateToPage(1,
        duration: const Duration(milliseconds: 500), curve: Curves.decelerate);
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
