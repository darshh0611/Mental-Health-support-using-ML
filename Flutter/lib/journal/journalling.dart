import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg/svg.dart';
import '../colors.dart';

class JournallingPage extends StatefulWidget {
  @override
  _JournallingPageState createState() => _JournallingPageState();
}

class _JournallingPageState extends State<JournallingPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController notesController = TextEditingController();
  String selectedEmoji = '';
  String userId = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildEmojiContainer(),
              SizedBox(height: 20),
              _buildNotesContainer(),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _saveJournalEntry();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  primary: AppColors.secondaryblue,
                  onPrimary: Colors.white,
                  side: BorderSide(color: AppColors.secondaryblue, width: 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Center(
                    child: Text(
                      'Done',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.secondaryblue,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              _buildJournalEntries(),
            ],
          ),
        ),
      ),
    );
  }

  void _saveJournalEntry() {
    if (selectedEmoji.isNotEmpty && notesController.text.isNotEmpty) {
      String entry = '$selectedEmoji - ${notesController.text}';
      // Get the current timestamp
      Timestamp timestamp = Timestamp.now();
      // Get the current user's email
      String userEmail = FirebaseAuth.instance.currentUser!.email ?? '';
      // Save entry to Firestore collection with timestamp and user email
      _firestore.collection('journals').add({
        'userId': userId,
        'userEmail': userEmail, // Add userEmail field
        'emoji': selectedEmoji,
        'journal': notesController.text,
        'timestamp': timestamp, // Add timestamp field
      }).then((_) {
        // Clear the input fields
        setState(() {
          selectedEmoji = '';
          notesController.clear();
        });
        // Navigate back to the previous screen (JournalPage)
        Navigator.pop(context, entry);
      }).catchError((error) {
        print('Failed to save journal entry: $error');
      });
    }
  }



  Widget _buildEmojiContainer() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.secondaryblue),
        borderRadius: BorderRadius.circular(50),
      ),
      padding: EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildEmoji('😢', 'sad'),
          _buildEmoji('😐', 'neutral'),
          _buildEmoji('😊', 'happy'),
          _buildEmoji('😄', 'very happy'),
          _buildEmoji('😃', 'excited'),
        ],
      ),
    );
  }

  Widget _buildEmoji(String emoji, String emotion) {
    bool isSelected = selectedEmoji == emotion;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedEmoji = emotion;
        });
      },
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.secondaryblue : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          emoji,
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }

  Widget _buildNotesContainer() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.secondaryblue),
        borderRadius: BorderRadius.circular(30),
      ),
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'How do you feel today ?',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.secondaryblue,
            ),
          ),
          SizedBox(height: 10),
          TextField(
            controller: notesController,
            maxLines: 15,
            decoration: InputDecoration(
              hintText: 'Type your notes here...',
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: AppColors.secondaryblue),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget _buildJournalEntries() {
  //   return StreamBuilder<QuerySnapshot>(
  //     stream: _firestore.collection('journals').where('userId', isEqualTo: userId).snapshots(),
  //     builder: (context, snapshot) {
  //       if (snapshot.connectionState == ConnectionState.waiting) {
  //         return CircularProgressIndicator();
  //       } else if (snapshot.hasError) {
  //         return Text('Error: ${snapshot.error}');
  //       } else if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
  //         return Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: snapshot.data!.docs.map((doc) {
  //             return Text('${doc['emoji']} - ${doc['journal']}');
  //           }).toList(),
  //         );
  //       } else {
  //         return Text('No entries yet.');
  //       }
  //     },
  //   );
  // }
  Widget _buildJournalEntries() {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore
          .collection('journals')
          .where('userEmail', isEqualTo: FirebaseAuth.instance.currentUser!.email)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          print('Error: ${snapshot.error}');
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          final journals = snapshot.data!.docs;
          if (journals.isEmpty) {
            return Text('No entries yet.');
          }
          return ListView.builder(
            shrinkWrap: true,
            itemCount: journals.length,
            itemBuilder: (context, index) {
              final journal = journals[index].data() as Map<String, dynamic>;
              return ListTile(
                title: Text('${journal['emoji']} - ${journal['journal']}'),
              );
            },
          );
        } else {
          return Text('No entries yet.');
        }
      },
    );
  }




  AppBar appBar() {
    return AppBar(
      title: const Text(
        'Journal Your Thoughts :)',
        style: TextStyle(
          color: AppColors.secondaryblue,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: Colors.white,
      elevation: 0.0,
      centerTitle: true,
      leading: GestureDetector(
        onTap: () {},
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
              borderRadius: BorderRadius.circular(10),
            ),
            child: SvgPicture.asset(
              'assets/icons/dots.svg',
              height: 5,
              width: 5,
            ),
          ),
        ),
      ],
    );
  }
}
