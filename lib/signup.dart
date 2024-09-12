import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shieldxworking/theme.dart';
import 'package:shieldxworking/snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shieldxworking/main.dart';
import 'package:shieldxworking/loginpage.dart';
class SignUp extends StatefulWidget {
  const SignUp();

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
    final FirebaseAuth _auth = FirebaseAuth.instance;

  final FocusNode focusNodePassword = FocusNode();
  final FocusNode focusNodeConfirmPassword = FocusNode();
  final FocusNode focusNodeProfession = FocusNode();
  final FocusNode focusNodeEmergency = FocusNode();
  final FocusNode focusNodeEmail = FocusNode();
  final FocusNode focusNodeName = FocusNode();

  bool _obscureTextPassword = true;
  bool _obscureTextConfirmPassword = true;

  TextEditingController signupEmailController = TextEditingController();
  TextEditingController signupNameController = TextEditingController();
  TextEditingController signupPasswordController = TextEditingController();
  TextEditingController signupConfirmPasswordController =
      TextEditingController();
  TextEditingController signupProfessionController = TextEditingController();
  TextEditingController signupEmergencyController = TextEditingController();

  @override
  void dispose() {
    focusNodePassword.dispose();
    focusNodeConfirmPassword.dispose();
    focusNodeEmail.dispose();
    focusNodeName.dispose();
    super.dispose();
  }
String _errorMessage = '';

  void _signUp() async {
    setState(() {
      _errorMessage = '';
    });
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: signupEmailController.text.trim(),
        password: signupPasswordController.text.trim(),
      );
      user = userCredential.user;
      user?.updateDisplayName(signupNameController.text + ' ' + signupEmergencyController.text);     
      user?.updatePhotoURL(signupProfessionController.text);
      print("User signed up: ${userCredential.user?.email}");
    
