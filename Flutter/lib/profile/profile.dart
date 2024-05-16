import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ipd/colors.dart';
import 'package:ipd/general/customButton.dart';
import 'package:ipd/profile/notification.dart';

import '../authentication/login.dart';
import '../general/styleCard.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Your happy, Profile',
          style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {

          },
          // child: Container(
          //   margin: const EdgeInsets.all(10),
          //   alignment: Alignment.center,
          //   child: SvgPicture.asset(
          //     'assets/icons/Arrow - Left 2.svg',
          //     height: 20,
          //     width: 20,
          //   ),
          //   decoration: BoxDecoration(
          //       color: const Color(0xffF7F8F8),
          //       borderRadius: BorderRadius.circular(10)
          //   ),
          // ),
        ),
        actions: [
           GestureDetector(
              onTap: () {},
              child: Container(
                margin: const EdgeInsets.all(10),
                alignment: Alignment.center,
                width: 37,
                decoration: BoxDecoration(
                    color: const Color(0xffF7F8F8),
                    borderRadius: BorderRadius.circular(10)
                ),
                child: SvgPicture.asset(
                  'assets/icons/dots.svg',
                  height: 5,
                  width: 5,
                ),
              ),
            ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              child: Container(
                height: 100,
                child: const Center(
                  child: CircleAvatar(
                    backgroundColor: AppColors.secondary,
                    radius: 50,
                    child: Text(
                      'Pictcha!',
                      style: TextStyle(fontSize: 25, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),

            StyleCard(
              title: "Profile",
              img: "assets/icons/profile.svg",
              onTap: () {
              },
              bgColor: AppColors.primary,
              textColor: AppColors.white,
              description: "Check out your profile!",
            ),
            SizedBox(
              height: 5,
            ),
            StyleCard(
              title: "Notification",
              img: "assets/icons/notfication.svg",
              onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => NotificationPage()));
              },
              bgColor: AppColors.primary,
              textColor: AppColors.white,
              description: "Ting ting!",
            ),
            SizedBox(
              height: 15,
            ),
            StyleCard(
              title: "Settings",
              img: "assets/icons/settings.svg",
              onTap: () {
              },
              bgColor: AppColors.primary,
              textColor: AppColors.white,
              description: "Customize for yourself",
            ),
            SizedBox(
              height: 15,
            ),
            StyleCard(
              title: "Help Centre",
              img: "assets/icons/question.svg",
              onTap: () {
              },
              bgColor: AppColors.primary,
              textColor: AppColors.white,
              description: "Here to help!",
            ),
            SizedBox(
              height: 15,
            ),
            StyleCard(
              title: "Log Out",
              img: "assets/icons/logout.svg",
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
              },
              bgColor: AppColors.primary,
              textColor: AppColors.white,
              description: "See you soon!",
            ),
            SizedBox(
              height: 15,
            ),
            StyleCard(
              title: "Delete Account",
              img: "assets/icons/delete.svg",
              onTap: () async {
                // Show confirmation dialog
                bool confirmDelete = await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("Confirmation"),
                      content: Text("Are you sure you want to delete your account?"),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(false); // Return false if cancel
                          },
                          child: Text("Cancel"),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(true); // Return true if confirm
                          },
                          child: Text("Delete"),
                        ),
                      ],
                    );
                  },
                );

                // If user confirmed deletion
                if (confirmDelete ?? false) {
                  // Get the current user
                  User? user = FirebaseAuth.instance.currentUser;

                  // Delete user from Firebase Authentication
                 //try {
                    await user!.delete();

                    // Delete user data from Firestore
                    //await FirebaseFirestore.instance.collection('users').doc(user.uid).delete();

                    // Navigate to the login page after successful deletion
                     Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
                  // } catch (e) {
                  //   // Handle errors, e.g., display an error message to the user
                  //   print("Error deleting account: $e");
                  //   showDialog(
                  //     context: context,
                  //     builder: (context) {
                  //       return AlertDialog(
                  //         title: Text('Error'),
                  //         content: Text('Failed to delete account. Please try again later.'),
                  //         actions: [
                  //           TextButton(
                  //             onPressed: () {
                  //               Navigator.pop(context);
                  //             },
                  //             child: Text('OK'),
                  //           ),
                  //         ],
                  //       );
                  //     },
                  //   );
                  // }
                }
              },


              bgColor: AppColors.primary,
              textColor: AppColors.white,
              description: ":(",
            ),


            SizedBox(
              height: 15,
            ),

          ],
        ),

      )
    );
  }
}
