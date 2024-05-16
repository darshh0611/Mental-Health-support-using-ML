import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ipd/authentication/onboarding.dart';

import '../colors.dart';
import '../home.dart';
import 'sign_up.dart'; // Import SignUpPage for navigation to the signup page

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login(BuildContext context) async {
    final String email = _emailController.text.trim();
    final String password = _passwordController.text.trim();

    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage(userId: userCredential.user!.uid)),
        );
      }
    } catch (error) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Login Failed'),
            content: Text(error.toString()),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  Future<void> _signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return; // User cancelled sign-in

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential = await _auth.signInWithCredential(credential);
      if (userCredential.user != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage(userId: userCredential.user!.uid)),
        );
      }
    } catch (error) {
      print('Google Sign-In Error: $error');
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Google Sign-In Failed'),
            content: Text(error.toString()),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: AppColors.secondaryblue,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background_feed.jpeg"),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 30),
                Container(
                  child: Text(
                    'IPD PROJECT',
                    style: GoogleFonts.poppins(fontSize: 40, color: Colors.white),
                  ),
                ),
                SizedBox(height: 5),
                Container(
                  child: Text(
                    'Your mental health assistant :)',
                    style: GoogleFonts.poppins(fontSize: 20, color: Colors.white),
                  ),
                ),
                SizedBox(height: 130),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Colors.white, width: 3),
                  ),
                  child: TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(16.0),
                      hintText: 'Email',
                      hintStyle: GoogleFonts.poppins(fontSize: 16, color: Colors.white),
                    ),
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Colors.white, width: 3),
                  ),
                  child: TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(16.0),
                      hintText: 'Password',
                      hintStyle: GoogleFonts.poppins(fontSize: 16, color: Colors.white),
                    ),
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(height: 16),
                Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.white,
                  ),
                  child: MaterialButton(
                    onPressed: () => _login(context),
                    child: Text(
                      'Log In',
                      style: GoogleFonts.poppins(fontSize: 16, color: Colors.black),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => OnboardingScreen()),
                    );
                  },
                  child: Text(
                    'New here ? Create new account :D',
                    style: GoogleFonts.poppins(fontSize: 16, color: Colors.white),
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'Other Sign-in Methods',
                  style: GoogleFonts.poppins(fontSize: 16, color: Colors.white),
                ),
                SizedBox(height: 16),
                Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.white,
                  ),
                  child: MaterialButton(
                    onPressed: () => _signInWithGoogle(context),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/google_login.png',
                          height: 20,
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Sign in with Google',
                          style: GoogleFonts.poppins(fontSize: 16, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 150),
                Center(
                  child: Text(
                    "Built with ❤️",
                    textScaleFactor: 1,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(fontSize: 16, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
