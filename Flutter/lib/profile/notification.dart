import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class NotificationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
          Text(
          'Notifications:',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Text(
            'Receive timely notifications for motivational quotes and your to-do list. Our mental health assistant app will deliver inspiring quotes to enhance your mood and motivation.'
                ' Additionally, you will get notifications for your to-do list to help you stay organized and productive.',
        style: TextStyle(fontSize: 16),
      ),
      SizedBox(height: 20),
      Text(
        'Benefits of Notifications:',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      SizedBox(height: 10),
      Text(
        'Our app provides notifications for both motivational quotes and to-do list reminders. These reminders are designed to boost your mood, motivation, and productivity by offering timely encouragement and organization support.',
        style: TextStyle(fontSize: 16),
      ),
      ],
    ),
    ),
    );
  }

  AppBar appBar() {
    return AppBar(
      leading: GestureDetector(
        onTap: () {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => ProfilePage()),
          // );
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
        'Get notified!',
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
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
      ],
    );
  }
}
