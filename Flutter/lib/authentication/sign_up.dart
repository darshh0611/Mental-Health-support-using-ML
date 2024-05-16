import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ipd/colors.dart';

import 'login.dart'; // Import LoginPage for navigation

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _signUp(BuildContext context) async {
    final String name = _nameController.text.trim();
    final String email = _emailController.text.trim();
    final String password = _passwordController.text.trim();

    try {
      // Validate email format
      if (email.isEmpty || !email.contains('@')) {
        throw 'Invalid email address';
      }

      // Create user with email and password
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Save user data to Firestore
      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'name': name,
        'email': email,
        // Add more fields as needed
      });
      print("Sign up yeahhhhh");
      // Navigate to login page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    } catch (error) {
      print('Sign up error: $error');
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Sign Up Failed'),
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
      backgroundColor: AppColors.secondaryblue,
      appBar: appBar(),
      body: SingleChildScrollView(
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
                  controller: _nameController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(16.0),
                    hintText: 'Name',
                    hintStyle: GoogleFonts.poppins(fontSize: 16, color: Colors.white),
                  ),
                  style: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(height: 20),
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
                ),
              ),
              SizedBox(height: 20),
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
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.white,
                ),
                child: MaterialButton(
                  onPressed: () {
                    _signUp(context);
                  },
                  child: Text('Sign Up',style: GoogleFonts.poppins(fontSize: 16, color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  AppBar appBar() {
    return AppBar(
      leading: GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
        },
        child: Container(
          margin: const EdgeInsets.all(10),
          alignment: Alignment.center,
          width: 37,
          child: SvgPicture.asset(
            'assets/icons/Arrow - Left 2.svg',
            height: 25,
            width: 25,
          ),
          decoration: BoxDecoration(
            color: const Color(0xffF7F8F8),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      title: const Text(
        'Sign Up',
        style: TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: Colors.white,
      elevation: 0.0,
      centerTitle: true,
      actions: [
        GestureDetector(
          onTap: () {},
          child: Container(
            margin: const EdgeInsets.all(10),
            alignment: Alignment.center,
            width: 37,
            child: SvgPicture.asset(
              'assets/icons/dots.svg',
              height: 5,
              width: 5,
            ),
            decoration: BoxDecoration(
              color: const Color(0xffF7F8F8),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ],
    );
  }
}
