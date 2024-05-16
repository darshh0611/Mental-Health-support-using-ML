import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../home.dart';
import 'feed.dart';

class QuotePage extends StatefulWidget {
  @override
  _QuotePageState createState() => _QuotePageState();
}

class _QuotePageState extends State<QuotePage> {
  String quote = '';

  @override
  void initState() {
    super.initState();
    fetchQuote();
  }

  Future<void> fetchQuote() async {
    try {
      final response = await http.get(
        Uri.parse('https://famous-quotes4.p.rapidapi.com/random?category=all&count=1'),
        headers: {
          'X-RapidAPI-Key': 'fb3477a566mshc1dde9b3caee813p163f63jsne69794155513',
          'X-RapidAPI-Host': 'famous-quotes4.p.rapidapi.com',
        },
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body) as List<dynamic>;
        if (jsonData.isNotEmpty) {
          final quoteContent = jsonData[0]['text'];
          setState(() {
            quote = quoteContent is String ? quoteContent : 'Failed to load quote';
          });
        } else {
          throw Exception('Empty data');
        }
      } else {
        throw Exception('Failed to load quote - ${response.statusCode}');
      }
    } catch (error) {
      print(error);
      throw Exception('Failed to load quote');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: Stack(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Quotes for you!',
                    style: TextStyle(
                      fontSize: 24, // Increased font size
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.blue, // Set your primary color here
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.all(16),
                    child: Text(
                      quote.isNotEmpty ? '"$quote"' : 'Loading...',
                      style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Image.asset(
              'assets/icons/flower.png', // Adjust the image path accordingly
              width: 80, // Set width as needed
              height: 80, // Set height as needed
            ),
          ),
        ],
      ),
    );
  }
  AppBar appBar() {
    return AppBar(
      leading: GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(userId: '',)));
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
        'Quotes',
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
