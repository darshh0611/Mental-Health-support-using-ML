import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';

import '../colors.dart';
import '../home.dart';

class Podcast {
  String title;
  String link;

  Podcast({
    required this.title,
    required this.link,
  });
}
// podcasts:
// for Procrastination
// 1) the joy of procrastination
// 2) Beyond the to-do list
//
// For anxiety:
// 1)The hardcore self-help podcast
// 2)Not another anxiety show
//
// For making a big life change:
// 1) What it takes
// 2) The tony robbins podcast
class podcast extends StatelessWidget {
  // Hardcoded list of Book objects
  final List<Podcast> books = [
    Podcast(title: 'The joy of procrastination', link: 'https://youtu.be/jXZAbnn1kTU?si=evUMEDBgDs2HnuvG'),
    Podcast(title: 'Beyond the to-do list', link: 'https://www.youtube.com/live/HbX-BjwjaHM?si=9cMMR7sDuNho0kR8'),
    Podcast(title: 'The hardcore self-help podcast', link: 'https://youtu.be/bP9gMpl1gyQ?si=mFNYN7DDIR98RhPo'),
    Podcast(title: 'Not another anxiety show', link: 'https://youtu.be/jXZAbnn1kTU?si=evUMEDBgDs2HnuvG'),
    Podcast(title: 'What it takes', link: 'https://www.youtube.com/live/HbX-BjwjaHM?si=9cMMR7sDuNho0kR8'),
    Podcast(title: 'The tony robbins podcast', link: 'https://youtu.be/bP9gMpl1gyQ?si=mFNYN7DDIR98RhPo')

    // Add more books as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar(),
        body: ListView.builder(
          itemCount: books.length,
          itemBuilder: (context, index) {
            return Container(
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.primary), // Border color
                borderRadius: BorderRadius.circular(10), // Border radius
              ),
              margin: EdgeInsets.all(10), // Margin around the container
              child: ListTile(
                title: Text(books[index].title),
                onTap: () {
                  _launchURL(books[index].link); // Open the URL when ListTile is tapped
                },
              ),
            );
          },
        )

    );
  }

  // Function to launch URL in a web browser
  _launchURL(String url) async {
    try {
      await launch(url); // Launch the provided URL
    } catch (e) {
      print('Error launching URL: $e');
    }
  }
  AppBar appBar() {
    return AppBar(
      leading: GestureDetector(
        onTap: () {
          //   Navigator.push(
          //       context, MaterialPageRoute(builder: (context) => HomePage()));
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
        'Get Relaxed : )',
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