      Navigator.pushAndRemoveUntil(
        context, 
        MaterialPageRoute(builder: (context) => LoginPage()),
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
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 23.0),
      child: Column(
        children: <Widget>[
          Stack(
            alignment: Alignment.topCenter,
            children: <Widget>[
              Card(
                elevation: 2.0,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
                        child: TextField(
                          focusNode: focusNodeName,
                          controller: signupNameController,
                          keyboardType: TextInputType.text,
                          textCapitalization: TextCapitalization.words,
                          autocorrect: false,
                          style: const TextStyle(
                              fontFamily: 'WorkSansSemiBold',
                              fontSize: 16.0,
                              color: Colors.black),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            icon: Icon(
                              FontAwesomeIcons.user,
                              color: Colors.black,
                            ),
                            hintText: 'Name',
                            hintStyle: TextStyle(
                                fontFamily: 'WorkSansSemiBold', fontSize: 16.0, color: Colors.black),
                          ),
                          onSubmitted: (_) {
                            focusNodeEmail.requestFocus();
                          },
                        ),
                      ),
                      Container(
                        width: 250.0,
                        height: 1.0,
                        color: Colors.grey[400],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
                        child: TextField(
                          focusNode: focusNodeEmail,
                          controller: signupEmailController,
                          keyboardType: TextInputType.emailAddress,
                          autocorrect: false,
                          style: const TextStyle(
                              fontFamily: 'WorkSansSemiBold',
                              fontSize: 16.0,
                              color: Colors.black),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            icon: Icon(
                              FontAwesomeIcons.envelope,
                              color: Colors.black,
                            ),
                            hintText: 'Email Address',
                            hintStyle: TextStyle(
                                fontFamily: 'WorkSansSemiBold', fontSize: 16.0, color: Colors.black),
                          ),
                          onSubmitted: (_) {
                            focusNodePassword.requestFocus();
                          },
                        ),
                      ),
                      Container(
                        width: 250.0,
                        height: 1.0,
                        color: Colors.grey[400],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
                        child: TextField(
                          focusNode: focusNodeProfession,
                          controller: signupProfessionController,
                          keyboardType: TextInputType.text,
                          textCapitalization: TextCapitalization.words,
                          autocorrect: false,
                          style: const TextStyle(
                              fontFamily: 'WorkSansSemiBold',
                              fontSize: 16.0,
                              color: Colors.black),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            icon: Icon(
                              FontAwesomeIcons.userDoctor,
                              color: Colors.black,
                            ),
                            hintText: 'Profession',
                            hintStyle: TextStyle(
                                fontFamily: 'WorkSansSemiBold', fontSize: 16.0, color: Colors.black),
                          ),
                          onSubmitted: (_) {
                            focusNodeEmail.requestFocus();
                          },
                        ),
                      ),
                      Container(
                        width: 250.0,
                        height: 1.0,
                        color: Colors.grey[400],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
                        child: TextField(
                          focusNode: focusNodeEmergency,
                          controller: signupEmergencyController,
                          keyboardType: TextInputType.text,
                          textCapitalization: TextCapitalization.words,
                          autocorrect: false,
                          style: const TextStyle(
                              fontFamily: 'WorkSansSemiBold',
                              fontSize: 16.0,
                              color: Colors.black),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            icon: Icon(
                              FontAwesomeIcons.skull,
                              color: Colors.black,
                            ),
                            hintText: 'Emergency Contact No',
                            hintStyle: TextStyle(
                                fontFamily: 'WorkSansSemiBold', fontSize: 16.0, color: Colors.black),
                          ),
                          onSubmitted: (_) {
                            focusNodeEmail.requestFocus();
                          },
                        ),
                      ),
                      Container(
                        width: 250.0,
                        height: 1.0,
                        color: Colors.grey[400],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
                        child: TextField(
                          focusNode: focusNodePassword,
                          controller: signupPasswordController,
                          obscureText: _obscureTextPassword,
                          autocorrect: false,
                          style: const TextStyle(
                              fontFamily: 'WorkSansSemiBold',
                              fontSize: 16.0,
                              color: Colors.black),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            icon: const Icon(
                              FontAwesomeIcons.lock,
                              color: Colors.black,
                            ),
                            hintText: 'Password',
                            hintStyle: const TextStyle(
                                fontFamily: 'WorkSansSemiBold', fontSize: 16.0, color: Colors.black),
                            suffixIcon: GestureDetector(
                              onTap: _toggleSignup,
                              child: Icon(
                                _obscureTextPassword
                                    ? FontAwesomeIcons.eye
                                    : FontAwesomeIcons.eyeSlash,
                                size: 15.0,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          onSubmitted: (_) {
                            focusNodeConfirmPassword.requestFocus();
                          },
                        ),
                      ),
                      Container(
                        width: 250.0,
                        height: 1.0,
                        color: Colors.grey[400],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
                        child: TextField(
                          focusNode: focusNodeConfirmPassword,
                          controller: signupConfirmPasswordController,
                          obscureText: _obscureTextConfirmPassword,
                          autocorrect: false,
                          style: const TextStyle(
                              fontFamily: 'WorkSansSemiBold',
                              fontSize: 16.0,
                              color: Colors.black),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            icon: const Icon(
                              FontAwesomeIcons.lock,
                              color: Colors.black,
                            ),
                            hintText: 'Confirmation',
                            hintStyle: const TextStyle(
                                fontFamily: 'WorkSansSemiBold', fontSize: 16.0, color: Colors.black),
                            suffixIcon: GestureDetector(
                              onTap: _toggleSignupConfirm,
                              child: Icon(
                                _obscureTextConfirmPassword
                                    ? FontAwesomeIcons.eye
                                    : FontAwesomeIcons.eyeSlash,
                                size: 15.0,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          onSubmitted: (_) {
                            _toggleSignUpButton();
                          },
                          textInputAction: TextInputAction.go,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin:  EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.59),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: CustomTheme.loginGradientStart,
                      offset: Offset(1.0, 6.0),
                      blurRadius: 20.0,
                    ),
                    BoxShadow(
                      color: CustomTheme.loginGradientEnd,
                      offset: Offset(1.0, 6.0),
                      blurRadius: 20.0,
                    ),
                  ],
                  gradient: LinearGradient(
                      colors: <Color>[
                        CustomTheme.loginGradientEnd,
                        CustomTheme.loginGradientStart
                      ],
                      begin: FractionalOffset(0.2, 0.2),
                      end: FractionalOffset(1.0, 1.0),
                      stops: <double>[0.0, 1.0],
                      tileMode: TileMode.clamp),
                ),
                child: MaterialButton(
                  highlightColor: Colors.transparent,
                  splashColor: CustomTheme.loginGradientEnd,
                  //shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
                  child: const Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 42.0),
                    child: Text(
                      'SIGN UP',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25.0,
                          fontFamily: 'WorkSansBold'),
                    ),
                  ),
                  onPressed: () {
                     _toggleSignUpButton();
                     _signUp();
                  },
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  void _toggleSignUpButton() {
    CustomSnackBar(context, const Text('SignUp button pressed'));
  }

  void _toggleSignup() {
    setState(() {
      _obscureTextPassword = !_obscureTextPassword;
    });
  }

  void _toggleSignupConfirm() {
    setState(() {
      _obscureTextConfirmPassword = !_obscureTextConfirmPassword;
    });
  }
}
